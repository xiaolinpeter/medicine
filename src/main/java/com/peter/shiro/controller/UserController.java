package com.peter.shiro.controller;

import com.peter.shiro.context.BaseReturn;
import com.peter.shiro.context.ErrorCode;
import com.peter.shiro.context.SessionParam;
import com.peter.shiro.kit.ShiroKit;
import com.peter.shiro.model.User;
import com.peter.shiro.model.Ztree;
import com.peter.shiro.service.DataService;
import com.peter.shiro.service.ZtreeService;
import com.peter.shiro.util.DataStatusEnum;
import com.peter.shiro.util.UUIDGenerator;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/admin/user")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    @Autowired 
    private DataService dataService;
    
    @Autowired 
    private ZtreeService ztreeService;
    
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String list(Model model){
    	JSONArray userArray = dataService.toJSONArray("select * from t_user where status > ? order by createDate desc", DataStatusEnum.DElETED.getValue());
    	JSONArray userList = new JSONArray();
    	for (int i = 0; i < userArray.length(); i++) {
			JSONObject user = userArray.optJSONObject(i);
			String userId  = user.optString("id");
			JSONArray roleArray = dataService.toJSONArray("select c.* from t_user a LEFT JOIN t_user_role  b on a.id = b.user_id"
					+ " LEFT JOIN t_role c on b.role_id = c.id WHERE a.id = ?", userId);
			/*List<String> roleNameList = new ArrayList<String>();
			List<String> roleIdList = new ArrayList<String>();*/
			JSONArray resourceArray = dataService.toJSONArray("select e.name from t_user a "
					+ "LEFT JOIN t_user_role  b on a.id = b.user_id "
					+ "LEFT JOIN t_role c on b.role_id = c.id "
					+ "LEFT JOIN t_role_resource d on c.id = d.role_id "
					+ "LEFT JOIN t_resource e on d.resource_id = e.id WHERE a.id = ? order by e.rank asc", userId);
			user.put("resourceList", resourceArray);
			/*for (int j = 0; j < roleArray.length(); j++) {
				JSONObject json = roleArray.optJSONObject(j);
				String name = json.optString("name");
				String id = json.optString("id");
				roleIdList.add(id);
				roleNameList.add(name);
			}*/
			user.put("roleList", roleArray);
	 /*     user.put("roleNameList", roleNameList);
			user.put("roleIdList",  roleIdList);*/
			userList.put(user);
		}
    	model.addAttribute("userList", userList);
    	model.addAttribute("roles",dataService.toJSONArray("select * from t_role where status > ?", DataStatusEnum.DElETED.getValue()));
    	return "user/list";
    }

    /**
     * 跳转到添加用户的页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String add(Model model){
        logger.debug("跳转到添加用户的页面");
        model.addAttribute("user",new User());
        model.addAttribute("roles",dataService.toJSONArray("select * from t_role where status > ?", DataStatusEnum.DElETED.getValue()));
        return "user/add";
    }

    /**
     * 添加用户保存的方法
     * @param user
     * @param request
     * @return
     */
    /*@RequestMapping(value = "/add",method = RequestMethod.POST)
    public String add(User user, HttpServletRequest request){
    	String userId = UUIDGenerator.getUUID();
        logger.debug("添加用户 post 方法");
        logger.debug(user.toString());
        String[] roldIds = request.getParameterValues("roleId");
        dataService.getTemplate().update("insert into t_user(id,username,password,nickname,status) value(?,?, ?, ?, ?)",userId, user.getUsername(),
        		ShiroKit.getMD5(user.getPassword()), user.getNickname(), user.getStatus());
        for(String roleId:roldIds){
        	 String id = UUIDGenerator.getUUID();
        	 dataService.getTemplate().update("insert into t_user_role(id, user_id, role_id) value(?,?,?)",id,userId, roleId);
        }
        return "redirect:list";
    }
*/
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public String add(User user, String[] roleIds){                                                       
    	int count = 0;
    	if (StringUtils.isBlank(user.getId())) { //用户没有id为null则是新增，有则更    新 
    		String userId = UUIDGenerator.getUUID();
            logger.debug("添加用户 post 方法");
            logger.debug(user.toString());
            dataService.getTemplate().update("insert into t_user(id,username,password,nickname,status) value(?,?, ?, ?, ?)",userId, user.getUsername(),
            		ShiroKit.getMD5(user.getPassword()), user.getNickname(), user.getStatus());
            for(String roleId:roleIds){
            	 count = dataService.getTemplate().update("insert into t_user_role(user_id, role_id) value(?,?)",userId, roleId);
            }
		}else {
			 dataService.getTemplate().update("update t_user set username = ?,nickname = ? where id = ? ",user.getUsername(), user.getNickname(),user.getId());
	         dataService.getTemplate().update("delete from t_user_role where user_id = ?",user.getId());
			 for(String roleId:roleIds){
	            	 count = dataService.getTemplate().update("insert into t_user_role(user_id, role_id) value(?,?)",user.getId(), roleId);
	            }
		}
        if (count > 0) {
        	return BaseReturn.response(ErrorCode.SUCCESS);
		}else {
			return BaseReturn.response(ErrorCode.FAILURE);
		}
    }
    
    @ResponseBody
    @RequestMapping(value = "/updateStatus",method = RequestMethod.POST)
    public Map<String,Object> updateStatus(User user){
        Map<String,Object> result = new HashMap<>();
        int  status = user.getStatus();
        String id = user.getId();
        dataService.getTemplate().update("update t_user set status = ?  where id = ?", status, id);
        result.put("success",true);
        return result;
    }

    /**
     * 跳转到用户信息更新页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/update/{id}",method = RequestMethod.GET)
    public String update(@PathVariable("id") String id,Model model){
    	/*所有的角色列表*/
    	model.addAttribute("user", dataService.toJSONObject("select * from t_user where id = ? and status > ?", id, DataStatusEnum.DElETED.getValue()));
    	JSONArray roleArray = new JSONArray();
    	roleArray = dataService.toJSONArray("select * from t_role where status > ?", DataStatusEnum.DElETED.getValue());
    	model.addAttribute("roles",roleArray);
    	/*用户拥有的所有角色 */
    	JSONArray hasroles = new JSONArray();
    	hasroles = dataService.toJSONArray("select b.* from t_user a left join t_user_role b on a.id = b.user_id where a.id = ?"
    			+ "and a.status > ? and b.status > ?", id, DataStatusEnum.DElETED.getValue(), DataStatusEnum.DElETED.getValue());
        List<String> rids = new ArrayList<String>();
        for(int i = 0; i< hasroles.length(); i++){
        	rids.add(hasroles.optJSONObject(i).optString("role_id"));
        }
        model.addAttribute("hasRole", rids);
    	return "user/update";
    }

    /**
     * 更新用户的信息（包括更新用户绑定的角色）
     * @param user
     * @return
     */
    @RequestMapping(value = "/update/{id}",method = RequestMethod.POST)
    public String update(User user,HttpServletRequest request){
        dataService.getTemplate().update("delete from t_user_role where user_id = ?",user.getId());
        String[] roldIds = request.getParameterValues("roleId");
        for(String roleId:roldIds){
        	String id = UUIDGenerator.getUUID();
        	dataService.getTemplate().update("insert into t_user_role(id, user_Id,role_Id) values(?, ?, ?)", id, user.getId(), roleId);
        }
        dataService.getTemplate().update("update t_user set username = ?,nickname = ? where id =?",user.getUsername(), user.getNickname(),user.getId());
        return "redirect:/admin/user/list";
    }

    /**
     *  根据用户 id 跳转到用户权限的列表页面
     * @return
     */
    @RequestMapping(value = "/resources/{id}",method = RequestMethod.GET)
    public String listResources(@PathVariable("id") String userId,Model model){
    	JSONArray resourceArray = new JSONArray(); 
    	resourceArray= dataService.toJSONArray("select e.* from t_user a LEFT JOIN t_user_role  b on a.id = b.user_id  "
    			+ "LEFT JOIN t_role c on b.role_id = c.id LEFT JOIN t_role_resource d on c.id = d.role_id "
    			+ "LEFT JOIN t_resource e on d.resource_id = e.id WHERE a.id = ?",  userId);
    	model.addAttribute("resources",resourceArray);
    	model.addAttribute("user",dataService.toJSONObject("select * from t_user where id = ? ", userId));
    	return "user/resources";
    }

    /**
     * 批量删除用户
     * 1、删除用户数据
     * 2、删除用户绑定的角色数据
     * @param userIds
     * @return
     */
  /*  @ResponseBody
    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    public Map<String,Object> delete(@RequestParam("userIds[]") List<String> userIds){
    	
        Map<String,Object> result = new HashMap<>();
        try{
            userService.deleteUserAndRole(userIds);
           
            result.put("success",true);
        }catch (RuntimeException e){
            e.printStackTrace();
            result.put("success",false);
            result.put("errorInfo",e.getMessage());
        }
        for(int i = 0; i < userIds.size(); i++) {
        	dataService.getTemplate().update("update t_user set status = ?,updateDate = ? where id = ?",DataStatusEnum.DElETED.getValue(), new Date(), userIds.get(i));
        	dataService.getTemplate().update("delete  from t_user_role where user_id = ?", userIds.get(i));
        }
        result.put("success",true);
        return result;
    }*/
    
    
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	@ResponseBody
	public String delete(@PathVariable String id) {

		logger.debug("-----删除用户-----");
		logger.info("-----传过来的id:{}-----", id);
		if (StringUtils.isBlank(id)) {
			return BaseReturn.response(ErrorCode.PARAM_ERROR, "id不能为空");
		} else {
			int deleteCount1 = 0;
			deleteCount1 = dataService.getTemplate().update("delete from  t_user where id = ?",id);
			dataService.getTemplate().update("delete from t_user_role where user_id = ? ",id);
			if (deleteCount1 > 0) {
				return BaseReturn.response(ErrorCode.SUCCESS, deleteCount1);
			} else {
				return BaseReturn.response(ErrorCode.FAILURE, "删除数据失败");
			}
		}

	}
    
    @RequestMapping(value = "/roleZtree", method = RequestMethod.GET)
	@ResponseBody
	public String roleZtree(Model model, HttpSession session, String userId) {
    	User loginUser = (User) session.getAttribute(SessionParam.LOGIN_USER);
		if (loginUser != null) {
			List<Ztree> ztree = new ArrayList<Ztree>();
			if (StringUtils.isNoneBlank(userId)) {
				ztree = ztreeService.getRoleZtree(loginUser, userId);
			} else {
				ztree = ztreeService.getRoleZtree(loginUser);
			}
			logger.info("-----返回的ztree:{}-----", BaseReturn.response(ztree));
			return BaseReturn.response(ztree);
		} else {
			return BaseReturn.response(ErrorCode.NOT_LOGGIN);
		}
	}
    
   
}



