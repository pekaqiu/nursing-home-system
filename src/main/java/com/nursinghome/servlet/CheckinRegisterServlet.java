package com.nursinghome.servlet;

import com.nursinghome.entity.BedInfo;
import com.nursinghome.entity.CheckinApply;
import com.nursinghome.entity.ElderlyProfile;
import com.nursinghome.service.BedInfoService;
import com.nursinghome.service.CheckinApplyService;
import com.nursinghome.service.ElderlyProfileService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/staff/checkin")
public class CheckinRegisterServlet extends HttpServlet {
    private final CheckinApplyService applyService = new CheckinApplyService();
    private final BedInfoService bedInfoService = new BedInfoService();
    private final ElderlyProfileService elderlyProfileService = new ElderlyProfileService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CheckinApply> approvedApplyList = applyService.findApproved();
        List<BedInfo> availableBedList = bedInfoService.findAvailable();
        req.setAttribute("approvedApplyList", approvedApplyList);
        req.setAttribute("availableBedList", availableBedList);
        req.getRequestDispatcher("/pages/staff/checkin-register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ElderlyProfile profile = new ElderlyProfile();
        profile.setName(req.getParameter("name").trim());
        profile.setGender(req.getParameter("gender"));
        profile.setAge(Integer.valueOf(req.getParameter("age")));
        profile.setPhone(req.getParameter("phone").trim());
        profile.setFamilyContact(req.getParameter("familyContact").trim());
        profile.setFamilyPhone(req.getParameter("familyPhone").trim());
        profile.setHealthCondition(req.getParameter("healthCondition").trim());
        profile.setBedId(Integer.valueOf(req.getParameter("bedId")));
        profile.setStatus("已入住");
        try {
            profile.setCheckinDate(new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("checkinDate")));
        } catch (ParseException e) {
            throw new ServletException("入住日期格式错误", e);
        }
        boolean profileSaved = elderlyProfileService.save(profile);
        boolean bedUpdated = profileSaved && bedInfoService.updateStatus(profile.getBedId(), "已入住");
        if (profileSaved && bedUpdated) {
            resp.sendRedirect(req.getContextPath() + "/staff/checkin?success=1");
        } else {
            req.setAttribute("errorMessage", "入住登记保存失败，请检查床位状态后重试。");
            doGet(req, resp);
        }
    }
}
