package com.nursinghome.dao;

import com.nursinghome.entity.CareRecord;
import com.nursinghome.util.DBUtil;

import java.sql.Connection;
import java.sql.Date;
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
        return findByCondition(null, null, null);
    }

    public List<CareRecord> findByCondition(Integer elderlyId, java.util.Date careDate, Integer staffId) {
        StringBuilder sql = new StringBuilder(
                "select c.*, e.name elderly_name, s.real_name staff_name from care_record c " +
                        "left join elderly_profile e on c.elderly_id = e.id " +
                        "left join sys_user s on c.staff_id = s.id where 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (elderlyId != null) {
            sql.append(" and c.elderly_id = ?");
            params.add(elderlyId);
        }
        if (careDate != null) {
            sql.append(" and date(c.care_time) = ?");
            params.add(new Date(careDate.getTime()));
        }
        if (staffId != null) {
            sql.append(" and c.staff_id = ?");
            params.add(staffId);
        }
        sql.append(" order by c.care_time desc");

        List<CareRecord> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    list.add(mapRecord(resultSet));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询护理记录失败", e);
        }
        return list;
    }

    private CareRecord mapRecord(ResultSet resultSet) throws SQLException {
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
        return record;
    }
}
