package com.nursinghome.servlet;

import com.nursinghome.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/notice")
public class NoticeServlet extends HttpServlet {
    private final NoticeService noticeService = new NoticeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("detail".equals(action)) {
            Integer id = Integer.valueOf(req.getParameter("id"));
            req.setAttribute("notice", noticeService.findById(id));
            req.getRequestDispatcher("/pages/user/notice-detail.jsp").forward(req, resp);
            return;
        }
        req.setAttribute("noticeList", noticeService.findPublished());
        req.getRequestDispatcher("/pages/user/notice-list.jsp").forward(req, resp);
    }
}
