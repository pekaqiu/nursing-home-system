package com.nursinghome.servlet;

import com.nursinghome.entity.Notice;
import com.nursinghome.entity.SysUser;
import com.nursinghome.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/home")
public class UserHomeServlet extends HttpServlet {
    private final NoticeService noticeService = new NoticeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SysUser user = (SysUser) req.getSession().getAttribute("loginUser");
        List<Notice> notices = noticeService.findPublished();
        req.setAttribute("loginUser", user);
        req.setAttribute("noticeList", notices);
        req.getRequestDispatcher("/pages/user/home.jsp").forward(req, resp);
    }
}
