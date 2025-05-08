package com.example.playerevaluation.Controllers;

import com.example.playerevaluation.Models.Indexer;
import com.example.playerevaluation.Service.PlayerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.util.List;

import com.example.playerevaluation.util.DBConnection;

@WebServlet("/players")
public class PlayerController extends HttpServlet {
    private final PlayerService service = new PlayerService();

    @Override
    public void init() throws ServletException {
        super.init();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            // ✅ 1. Tạo Database nếu chưa có
            String createDB = "CREATE DATABASE IF NOT EXISTS player_evaluation";
            stmt.executeUpdate(createDB);

            // ✅ 2. Sử dụng Database
            String useDB = "USE player_evaluation";
            stmt.executeUpdate(useDB);

            // ✅ 3. Tạo bảng indexer
            String createIndexer = "CREATE TABLE IF NOT EXISTS indexer (" +
                    "index_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(64) NOT NULL, " +
                    "valueMin FLOAT NOT NULL, " +
                    "valueMax FLOAT NOT NULL" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
            stmt.executeUpdate(createIndexer);

            // ✅ 4. Tạo bảng player
            String createPlayer = "CREATE TABLE IF NOT EXISTS player (" +
                    "player_id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(64) NOT NULL, " +
                    "full_name VARCHAR(128) NOT NULL, " +
                    "age VARCHAR(10) NOT NULL, " +
                    "index_id INT NOT NULL, " +
                    "FOREIGN KEY (index_id) REFERENCES indexer(index_id)" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
            stmt.executeUpdate(createPlayer);

            // ✅ 5. Tạo bảng player_index
            String createPlayerIndex = "CREATE TABLE IF NOT EXISTS player_index (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "player_id INT NOT NULL, " +
                    "index_id INT NOT NULL, " +
                    "value FLOAT NOT NULL, " +
                    "FOREIGN KEY (player_id) REFERENCES player(player_id), " +
                    "FOREIGN KEY (index_id) REFERENCES indexer(index_id)" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
            stmt.executeUpdate(createPlayerIndex);

            // ✅ 6. Insert dữ liệu mẫu nếu chưa có
            String insertDefaults = "INSERT IGNORE INTO indexer (index_id, name, valueMin, valueMax) VALUES " +
                    "(1, 'speed', 10, 100), " +
                    "(2, 'strength', 0, 10), " +
                    "(3, 'accurate', 0, 1);";
            stmt.executeUpdate(insertDefaults);

            System.out.println("✅ Database and tables initialized successfully by PlayerController");

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("❌ Error initializing database: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Object[]> players = service.getAllPlayers();
            List<Indexer> indexers = service.getAllIndexers();

            req.setAttribute("players", players);
            req.setAttribute("indexers", indexers);

            req.getRequestDispatcher("player.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            resp.getWriter().println("Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = req.getParameter("name");
                int age = Integer.parseInt(req.getParameter("age"));
                int indexId = Integer.parseInt(req.getParameter("indexId"));
                float value = Float.parseFloat(req.getParameter("value"));

                service.addPlayer(name, age, indexId, value);

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                int indexId = Integer.parseInt(req.getParameter("indexId"));
                float value = Float.parseFloat(req.getParameter("value"));

                service.updatePlayerIndex(id, value, indexId);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                service.deletePlayerIndex(id);
            }

            resp.sendRedirect("players");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            doGet(req, resp);
        }
    }
}
