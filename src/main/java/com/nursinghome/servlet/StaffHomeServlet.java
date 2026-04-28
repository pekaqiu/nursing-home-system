package com.nursinghome.servlet;

import com.nursinghome.service.CareRecordService;
import com.nursinghome.service.ElderlyProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/staff/home")
public class StaffHomeServlet extends HttpServlet {
    private final ElderlyProfileService elderlyProfileService = new ElderlyProfileService();
    private final CareRecordService careRecordService = new CareRecordService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("elderlyCount", elderlyProfileService.findAll().size());
        req.setAttribute("careCount", careRecordService.findAll().size());
        req.getRequestDispatcher("/pages/staff/home.jsp").forward(req, resp);
    }
}
