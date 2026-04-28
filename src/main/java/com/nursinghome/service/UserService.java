package com.nursinghome.service;

import com.nursinghome.dao.UserDao;
import com.nursinghome.entity.SysUser;

import java.util.List;

public class UserService {
    private final UserDao userDao = new UserDao();

    public SysUser login(String username, String password) {
        return userDao.findByUsernameAndPassword(username, password);
    }

    public boolean register(SysUser user) {
        if (userDao.findByUsername(user.getUsername()) != null) {
            return false;
        }
        user.setRole("USER");
        return userDao.save(user);
    }

    public List<SysUser> findAll() {
        return userDao.findAll();
    }
}
