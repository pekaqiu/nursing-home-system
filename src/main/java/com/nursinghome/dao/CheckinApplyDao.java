package com.nursinghome.dao;

import com.nursinghome.entity.CheckinApply;
import com.nursinghome.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CheckinApplyDao {
    public boolean save(CheckinApply apply) {
        String sql = "insert into checkin_apply(user_id, elderly_name, elderly_age, gender, contact_phone, health_desc, apply_reason, audit_status) values(?, ?, ?, ?, ?, ?, ?, '待审核')";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, apply.getUserId());
            statement.setString(2, apply.getElderlyName());
            statement.setInt(3, apply.getElderlyAge());
            statement.setString(4, apply.getGender());
            statement.setString(5, apply.getContactPhone());
            statement.setString(6, apply.getHealthDesc());
            statement.setString(7, apply.getApplyReason());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("保存入住申请失败", e);
        }
    }

    public List<CheckinApply> findByUserId(Integer userId) {
        String sql = "select a.*, u.real_name applicant_name from checkin_apply a left join sys_user u on a.user_id = u.id where a.user_id = ? order by a.id desc";
        List<CheckinApply> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    list.add(mapApply(resultSet));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询我的申请失败", e);
        }
        return list;
    }

    public List<CheckinApply> findAll() {
        String sql = "select a.*, u.real_name applicant_name from checkin_apply a left join sys_user u on a.user_id = u.id order by a.id desc";
        List<CheckinApply> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                list.add(mapApply(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询申请列表失败", e);
        }
        return list;
    }

    public List<CheckinApply> findApproved() {
        String sql = "select a.*, u.real_name applicant_name from checkin_apply a left join sys_user u on a.user_id = u.id where a.audit_status = '已通过' order by a.id desc";
        List<CheckinApply> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                list.add(mapApply(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询已通过申请失败", e);
        }
        return list;
    }

    public CheckinApply findById(Integer id) {
        String sql = "select a.*, u.real_name applicant_name from checkin_apply a left join sys_user u on a.user_id = u.id where a.id = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapApply(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询申请详情失败", e);
        }
        return null;
    }

    public boolean audit(Integer id, String status, String remark) {
        String sql = "update checkin_apply set audit_status = ?, audit_remark = ? where id = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setString(2, remark);
            statement.setInt(3, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("审核申请失败", e);
        }
    }

    private CheckinApply mapApply(ResultSet resultSet) throws SQLException {
        CheckinApply apply = new CheckinApply();
        apply.setId(resultSet.getInt("id"));
        apply.setUserId(resultSet.getInt("user_id"));
        apply.setElderlyName(resultSet.getString("elderly_name"));
        apply.setElderlyAge(resultSet.getInt("elderly_age"));
        apply.setGender(resultSet.getString("gender"));
        apply.setContactPhone(resultSet.getString("contact_phone"));
        apply.setHealthDesc(resultSet.getString("health_desc"));
        apply.setApplyReason(resultSet.getString("apply_reason"));
        apply.setAuditStatus(resultSet.getString("audit_status"));
        apply.setAuditRemark(resultSet.getString("audit_remark"));
        apply.setCreateTime(resultSet.getTimestamp("create_time"));
        apply.setUpdateTime(resultSet.getTimestamp("update_time"));
        try {
            apply.setApplicantName(resultSet.getString("applicant_name"));
        } catch (SQLException ignored) {
        }
        return apply;
    }
}
