package com.nursinghome.servlet;

import com.nursinghome.entity.SysUser;
import com.nursinghome.service.CheckinApplyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/staff/pending-checkin")
public class StaffPendingCheckinServlet extends HttpServlet {
    private static final String ROLE_STAFF = "STAFF";

    private final CheckinApplyService checkinApplyService = new CheckinApplyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!ensureStaff(req, resp)) {
            return;
        }
        req.setAttribute("approvedApplyList", checkinApplyService.findApproved());
        req.getRequestDispatcher("/pages/staff/pending-checkin.jsp").forward(req, resp);
    }

    private boolean ensureStaff(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        SysUser loginUser = (SysUser) req.getSession().getAttribute("loginUser");
        if (loginUser == null || !ROLE_STAFF.equals(loginUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/error.jsp?message=该功能仅限护工操作");
            return false;
        }
        return true;
    }
}
