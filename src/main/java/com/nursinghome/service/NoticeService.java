package com.nursinghome.service;

import com.nursinghome.dao.NoticeDao;
import com.nursinghome.entity.Notice;

import java.util.List;

public class NoticeService {
    private final NoticeDao noticeDao = new NoticeDao();

    public List<Notice> findPublished() {
        return noticeDao.findPublished();
    }

    public Notice findById(Integer id) {
        return noticeDao.findById(id);
    }
}
