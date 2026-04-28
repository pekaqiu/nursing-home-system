package com.nursinghome.filter;

import com.nursinghome.entity.SysUser;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }

        SysUser loginUser = (SysUser) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect(contextPath + "/login");
            return;
        }

        if (path.startsWith("/admin") || path.startsWith("/pages/admin")) {
            if (!"ADMIN".equals(loginUser.getRole())) {
                resp.sendRedirect(contextPath + "/error.jsp?message=您无权访问该页面");
                return;
            }
        }

        if (path.startsWith("/staff") || path.startsWith("/pages/staff")) {
            if (!"STAFF".equals(loginUser.getRole())) {
                resp.sendRedirect(contextPath + "/error.jsp?message=您无权访问该页面");
                return;
            }
        }

        if (path.startsWith("/user") || path.startsWith("/pages/user")) {
            if (!"USER".equals(loginUser.getRole()) && !path.contains("notice")) {
                resp.sendRedirect(contextPath + "/error.jsp?message=您无权访问该页面");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private boolean isPublicPath(String path) {
        return "/".equals(path)
                || "/index.jsp".equals(path)
                || "/login.jsp".equals(path)
                || "/register.jsp".equals(path)
                || "/login".equals(path)
                || "/register".equals(path)
                || "/error.jsp".equals(path)
                || path.startsWith("/assets/")
                || path.startsWith("/notice")
                || path.endsWith(".css")
                || path.endsWith(".js");
    }

    @Override
    public void destroy() {
    }
}
