package com.nursinghome.servlet;

import com.nursinghome.entity.SysUser;
import com.nursinghome.service.CareRecordService;
import com.nursinghome.service.ElderlyProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/staff/care-record-query")
public class CareRecordQueryServlet extends HttpServlet {
    private static final String ROLE_STAFF = "STAFF";

    private final CareRecordService careRecordService = new CareRecordService();
    private final ElderlyProfileService elderlyProfileService = new ElderlyProfileService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SysUser loginUser = ensureStaff(req, resp);
        if (loginUser == null) {
            return;
        }

        Integer elderlyId = parseInteger(req.getParameter("elderlyId"));
        Date careDate = parseDate(req.getParameter("careDate"));
        Integer staffId = "1".equals(req.getParameter("onlyMine")) ? loginUser.getId() : null;

        req.setAttribute("elderlyList", elderlyProfileService.findAll());
        req.setAttribute("careRecordList", careRecordService.findByCondition(elderlyId, careDate, staffId));
        req.setAttribute("selectedElderlyId", elderlyId);
        req.setAttribute("selectedCareDate", req.getParameter("careDate") == null ? "" : req.getParameter("careDate"));
        req.setAttribute("onlyMine", "1".equals(req.getParameter("onlyMine")));
        req.getRequestDispatcher("/pages/staff/care-record-query.jsp").forward(req, resp);
    }

    private SysUser ensureStaff(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        SysUser loginUser = (SysUser) req.getSession().getAttribute("loginUser");
        if (loginUser == null || !ROLE_STAFF.equals(loginUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/error.jsp?message=该功能仅限护工操作");
            return null;
        }
        return loginUser;
    }

    private Integer parseInteger(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return Integer.valueOf(value);
    }

    private Date parseDate(String value) throws ServletException {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(value);
        } catch (ParseException e) {
            throw new ServletException("护理日期格式错误", e);
        }
    }
}
