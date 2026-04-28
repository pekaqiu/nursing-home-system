package com.nursinghome.dao;

import com.nursinghome.entity.ElderlyProfile;
import com.nursinghome.util.DBUtil;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ElderlyProfileDao {
    public boolean save(ElderlyProfile profile) {
        String sql = "insert into elderly_profile(name, gender, age, phone, family_contact, family_phone, health_condition, checkin_date, bed_id, status) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, profile.getName());
            statement.setString(2, profile.getGender());
            statement.setInt(3, profile.getAge());
            statement.setString(4, profile.getPhone());
            statement.setString(5, profile.getFamilyContact());
            statement.setString(6, profile.getFamilyPhone());
            statement.setString(7, profile.getHealthCondition());
            statement.setDate(8, new Date(profile.getCheckinDate().getTime()));
            statement.setInt(9, profile.getBedId());
            statement.setString(10, profile.getStatus());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("保存老人档案失败", e);
        }
    }

    public List<ElderlyProfile> findAll() {
        String sql = "select e.*, concat(b.room_no, '房-', b.bed_no, '号床') bed_display from elderly_profile e left join bed_info b on e.bed_id = b.id order by e.id desc";
        List<ElderlyProfile> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                ElderlyProfile profile = new ElderlyProfile();
                profile.setId(resultSet.getInt("id"));
                profile.setName(resultSet.getString("name"));
                profile.setGender(resultSet.getString("gender"));
                profile.setAge(resultSet.getInt("age"));
                profile.setPhone(resultSet.getString("phone"));
                profile.setFamilyContact(resultSet.getString("family_contact"));
                profile.setFamilyPhone(resultSet.getString("family_phone"));
                profile.setHealthCondition(resultSet.getString("health_condition"));
                profile.setCheckinDate(resultSet.getDate("checkin_date"));
                profile.setBedId(resultSet.getInt("bed_id"));
                profile.setStatus(resultSet.getString("status"));
                profile.setCreateTime(resultSet.getTimestamp("create_time"));
                profile.setUpdateTime(resultSet.getTimestamp("update_time"));
                profile.setBedDisplay(resultSet.getString("bed_display"));
                list.add(profile);
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询老人档案失败", e);
        }
        return list;
    }
}
