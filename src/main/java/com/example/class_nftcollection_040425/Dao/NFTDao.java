package com.example.class_nftcollection_040425.Dao;

import com.example.class_nftcollection_040425.Models.NFT;
import com.example.class_nftcollection_040425.utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NFTDao {

    // Lấy tất cả NFT đang bán (có phân trang)
    public List<NFT> getNFTsForSale(int page, int limit) {
        List<NFT> list = new ArrayList<>();
        String sql = "SELECT nft.*, c.name AS category_name FROM nft " +
                "LEFT JOIN category c ON nft.category_id = c.id " +
                "WHERE status = 'dang_ban' " +
                "ORDER BY created_at DESC " +
                "LIMIT ? OFFSET ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            stmt.setInt(2, (page - 1) * limit);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                NFT nft = extractNFTFromResultSet(rs);
                nft.setCategoryName(rs.getString("category_name"));
                list.add(nft);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm NFT
    public boolean addNFT(NFT nft) {
        String sql = "INSERT INTO nft(name, description, image_url, price, creator_name, category_id, wallet_address, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nft.getName());
            stmt.setString(2, nft.getDescription());
            stmt.setString(3, nft.getImageUrl());
            stmt.setDouble(4, nft.getPrice());
            stmt.setString(5, nft.getCreatorName());
            stmt.setInt(6, nft.getCategoryId());
            stmt.setString(7, nft.getWalletAddress());
            stmt.setString(8, nft.getStatus());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy NFT theo ID
    public NFT getNFTById(int id) {
        String sql = "SELECT nft.*, c.name AS category_name FROM nft " +
                "LEFT JOIN category c ON nft.category_id = c.id WHERE nft.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                NFT nft = extractNFTFromResultSet(rs);
                nft.setCategoryName(rs.getString("category_name"));
                return nft;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật NFT
    public boolean updateNFT(NFT nft) {
        String sql = "UPDATE nft SET name=?, description=?, image_url=?, price=?, creator_name=?, category_id=?, wallet_address=?, status=? WHERE id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nft.getName());
            stmt.setString(2, nft.getDescription());
            stmt.setString(3, nft.getImageUrl());
            stmt.setDouble(4, nft.getPrice());
            stmt.setString(5, nft.getCreatorName());
            stmt.setInt(6, nft.getCategoryId());
            stmt.setString(7, nft.getWalletAddress());
            stmt.setString(8, nft.getStatus());
            stmt.setInt(9, nft.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa NFT
    public boolean deleteNFT(int id) {
        String sql = "DELETE FROM nft WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đếm số lượng NFT đang bán
    public int countNFTsForSale() {
        String sql = "SELECT COUNT(*) FROM nft WHERE status = 'dang_ban'";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {

            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Hàm hỗ trợ: lấy NFT từ ResultSet
    private NFT extractNFTFromResultSet(ResultSet rs) throws SQLException {
        NFT nft = new NFT();
        nft.setId(rs.getInt("id"));
        nft.setName(rs.getString("name"));
        nft.setDescription(rs.getString("description"));
        nft.setImageUrl(rs.getString("image_url"));
        nft.setPrice(rs.getDouble("price"));
        nft.setCreatedAt(rs.getTimestamp("created_at"));
        nft.setCreatorName(rs.getString("creator_name"));
        nft.setCategoryId(rs.getInt("category_id"));
        nft.setWalletAddress(rs.getString("wallet_address"));
        nft.setStatus(rs.getString("status"));
        return nft;
    }
}

