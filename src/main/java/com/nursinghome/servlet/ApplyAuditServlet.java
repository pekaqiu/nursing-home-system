package com.nursinghome.servlet;

import com.nursinghome.service.CheckinApplyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/apply-audit")
public class ApplyAuditServlet extends HttpServlet {
    private final CheckinApplyService applyService = new CheckinApplyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("applyList", applyService.findAll());
        req.getRequestDispatcher("/pages/admin/apply-audit.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = Integer.valueOf(req.getParameter("id"));
        String status = req.getParameter("auditStatus");
        String remark = req.getParameter("auditRemark") == null ? "" : req.getParameter("auditRemark").trim();
        boolean success = applyService.audit(id, status, remark);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/apply-audit?success=1");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/apply-audit?error=1");
        }
    }
}
