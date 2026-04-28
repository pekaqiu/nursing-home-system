package com.nursinghome.dao;

import com.nursinghome.entity.CareRecord;
import com.nursinghome.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CareRecordDao {
    public boolean save(CareRecord record) {
        String sql = "insert into care_record(elderly_id, staff_id, care_content, body_condition, care_time, remark) values(?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, record.getElderlyId());
            statement.setInt(2, record.getStaffId());
            statement.setString(3, record.getCareContent());
            statement.setString(4, record.getBodyCondition());
            statement.setTimestamp(5, new Timestamp(record.getCareTime().getTime()));
            statement.setString(6, record.getRemark());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("保存护理记录失败", e);
        }
    }

    public List<CareRecord> findAll() {
        String sql = "select c.*, e.name elderly_name, s.real_name staff_name from care_record c " +
                "left join elderly_profile e on c.elderly_id = e.id " +
                "left join sys_user s on c.staff_id = s.id order by c.care_time desc";
        List<CareRecord> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                CareRecord record = new CareRecord();
                record.setId(resultSet.getInt("id"));
                record.setElderlyId(resultSet.getInt("elderly_id"));
                record.setStaffId(resultSet.getInt("staff_id"));
                record.setCareContent(resultSet.getString("care_content"));
                record.setBodyCondition(resultSet.getString("body_condition"));
                record.setCareTime(resultSet.getTimestamp("care_time"));
                record.setRemark(resultSet.getString("remark"));
                record.setCreateTime(resultSet.getTimestamp("create_time"));
                record.setUpdateTime(resultSet.getTimestamp("update_time"));
                record.setElderlyName(resultSet.getString("elderly_name"));
                record.setStaffName(resultSet.getString("staff_name"));
                list.add(record);
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询护理记录失败", e);
        }
        return list;
    }
}
