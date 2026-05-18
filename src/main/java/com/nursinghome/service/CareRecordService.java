package com.nursinghome.service;

import com.nursinghome.dao.CareRecordDao;
import com.nursinghome.entity.CareRecord;

import java.util.Date;
import java.util.List;

public class CareRecordService {
    private final CareRecordDao careRecordDao = new CareRecordDao();

    public boolean save(CareRecord record) {
        return careRecordDao.save(record);
    }

    public List<CareRecord> findAll() {
        return careRecordDao.findAll();
    }

    public List<CareRecord> findByCondition(Integer elderlyId, Date careDate, Integer staffId) {
        return careRecordDao.findByCondition(elderlyId, careDate, staffId);
    }
}
