package com.peter.shiro.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.peter.shiro.model.Resource;
import com.peter.shiro.model.User;
import com.peter.shiro.util.Param;
import com.peter.shiro.util.ResourceUtil;

import vms.common.util.JsonUtils;

/**
 * 用来更新session中的信息
 */
@Service
public class SessionService {
	@Autowired
	private DataService dataService;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * 更新session中的菜单
	 * 
	 * @param session
	 * @param loginUser
	 */
	public void setResourceInSession(HttpSession session, User user) {
		// 查询用户拥有的权限列表
		JSONArray rootResourceArray  = new JSONArray();
		rootResourceArray = dataService.toJSONArray("select * from t_resource ORDER BY rank ASC");
		if(user.getId().equals("1")){
			rootResourceArray = dataService.toJSONArray("select * from t_resource ORDER BY rank ASC");
		}else {
			 rootResourceArray = dataService.toJSONArray("select distinct e.*  from t_user a LEFT JOIN t_user_role  b on a.id = b.user_id"
						+ " LEFT JOIN t_role c on b.role_id = c.id LEFT JOIN t_role_resource d on c.id = d.role_id "
						+ "LEFT JOIN t_resource e on d.resource_id = e.id WHERE a.id = ? order by e.rank asc",user.getId());
		}
		
		List<Resource> rootResource = new ArrayList<Resource>();
		for (int i = 0; i < rootResourceArray.length(); i++) {
			rootResource.add(JsonUtils.fromJson(rootResourceArray.optJSONObject(i),Resource.class));
		}
		
		// 要返回的菜单
		List<Resource> resourceList = new ArrayList<Resource>();
		// 先找到所有的一级菜单
		/*for (int i = 0; i < rootResource.size(); i++) {
			// 一级菜单没有parentId
			if (rootResource.get(i).getParentId() == null) {
				 resourceList.add(rootResource.get(i));
			}
		}*/
/*		if(user.getId().equals("1")){
			for (int i = 0; i < rootResource.size(); i++) {
				// 一级菜单没有parentId
				if ("".equals(rootResource.get(i).getParentId())) {
					 resourceList.add(rootResource.get(i));
				}
			}
		}else{
			for (int i = 0; i < rootResource.size(); i++) {
				// 一级菜单没有parentId
				if (rootResource.get(i).getUrl().endsWith("**")) {
					 resourceList.add(rootResource.get(i));
				}
			}
		}*/
		
		for (int i = 0; i < rootResource.size(); i++) {
			// 一级菜单没有parentId
			if ("".equals(rootResource.get(i).getParentId())) {
				 resourceList.add(rootResource.get(i));
			}
		}
		// 为一级菜单设置子菜单，getChild是递归调用的
		for (Resource resource : resourceList) {
			resource.setChildren(ResourceUtil.getChild(resource.getId(), rootResource));
		}
		logger.info("-----用户的菜单:{}-----", resourceList);
		// 将权限列表保存到session中
		session.setAttribute(Param.SESSION_USER_RESOURCE, resourceList);
	}

}
