package com.example.class_nftcollection_040425.Dao;


import com.example.class_nftcollection_040425.Models.NFTCategory;
import com.example.class_nftcollection_040425.utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {

    public List<NFTCategory> getAllCategories() {
        List<NFTCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM category";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                NFTCategory c = new NFTCategory();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public NFTCategory getCategoryById(int id) {
        String sql = "SELECT * FROM category WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new NFTCategory(rs.getInt("id"), rs.getString("name"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

