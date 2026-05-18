package com.nursinghome.servlet;

import com.nursinghome.service.BedInfoService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/beds")
public class BedManageServlet extends HttpServlet {
    private final BedInfoService bedInfoService = new BedInfoService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("bedList", bedInfoService.findAll());
        req.getRequestDispatcher("/pages/admin/bed-manage.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/error.jsp?message=管理员仅可查看床位状态，不能执行修改操作");
    }
}
