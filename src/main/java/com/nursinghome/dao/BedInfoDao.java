package com.nursinghome.dao;

import com.nursinghome.entity.BedInfo;
import com.nursinghome.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BedInfoDao {
    public List<BedInfo> findAll() {
        String sql = "select * from bed_info order by room_no, bed_no";
        List<BedInfo> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                list.add(mapBed(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询床位失败", e);
        }
        return list;
    }

    public List<BedInfo> findAvailable() {
        String sql = "select * from bed_info where status = '空闲' order by room_no, bed_no";
        List<BedInfo> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                list.add(mapBed(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询空闲床位失败", e);
        }
        return list;
    }

    public boolean save(BedInfo bedInfo) {
        String sql = "insert into bed_info(room_no, bed_no, bed_type, status, remark) values(?, ?, ?, ?, ?)";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, bedInfo.getRoomNo());
            statement.setString(2, bedInfo.getBedNo());
            statement.setString(3, bedInfo.getBedType());
            statement.setString(4, bedInfo.getStatus());
            statement.setString(5, bedInfo.getRemark());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("新增床位失败", e);
        }
    }

    public boolean updateStatus(Integer id, String status) {
        String sql = "update bed_info set status = ? where id = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setInt(2, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("更新床位状态失败", e);
        }
    }

    private BedInfo mapBed(ResultSet resultSet) throws SQLException {
        BedInfo bed = new BedInfo();
        bed.setId(resultSet.getInt("id"));
        bed.setRoomNo(resultSet.getString("room_no"));
        bed.setBedNo(resultSet.getString("bed_no"));
        bed.setBedType(resultSet.getString("bed_type"));
        bed.setStatus(resultSet.getString("status"));
        bed.setRemark(resultSet.getString("remark"));
        bed.setCreateTime(resultSet.getTimestamp("create_time"));
        bed.setUpdateTime(resultSet.getTimestamp("update_time"));
        return bed;
    }
}
