package com.nursinghome.servlet;

import com.nursinghome.entity.SysUser;
import com.nursinghome.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        SysUser user = userService.login(username, password);
        if (user == null) {
            req.setAttribute("errorMessage", "用户名或密码错误，请重新输入。");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        req.getSession().setAttribute("loginUser", user);
        if ("ADMIN".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/home");
        } else if ("STAFF".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/staff/home");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/home");
        }
    }
}
