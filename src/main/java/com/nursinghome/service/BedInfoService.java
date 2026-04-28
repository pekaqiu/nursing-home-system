package com.nursinghome.service;

import com.nursinghome.dao.BedInfoDao;
import com.nursinghome.entity.BedInfo;

import java.util.List;

public class BedInfoService {
    private final BedInfoDao bedInfoDao = new BedInfoDao();

    public List<BedInfo> findAll() {
        return bedInfoDao.findAll();
    }

    public List<BedInfo> findAvailable() {
        return bedInfoDao.findAvailable();
    }

    public boolean save(BedInfo bedInfo) {
        return bedInfoDao.save(bedInfo);
    }

    public boolean updateStatus(Integer id, String status) {
        return bedInfoDao.updateStatus(id, status);
    }
}
