package com.nursinghome.servlet;

import com.nursinghome.service.ElderlyProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/elderly")
public class ElderlyManageServlet extends HttpServlet {
    private final ElderlyProfileService elderlyProfileService = new ElderlyProfileService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("elderlyList", elderlyProfileService.findAll());
        req.getRequestDispatcher("/pages/admin/elderly-manage.jsp").forward(req, resp);
    }
}
