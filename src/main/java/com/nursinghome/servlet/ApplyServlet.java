package com.nursinghome.servlet;

import com.nursinghome.entity.CheckinApply;
import com.nursinghome.entity.SysUser;
import com.nursinghome.service.CheckinApplyService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/apply")
public class ApplyServlet extends HttpServlet {
    private final CheckinApplyService applyService = new CheckinApplyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        SysUser loginUser = (SysUser) req.getSession().getAttribute("loginUser");
        if ("my".equals(action)) {
            List<CheckinApply> applyList = applyService.findByUserId(loginUser.getId());
            req.setAttribute("applyList", applyList);
            req.getRequestDispatcher("/pages/user/my-apply.jsp").forward(req, resp);
            return;
        }
        req.getRequestDispatcher("/pages/user/apply-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SysUser loginUser = (SysUser) req.getSession().getAttribute("loginUser");
        CheckinApply apply = new CheckinApply();
        apply.setUserId(loginUser.getId());
        apply.setElderlyName(req.getParameter("elderlyName").trim());
        apply.setElderlyAge(Integer.valueOf(req.getParameter("elderlyAge")));
        apply.setGender(req.getParameter("gender"));
        apply.setContactPhone(req.getParameter("contactPhone").trim());
        apply.setHealthDesc(req.getParameter("healthDesc").trim());
        apply.setApplyReason(req.getParameter("applyReason").trim());
        boolean success = applyService.save(apply);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/user/apply?action=my&success=1");
        } else {
            req.setAttribute("errorMessage", "入住申请提交失败，请稍后重试。");
            req.getRequestDispatcher("/pages/user/apply-form.jsp").forward(req, resp);
        }
    }
}
