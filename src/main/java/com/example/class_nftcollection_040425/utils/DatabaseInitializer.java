package com.example.class_nftcollection_040425.utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.*;

public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String jdbcURL = "jdbc:mysql://localhost:3306/?serverTimezone=UTC";
        String dbName = "nft_gallery";
        String dbUser = "root";
        String dbPassword = "your_password";

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
             Statement stmt = conn.createStatement()) {

            // Tạo CSDL nếu chưa tồn tại
            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS " + dbName + " CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");

            // Kết nối tới DB
            try (Connection dbConn = DriverManager.getConnection(jdbcURL + dbName, dbUser, dbPassword);
                 Statement dbStmt = dbConn.createStatement()) {

                // Tạo bảng category
                dbStmt.executeUpdate(
                        "CREATE TABLE IF NOT EXISTS category (" +
                                "id INT AUTO_INCREMENT PRIMARY KEY," +
                                "name VARCHAR(100) NOT NULL" +
                                ")"
                );

                // Chèn dữ liệu danh mục nếu chưa có
                dbStmt.executeUpdate(
                        "INSERT IGNORE INTO category (id, name) VALUES" +
                                "(1, 'Tranh kỹ thuật số')," +
                                "(2, 'Âm thanh')," +
                                "(3, 'Video')," +
                                "(4, 'GIF')," +
                                "(5, '3D Model')"
                );

                // Tạo bảng NFT
                dbStmt.executeUpdate(
                        "CREATE TABLE IF NOT EXISTS nft (" +
                                "id INT AUTO_INCREMENT PRIMARY KEY," +
                                "name VARCHAR(255) NOT NULL," +
                                "description TEXT," +
                                "image_url VARCHAR(500)," +
                                "price DECIMAL(18, 8) NOT NULL," +
                                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                                "creator_name VARCHAR(255) NOT NULL," +
                                "category_id INT," +
                                "wallet_address VARCHAR(255)," +
                                "status ENUM('dang_ban', 'da_ban', 'khong_ban') DEFAULT 'dang_ban'," +
                                "FOREIGN KEY (category_id) REFERENCES category(id)" +
                                ")"
                );

                System.out.println("✅ Database và bảng đã được tạo thành công.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi tạo database hoặc bảng: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Không cần xử lý khi ứng dụng dừng
    }
}

