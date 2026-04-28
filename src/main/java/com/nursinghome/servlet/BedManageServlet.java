package com.nursinghome.servlet;

import com.nursinghome.entity.BedInfo;
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
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            BedInfo bedInfo = new BedInfo();
            bedInfo.setRoomNo(req.getParameter("roomNo"));
            bedInfo.setBedNo(req.getParameter("bedNo"));
            bedInfo.setBedType(req.getParameter("bedType"));
            bedInfo.setStatus(req.getParameter("status"));
            bedInfo.setRemark(req.getParameter("remark"));
            bedInfoService.save(bedInfo);
        } else if ("updateStatus".equals(action)) {
            Integer id = Integer.valueOf(req.getParameter("id"));
            String status = req.getParameter("status");
            bedInfoService.updateStatus(id, status);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/beds");
    }
}
