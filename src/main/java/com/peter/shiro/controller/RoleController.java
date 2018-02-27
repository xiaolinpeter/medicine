package com.peter.shiro.controller;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.peter.shiro.context.BaseReturn;
import com.peter.shiro.context.ErrorCode;
import com.peter.shiro.model.Role;
import com.peter.shiro.service.DataService;
import com.peter.shiro.util.DataStatusEnum;
import com.peter.shiro.util.UUIDGenerator;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin/role")
public class RoleController {
    private static final Logger logger = LoggerFactory.getLogger(RoleController.class);
    @Autowired
    private DataService dataService;

    /**
     * 跳转到查询所有角色的页面
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String list(Model model){
        model.addAttribute("roleList",dataService.toJSONArray("select * from t_role where status > ?",DataStatusEnum.DElETED.getValue()));
        return "role/list";
    }

    /**
     * 跳转到添加角色的页面
     * @return
     */
    @RequestMapping(value = "/add",method = RequestMethod.GET)
    public String add(Model model){
        // 为了表单回显的须要，要在 Model 里添加一个新对象
        model.addAttribute("role",new Role());
        return "role/add";
    }

    /**
     * 添加用户角色的后台方法
     * @param role
     * @return
     */
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public String addOrUpdate(Role role,String resourceIds){
    	 int count = 0;
        logger.debug(role.toString());
        if(StringUtils.isBlank(role.getId())) {
        	String id = UUIDGenerator.getUUID();
            dataService.getTemplate().update("insert into t_role(id, name) value(?, ?)",id, role.getName());
         	String[] resourceIdArray = resourceIds.split(",");
         	for (String resourceId : resourceIdArray ) {
         	     count = dataService.getTemplate().update("insert into t_role_resource(role_id, resource_id) value(?, ?)",id, resourceId);
     		}
     		if (count > 0) {
     			return BaseReturn.response(ErrorCode.SUCCESS);
     		} else {
     			return BaseReturn.response(ErrorCode.FAILURE);
     		}
        }else {
        	   dataService.getTemplate().update("delete from t_role_resource where role_id = ?", role.getId());
               String[] resourceIdArray = resourceIds.split(",");
            	for (String resourceId : resourceIdArray ) {
            	     count = dataService.getTemplate().update("insert into t_role_resource(role_id, resource_id) value(?, ?)",role.getId(), resourceId);
        		}
        		if (count > 0) {
        			return BaseReturn.response(ErrorCode.SUCCESS);
        		} else {
        			return BaseReturn.response(ErrorCode.FAILURE);
        		}
        }
       
    }

    /**
     * 跳转到更新角色的页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/update/{id}",method = RequestMethod.GET)
    public String update(@PathVariable("id") String id, Model model){
        model.addAttribute("role",dataService.toJSONObject("select * from t_role where id = ?", id));
        return "role/update";
    }

    /**
     * 修改角色对象的方法
     * @param role
     * @return
     */
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public String update(Role role){
        logger.debug(role.toString());
        dataService.getTemplate().update("update t_role set name = ? where id = ?", role.getName(),  role.getId());
        return "redirect:/admin/role/list";
    }

    @RequestMapping(value = "/resources/{id}",method = RequestMethod.GET)
    public String listResources(@PathVariable("id") String id,Model model){
    	/*查询该角色拥有的权限*/
    	JSONArray hasResourceArray = new JSONArray();
    	List<String> hasResourceIds = new ArrayList<String>();
    	 hasResourceArray = dataService.toJSONArray("select c.* from t_role a LEFT JOIN t_role_resource b on a.id = b.role_id "
         		+ "LEFT JOIN t_resource c on b.resource_id = c.id where a.id = ?", id);
    	 for (int i = 0; i < hasResourceArray.length(); i++) {
			hasResourceIds.add(hasResourceArray.optJSONObject(i).optString("id"));
		}
        model.addAttribute("hasResourceIds",hasResourceIds);
        /*查询所有的权限*/
        model.addAttribute("resourceList",dataService.toJSONArray("select * from t_resource where status > ?", DataStatusEnum.DElETED.getValue()));
        /*根据id查询角色*/
        model.addAttribute("role",dataService.toJSONObject("select * from t_role where id = ?", id));
        return "role/resources";
    }

    /**
     * 设置角色权限
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/resource",method = RequestMethod.POST)
    public String resource(HttpServletRequest request){
    	JSONObject json = new JSONObject();
    	String result = "";
        String roleId = request.getParameter("roleId");
        String[] resourceIdList= request.getParameterValues("resourceIdList");
         //先统一删除
        dataService.getTemplate().update("delete from t_role_resource where role_id = ?", roleId);
        //重新设置
        for (String resourceId:resourceIdList) {
        	String id = UUIDGenerator.getUUID();
            dataService.getTemplate().update("insert into  t_role_resource(id, role_id, resource_id)  values(?, ?, ?)", id, roleId,resourceId);
		}
	    json.put("code","200");
	    result = json.toString();
        return result;
    }

    /**
     *
     * @param roleIds
     */
   /* @ResponseBody
    @RequestMapping(value = "/delete",method = RequestMethod.POST)
    public Map<String,Object> deleteRole(@RequestParam("roleIds[]") List<String> roleIds){
    	logger.info(String.valueOf(roleIds));
    	
    	for (int i = 0; i < roleIds.size(); i++) {
			dataService.getTemplate().update("update t_role  set status = ?,updateDate = ? where id = ?",DataStatusEnum.DElETED.getValue(), new Date(), roleIds.get(i));
			dataService.getTemplate().update("delete from  t_role_resource where role_id = ?", roleIds.get(i));
			dataService.getTemplate().update("delete from  t_user_role where role_id = ?", roleIds.get(i));
		}
        Map<String,Object> result = new HashMap<>();
        result.put("success",true);
        return result;
    }*/
    
    
    @ResponseBody
    @RequestMapping(value = "/delete/{id}",method = RequestMethod.POST)
    public String deleteRole(@PathVariable String id){
    	if (StringUtils.isBlank(id)) {
			return BaseReturn.response(ErrorCode.PARAM_ERROR, "id不能为空");
		}
	    int count0 = dataService.getTemplate().update("delete from  t_role  where id = ?", id);
		int count1 = dataService.getTemplate().update("delete from  t_role_resource where role_id = ?", id);
		int count2 = dataService.getTemplate().update("delete from  t_user_role where role_id = ?", id);
		if (count0 > 0 && count1 >= 0 && count2 >= 0) {
			return BaseReturn.response(ErrorCode.SUCCESS,count0 + count1+ count2);
		} else {
			return BaseReturn.response(ErrorCode.FAILURE);
		}
    }
}
