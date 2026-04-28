package com.nursinghome.service;

import com.nursinghome.dao.ElderlyProfileDao;
import com.nursinghome.entity.ElderlyProfile;

import java.util.List;

public class ElderlyProfileService {
    private final ElderlyProfileDao profileDao = new ElderlyProfileDao();

    public boolean save(ElderlyProfile profile) {
        return profileDao.save(profile);
    }

    public List<ElderlyProfile> findAll() {
        return profileDao.findAll();
    }
}
