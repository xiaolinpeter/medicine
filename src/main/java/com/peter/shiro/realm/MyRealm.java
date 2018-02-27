package com.peter.shiro.realm;
import com.peter.shiro.model.User;
import com.peter.shiro.service.DataService;
import vms.common.util.JsonUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public class MyRealm extends AuthorizingRealm {
    private static final Logger logger = LoggerFactory.getLogger(MyRealm.class);
    @Autowired
    private DataService dataService;

   

    /**
     * 认证
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        logger.info("--- 认证MyRealm doGetAuthenticationInfo ---");
        String username = authenticationToken.getPrincipal().toString();
        // 在测试调试的时候发现,这里还是应该使用 login 判断,因为登录不成功的原因有很多,
        // 可以在登录的逻辑里面抛出各种异常
        // 再到 subject.login(token) 里面去捕获对应的异常
        // 显示不同的消息到页面上
        JSONObject jsonUser= new JSONObject();
        jsonUser = dataService.toJSONObject("select * from t_user where username = ?", username);
        User user = JsonUtils.fromJson(jsonUser,User.class);
        if(user.getId() == null) {
        	 throw new UnknownAccountException("用户名不存在");
        }else if(user.getStatus() == 0){
            throw new LockedAccountException("用户已经被禁用，请联系管理员启用该账号");
        }else {
            // 第 1 个参数可以传一个实体对象，然后在认证的环节可以取出
            // 第 2 个参数应该传递在数据库中“正确”的数据，然后和 token 中的数据进行匹配
            SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user,user.getPassword(),getName());
            // 设置盐值
            return info;
        }
    }

    
    /**
     * 授权
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        logger.info("--- 授权：MyRealm doGetAuthorizationInfo ---");

        // 获得经过认证的主体信息
        User user = (User)principalCollection.getPrimaryPrincipal();
        String userId = user.getId();
        // UserService userService = (UserService)InitServlet.getBean("userService");
        JSONArray resourceArry = dataService.toJSONArray("select e.* from t_user a LEFT JOIN t_user_role  b on a.id = b.user_id  "
    			+ "LEFT JOIN t_role c on b.role_id = c.id LEFT JOIN t_role_resource d on c.id = d.role_id "
    			+ "LEFT JOIN t_resource e on d.resource_id = e.id WHERE a.id = ?",  userId);
        JSONArray roleArray = dataService.toJSONArray("select c.* from t_user a left join t_user_role b on a.id = b.user_id "
        		+ "left join t_role c on b.role_id = c.id where a.id = ?", userId);
        List<String> resStrList = new ArrayList<String>();
        for (int i = 0; i < resourceArry.length(); i++) {
			resStrList.add(resourceArry.optJSONObject(i).optString("url"));
		}
        List<String> roleNameList = new ArrayList<String>();
        for (int i = 0; i < roleArray.length(); i++) {
        	roleNameList.add(roleArray.optJSONObject(i).optString("name"));
		}
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(new HashSet<>(roleNameList));
        info.setStringPermissions(new HashSet<>(resStrList));

        // 以上完成了动态地对用户授权
        logger.debug("role => " + roleNameList);
        logger.debug("permission => " + resStrList);

        return info;
    }
    
    @Override
    protected void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        Cache c = getAuthenticationCache();
        logger.info("清除【认证】缓存之前");
        for(Object o : c.keys()){
            logger.info( o + " , " + c.get(o));
        }
        super.clearCachedAuthenticationInfo(principals);
        logger.info("调用父类清除【认证】缓存之后");
        for(Object o : c.keys()){
            logger.info( o + " , " + c.get(o));
        }

        // 添加下面的代码清空【认证】的缓存
        User user = (User) principals.getPrimaryPrincipal();
        SimplePrincipalCollection spc = new SimplePrincipalCollection(user.getUsername(),getName());
        super.clearCachedAuthenticationInfo(spc);
        logger.info("添加了代码清除【认证】缓存之后");
        int cacheSize = c.keys().size();
        logger.info("【认证】缓存的大小:" + c.keys().size());
        if (cacheSize == 0){
            logger.info("说明【认证】缓存被清空了。");
        }
    }

    @Override
    protected void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        logger.info("清除【授权】缓存之前");
        Cache c = getAuthorizationCache();
        for(Object o : c.keys()){
            logger.info( o + " , " + c.get(o));
        }
        super.clearCachedAuthorizationInfo(principals);
        logger.info("清除【授权】缓存之后");
        int cacheSize = c.keys().size();
        logger.info("【授权】缓存的大小:" + cacheSize);

        for(Object o : c.keys()){
            logger.info( o + " , " + c.get(o));
        }
        if(cacheSize == 0){
            logger.info("说明【授权】缓存被清空了。");
        }

    }
}
