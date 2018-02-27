package com.peter.shiro.controller;
import com.peter.shiro.context.BaseReturn;
import com.peter.shiro.context.ErrorCode;
import com.peter.shiro.context.SessionParam;
import com.peter.shiro.model.Resource;
import com.peter.shiro.model.User;
import com.peter.shiro.service.DataService;
import com.peter.shiro.service.SessionService;
import com.peter.shiro.util.DataStatusEnum;
import com.peter.shiro.util.UUIDGenerator;
import vms.common.util.JsonUtils;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/admin/resource")
@Controller
public class ResourceController {
    private static final Logger logger = LoggerFactory.getLogger(ResourceController.class);
    @Autowired
    private DataService dataService;
    @Autowired
    private SessionService sessionService;
    /**
     * 返回到列表显示页面
     * @return
     */
    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public String list(Model model){
        // 查询到所有的权限列表
        model.addAttribute("resourceList",dataService.toJSONArray("select * from t_resource  where status > ? order by rank asc",DataStatusEnum.DElETED.getValue()));
        return "resource/list";
    }

    /**
     * 跳转到添加权限的页面
     * @return
     */
    /*@RequestMapping(value = "/add",method = RequestMethod.GET)
    public String add(Model model){
        Resource resource = new Resource();
        model.addAttribute("resource",resource);
        return "resource/add";
    }*/

    /**
     * 添加或更新菜单
     * @return
     */
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public String add(Resource resource,HttpSession session){
    	int count = 0;
    	User user = (User)session.getAttribute(SessionParam.LOGIN_USER);
    	if(StringUtils.isBlank(resource.getId())) {
    	      String id = UUIDGenerator.getUUID();
    	      count =  dataService.getTemplate().update("insert into t_resource(id, parentId, name, permission,isMenu, url, rank) values(?, ?, ?, ?, ?, ?, ?)", 
    	        		id,  resource.getParentId(), resource.getName(), resource.getPermission(), resource.getIsMenu(), resource.getUrl(), resource.getRank());	
    	}else {
    		  count =  dataService.getTemplate().update("update  t_resource set parentId = ?, name = ?, permission = ?,  url = ?, rank = ?, isMenu = ? where id = ?", 
 	        	 resource.getParentId(), resource.getName(), resource.getPermission(), resource.getUrl(), resource.getRank(), resource.getIsMenu(), resource.getId());	
    	}
    	if (count > 0) {
    		sessionService.setResourceInSession(session, user);
    		return BaseReturn.response(ErrorCode.SUCCESS);
		}else {
			return BaseReturn.response(ErrorCode.FAILURE);
		}
    }
    
    
    
    
    @RequestMapping(value = "/delete/{id}",method = RequestMethod.POST)
    @ResponseBody
    public String delete(@PathVariable String id, HttpSession session){
    	User user = (User)session.getAttribute(SessionParam.LOGIN_USER);
    	int count = 0;
    	/*Resource resource = JsonUtils.fromJson(j, classOfT);*/
    	JSONObject json = new  JSONObject();
    	json = dataService.toJSONObject("select * from t_resource where id = ?", id);
    	Resource resource = JsonUtils.fromJson(json, Resource.class);
		count = dataService.getTemplate().update("delete from t_resource where id = ?", id);
    	if (resource.getChildren() != null) {
			List<Resource> resourcelist = resource.getChildren();
			for (int i = 0; i < resourcelist.size(); i++) {
				delete(resource.getId(),session);
			}
		}
    	if (count > 0) {
    		sessionService.setResourceInSession(session, user);
    		return BaseReturn.response(ErrorCode.SUCCESS, count);
		}else {
			return BaseReturn.response(ErrorCode.FAILURE);
		}
    }

    /**
     * 跳转到更新权限的页面
     * @param id
     * @return
     */
    @RequestMapping(value = "/{id}",method = RequestMethod.GET)
    public String update(@PathVariable("id")String id,Model model){
        model.addAttribute("resource",dataService.toJSONObject("select * from t_resource where id = ?", id));
        return "resource/update";
    }

    /**
     * 更新权限的方法
     * @param resource
     * @return
     */
    @RequestMapping(value = "/update",method = RequestMethod.POST)
    public String update(Resource resource){
        logger.debug(resource.toString());
        dataService.getTemplate().update("update t_resource set name = ?, parentId = ?, permission = ?, url = ?, rank = ?, isMenu = ? where id = ?"
        		, resource.getName(), resource.getParentId(), resource.getPermission(), resource.getUrl(), resource.getRank(), resource.getIsMenu(), resource.getId());
        return "redirect:/admin/resource/list";
    }
    
    
    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
	@ResponseBody
	public String detail(@PathVariable String id) {
		logger.info("-----正在查询菜单详情：{}-----", id);
		if (StringUtils.isBlank(id)) {
			return BaseReturn.response(ErrorCode.PARAM_ERROR, "id不能为空");
		}
		Resource resource = JsonUtils.fromJson(dataService.toJSONObject("select * from t_resource where id = ?", id), Resource.class);
		logger.info("-----查找到的菜单：{}-----", resource);
		if (null == resource ) {
			return BaseReturn.response(ErrorCode.RECORD_NULL);
		} else {
			return BaseReturn.response(ErrorCode.SUCCESS, resource);
		}
	}
    
}
