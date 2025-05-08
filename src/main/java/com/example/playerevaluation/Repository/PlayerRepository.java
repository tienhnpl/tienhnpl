package com.example.playerevaluation.Repository;

import com.example.playerevaluation.Models.Player;
import com.example.playerevaluation.Models.Indexer;
import com.example.playerevaluation.Models.PlayerIndex;
import com.example.playerevaluation.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlayerRepository {

    public List<Object[]> findAllPlayers() throws Exception {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT pi.id, p.name, p.age, i.name, pi.value FROM player_index pi " +
                "JOIN player p ON pi.player_id = p.player_id " +
                "JOIN indexer i ON pi.index_id = i.index_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Object[]{
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getFloat(5)
                });
            }
        }
        return list;
    }

    public List<Indexer> getAllIndexers() throws Exception {
        List<Indexer> list = new ArrayList<>();
        String sql = "SELECT * FROM indexer";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Indexer i = new Indexer();
                i.setIndexId(rs.getInt("index_id"));
                i.setName(rs.getString("name"));
                i.setValueMin(rs.getFloat("valueMin"));
                i.setValueMax(rs.getFloat("valueMax"));
                list.add(i);
            }
        }
        return list;
    }

    public void insertPlayer(String name, int age, int indexId, float value) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            String sql1 = "INSERT INTO player (name, full_name, age, index_id) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS)) {
                ps1.setString(1, name);
                ps1.setString(2, name);
                ps1.setInt(3, age);
                ps1.setInt(4, indexId);
                ps1.executeUpdate();
                ResultSet rs = ps1.getGeneratedKeys();
                if (rs.next()) {
                    int playerId = rs.getInt(1);

                    String sql2 = "INSERT INTO player_index (player_id, index_id, value) VALUES (?, ?, ?)";
                    try (PreparedStatement ps2 = conn.prepareStatement(sql2)) {
                        ps2.setInt(1, playerId);
                        ps2.setInt(2, indexId);
                        ps2.setFloat(3, value);
                        ps2.executeUpdate();
                    }
                }
            }
            conn.commit();
        }
    }

    public void updatePlayerIndex(int id, float value) throws Exception {
        String sql = "UPDATE player_index SET value = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setFloat(1, value);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    public void deletePlayerIndex(int id) throws Exception {
        String sql = "DELETE FROM player_index WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public Indexer getIndexerById(int indexId) throws Exception {
        String sql = "SELECT * FROM indexer WHERE index_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, indexId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Indexer i = new Indexer();
                i.setIndexId(indexId);
                i.setName(rs.getString("name"));
                i.setValueMin(rs.getFloat("valueMin"));
                i.setValueMax(rs.getFloat("valueMax"));
                return i;
            }
        }
        return null;
    }
}
