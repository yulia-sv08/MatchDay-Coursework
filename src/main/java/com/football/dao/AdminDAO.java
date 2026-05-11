package com.football.dao;

import com.football.util.DBConnection;
import java.sql.*;

public class AdminDAO {

    // перевіряємо чи існує адмін з таким логіном і паролем
    public boolean checkLogin(String username, String password) {
        String query = "SELECT id FROM admins WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            try (ResultSet rs = pstmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
