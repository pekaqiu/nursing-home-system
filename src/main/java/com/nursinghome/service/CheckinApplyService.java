package com.nursinghome.service;

import com.nursinghome.dao.CheckinApplyDao;
import com.nursinghome.entity.CheckinApply;

import java.util.List;

public class CheckinApplyService {
    private final CheckinApplyDao applyDao = new CheckinApplyDao();

    public boolean save(CheckinApply apply) {
        return applyDao.save(apply);
    }

    public List<CheckinApply> findByUserId(Integer userId) {
        return applyDao.findByUserId(userId);
    }

    public List<CheckinApply> findAll() {
        return applyDao.findAll();
    }

    public List<CheckinApply> findApproved() {
        return applyDao.findApproved();
    }

    public CheckinApply findById(Integer id) {
        return applyDao.findById(id);
    }

    public boolean audit(Integer id, String status, String remark) {
        return applyDao.audit(id, status, remark);
    }
}
