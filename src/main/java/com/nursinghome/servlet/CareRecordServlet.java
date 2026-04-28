package com.nursinghome.servlet;

import com.nursinghome.entity.CareRecord;
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

@WebServlet("/staff/care-record")
public class CareRecordServlet extends HttpServlet {
    private final CareRecordService careRecordService = new CareRecordService();
    private final ElderlyProfileService elderlyProfileService = new ElderlyProfileService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("careRecordList", careRecordService.findAll());
        req.setAttribute("elderlyList", elderlyProfileService.findAll());
        req.getRequestDispatcher("/pages/staff/care-record.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SysUser loginUser = (SysUser) req.getSession().getAttribute("loginUser");
        CareRecord record = new CareRecord();
        record.setElderlyId(Integer.valueOf(req.getParameter("elderlyId")));
        record.setStaffId(loginUser.getId());
        record.setCareContent(req.getParameter("careContent").trim());
        record.setBodyCondition(req.getParameter("bodyCondition").trim());
        record.setRemark(req.getParameter("remark") == null ? "" : req.getParameter("remark").trim());
        try {
            record.setCareTime(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(req.getParameter("careTime")));
        } catch (ParseException e) {
            throw new ServletException("护理时间格式错误", e);
        }
        boolean success = careRecordService.save(record);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/staff/care-record?success=1");
        } else {
            req.setAttribute("errorMessage", "护理记录保存失败，请稍后重试。");
            doGet(req, resp);
        }
    }
}
