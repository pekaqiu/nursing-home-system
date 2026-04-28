package com.nursinghome.servlet;

import com.nursinghome.entity.SysUser;
import com.nursinghome.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SysUser user = new SysUser();
        user.setUsername(req.getParameter("username"));
        user.setPassword(req.getParameter("password"));
        user.setRealName(req.getParameter("realName"));
        user.setPhone(req.getParameter("phone"));

        boolean success = userService.register(user);
        if (!success) {
            req.setAttribute("errorMessage", "注册失败，用户名已存在，请更换用户名。");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        req.setAttribute("successMessage", "注册成功，请使用新账号登录。");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
