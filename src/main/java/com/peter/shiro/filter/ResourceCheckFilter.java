package com.peter.shiro.filter;
 
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResourceCheckFilter extends AccessControlFilter {
    private String errorUrl;
    private static final Logger logger = LoggerFactory.getLogger(ResourceCheckFilter.class);

    public String getErrorUrl() {
        return errorUrl;
    }

    public void setErrorUrl(String errorUrl) {
        this.errorUrl = errorUrl;
    }

    /**
     * 表示是否允许访问 ，如果允许访问返回true，否则false；
     * @param servletRequest
     * @param servletResponse
     * @param o 表示写在拦截器中括号里面的字符串 mappedValue 就是 [urls] 配置中拦截器参数部分
     * @return
     * @throws Exception
     */
    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object o) throws Exception {
        Subject subject = getSubject(servletRequest,servletResponse);
        String url = getPathWithinApplication(servletRequest);
        logger.debug("当前用户正在访问的 url => " + url);
        return subject.isPermitted(url);
    }

    /**
     * onAccessDenied：表示当访问拒绝时是否已经处理了；如果返回 true 表示需要继续处理；如果返回 false 表示该拦截器实例已经处理了，将直接返回即可。

     * @param servletRequest
     * @param servletResponse
     * @return
     * @throws Exception
     */
    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        logger.debug("当 isAccessAllowed 返回 false 的时候，才会执行 method onAccessDenied ");

        HttpServletRequest request =(HttpServletRequest) servletRequest;
        HttpServletResponse response =(HttpServletResponse) servletResponse;
        response.sendRedirect(request.getContextPath() + this.errorUrl);
        // 返回 false 表示已经处理，例如页面跳转啥的，表示不在走以下的拦截器了（如果还有配置的话）
        return false;
    }
}
