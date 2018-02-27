package com.peter.shiro.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.peter.shiro.model.Resource;
import com.peter.shiro.model.Role;
import com.peter.shiro.model.User;
import com.peter.shiro.model.Ztree;

import vms.common.util.JsonUtils;

@Service
public class ZtreeService {

	@Autowired
	private DataService dataService;

	/**
	 * 查询登录用户所拥有的菜单树
	 * 
	 * @param loginUser
	 * @return
	 */
	public List<Ztree> getMenuZtree(User user) {

		List<Resource> resourceList = queryResourceById(user);
		List<Ztree> ztreeList = new ArrayList<Ztree>();
		for (Resource resource : resourceList) {
			Ztree ztree = new Ztree();
			ztree.setId(resource.getId());
			ztree.setpId(resource.getParentId());
			ztree.setName(resource.getName());
			ztree.setIcon(resource.getIcon());
			if (resource.getName().equals("个人设置") || resource.getName().equals("后台首页")) {
				ztree.setChecked(true);
				ztree.setChkDisabled(true);
			}
			if (StringUtils.isNotBlank(resource.getIcon())) {
				ztree.setOpen(true);
			}
			ztreeList.add(ztree);

		}
		return ztreeList;

	}

	/**
	 * 根据角色id查询角色所拥有的菜单
	 * 
	 * @param loginUser
	 * @param roleId
	 * @return
	 */
	public List<Ztree> getMenuZtreeByRoleId(User user, String roleid) {
		// 1 查询出用户所拥有的权限
		List<Resource> resourceList = queryResourceById(user);
		// 2 查询出角色所拥有的权限
		List<Resource> roleResourceList = queryResourceByRoleId(roleid);
		List<Ztree> ztreeList = new ArrayList<Ztree>();
		for (Resource resource : resourceList) {
			Ztree ztree = new Ztree();
			ztree.setId(resource.getId());
			ztree.setpId(resource.getParentId());
			ztree.setName(resource.getName());
			ztree.setIcon(resource.getIcon());
			if (resource.getName().equals("个人设置") || resource.getName().equals("后台首页")) {
				ztree.setChecked(true);
				ztree.setChkDisabled(true);
			}
			for (Resource roleResource : roleResourceList) {
				if (resource.getId().equals(roleResource.getId())) {
					ztree.setChecked(true);
					continue;
				}
			}
			if (StringUtils.isNotBlank(resource.getIcon())) {
				ztree.setOpen(true);
			}
			ztreeList.add(ztree);

		}
		return ztreeList;
	}

	/**
	 * 查询登录用户所拥有的角色树
	 * 
	 * @param loginUser
	 * @return
	 */
	public List<Ztree> getRoleZtree(User loginUser) {
		List<Role> roleList = queryRoleById(loginUser);
		List<Ztree> ztreeList = new ArrayList<Ztree>();
		for (Role role : roleList) {
			Ztree ztree = new Ztree();
			ztree.setId(role.getId());
			ztree.setName(role.getName());
			ztreeList.add(ztree);
		}
		return ztreeList;
	}

	
	/**
	 * 根据角色id查询角色所拥有的菜单
	 * 
	 * @param loginUser
	 * @param roleId
	 * @return
	 */
	
	public List<Ztree> getRoleZtree(User loginUser, String userid) {
		List<Role> roleList = queryRoleById(loginUser);
		List<Role> userRoleList = queryResourceById(userid);
		List<Ztree> ztreeList = new ArrayList<Ztree>();
		for (Role role : roleList) {
			Ztree ztree = new Ztree();
			ztree.setId(role.getId());
			ztree.setName(role.getName());
			for (Role userRole : userRoleList) {
				if (role.getId().equals(userRole.getId())) {
					ztree.setChecked(true);
					continue;
				}
			}
			ztreeList.add(ztree);
		}
		return ztreeList;
	}

	// 根据用户id查询用户权限
	public List<Resource> queryResourceById(User user) {
		JSONArray rootResourceArray = new JSONArray();
		if (user.getId().equals("1")) {
			rootResourceArray = dataService.toJSONArray("select * from t_resource ORDER BY rank ASC");
		} else {
			rootResourceArray = dataService.toJSONArray(
					"select  distinct e.* from t_user a LEFT JOIN t_user_role  b on a.id = b.user_id"
							+ " LEFT JOIN t_role c on b.role_id = c.id LEFT JOIN t_role_resource d on c.id = d.role_id "
							+ "LEFT JOIN t_resource e on d.resource_id = e.id WHERE a.id = ? order by e.rank asc",
					user.getId());
		}

		List<Resource> resourceList = new ArrayList<Resource>();
		for (int i = 0; i < rootResourceArray.length(); i++) {
			resourceList.add(JsonUtils.fromJson(rootResourceArray.optJSONObject(i), Resource.class));
		}
		return resourceList;
	}

	// 根据用户id查询用户角色
	public List<Role> queryRoleById(User user) {
		JSONArray roleArray = new JSONArray();
		if("1".equals(user.getId()) ) {
			roleArray = dataService.toJSONArray("select * from t_role");
		}else {
			roleArray = dataService.toJSONArray("select c.* from t_user a LEFT JOIN t_user_role b on a.id = b.user_id "
					+ "LEFT JOIN t_role c on b.role_id = c.id where a.id = ?", user.getId());
		}
		
		List<Role> roleList = new ArrayList<Role>();
		for (int i = 0; i < roleArray.length(); i++) {
			roleList.add(JsonUtils.fromJson(roleArray.optJSONObject(i), Role.class));
		}
		return roleList;
	}

	// 根据角色id查询角色权限
	public List<Resource> queryResourceByRoleId(String roleId) {
		JSONArray rootResourceArray = new JSONArray();
		rootResourceArray = dataService
				.toJSONArray("select distinct c.* from t_role a LEFT JOIN t_role_resource b on a.id = b.role_id "
						+ "LEFT JOIN t_resource c on b.resource_id = c.id where a.id = ?", roleId);
		List<Resource> resourceList = new ArrayList<Resource>();
		for (int i = 0; i < rootResourceArray.length(); i++) {
			resourceList.add(JsonUtils.fromJson(rootResourceArray.optJSONObject(i), Resource.class));
		}
		return resourceList;
	}

	public List<Role> queryResourceById(String userId) {
		JSONArray roleArray = new JSONArray();
		roleArray = dataService.toJSONArray("select c.* from t_user a LEFT JOIN t_user_role b on a.id = b.user_id "
				+ "LEFT JOIN t_role c on b.role_id = c.id where a.id = ?", userId);
		List<Role> roleList = new ArrayList<Role>();
		for (int i = 0; i < roleArray.length(); i++) {
			roleList.add(JsonUtils.fromJson(roleArray.optJSONObject(i), Role.class));
		}
		return roleList;
	}
	
}
