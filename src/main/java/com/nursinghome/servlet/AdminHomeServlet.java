package com.nursinghome.servlet;

import com.nursinghome.service.BedInfoService;
import com.nursinghome.service.CheckinApplyService;
import com.nursinghome.service.ElderlyProfileService;
import com.nursinghome.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/home")
public class AdminHomeServlet extends HttpServlet {
    private final UserService userService = new UserService();
    private final ElderlyProfileService elderlyProfileService = new ElderlyProfileService();
    private final BedInfoService bedInfoService = new BedInfoService();
    private final CheckinApplyService applyService = new CheckinApplyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("userCount", userService.findAll().size());
        req.setAttribute("elderlyCount", elderlyProfileService.findAll().size());
        req.setAttribute("bedCount", bedInfoService.findAll().size());
        req.setAttribute("applyCount", applyService.findAll().size());
        req.getRequestDispatcher("/pages/admin/home.jsp").forward(req, resp);
    }
}
