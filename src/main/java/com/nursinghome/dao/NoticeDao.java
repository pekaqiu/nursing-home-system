package com.nursinghome.dao;

import com.nursinghome.entity.Notice;
import com.nursinghome.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NoticeDao {
    public List<Notice> findPublished() {
        String sql = "select * from notice where status = '已发布' order by publish_time desc";
        List<Notice> list = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                list.add(mapNotice(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询公告失败", e);
        }
        return list;
    }

    public Notice findById(Integer id) {
        String sql = "select * from notice where id = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapNotice(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("查询公告详情失败", e);
        }
        return null;
    }

    private Notice mapNotice(ResultSet resultSet) throws SQLException {
        Notice notice = new Notice();
        notice.setId(resultSet.getInt("id"));
        notice.setTitle(resultSet.getString("title"));
        notice.setContent(resultSet.getString("content"));
        notice.setPublishTime(resultSet.getTimestamp("publish_time"));
        notice.setStatus(resultSet.getString("status"));
        notice.setCreateTime(resultSet.getTimestamp("create_time"));
        notice.setUpdateTime(resultSet.getTimestamp("update_time"));
        return notice;
    }
}
