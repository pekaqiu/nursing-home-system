package com.nursinghome.dao;

import com.nursinghome.entity.SysUser;
import com.nursinghome.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    public SysUser findByUsernameAndPassword(String username, String password) {
        String sql = "select * from sys_user where username = ? and password = ? and status = '正常'";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            statement.setString(2, password);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询用户失败", e);
        }
        return null;
    }

    public SysUser findByUsername(String username) {
        String sql = "select * from sys_user where username = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询用户名失败", e);
        }
        return null;
    }

    public boolean save(SysUser user) {
        String sql = "insert into sys_user(username, password, real_name, phone, role, status) values(?, ?, ?, ?, ?, '正常')";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());
            statement.setString(3, user.getRealName());
            statement.setString(4, user.getPhone());
            statement.setString(5, user.getRole());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("保存用户失败", e);
        }
    }

    public List<SysUser> findAll() {
        String sql = "select * from sys_user order by id asc";
        List<SysUser> users = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                users.add(mapUser(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询用户列表失败", e);
        }
        return users;
    }

    private SysUser mapUser(ResultSet resultSet) throws SQLException {
        SysUser user = new SysUser();
        user.setId(resultSet.getInt("id"));
        user.setUsername(resultSet.getString("username"));
        user.setPassword(resultSet.getString("password"));
        user.setRealName(resultSet.getString("real_name"));
        user.setPhone(resultSet.getString("phone"));
        user.setRole(resultSet.getString("role"));
        user.setStatus(resultSet.getString("status"));
        user.setCreateTime(resultSet.getTimestamp("create_time"));
        user.setUpdateTime(resultSet.getTimestamp("update_time"));
        return user;
    }
}
