package com.peter.shiro.util;
/**
 * 系统参数和session参数
 * 
 * @author xiaolin_peter
 * @date 2016年11月14日 上午10:43:44
 */
public interface Param {

	/**
	 * 登录页面session中对数据进行des加密的key
	 */
	String SESSION_LOGIN_DES_KEY = "loginDesKey";

	/**
	 * 登录用户在session中的key
	 */
	String SESSION_LOGIN_USER = "loginUser";

	/**
	 * 登录用户所具有的资源在session中的key
	 */
	String SESSION_USER_RESOURCE = "userResourceList";

	/**
	 * ckfinder用户在session中的key
	 */
	String SESSION_CKFINDER_USERROLE = "CKFinder_UserRole";
	
	/**
	 * 管理员在修改资源的时候session中的key
	 */
	String RESOURCE_LIST = "resourceList";
	/**
	 * 管理员在修改角色的时候session中的key
	 */
	String Role_LIST = "roleList";
	/**
	 * 管理员在修改用户的时候session中的key
	 */
	String USER_LIST = "userList";

}
