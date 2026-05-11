package com.football.dao;
import com.football.model.Result;
import com.football.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResultDAO {

    public List<Result> getAll() {
        List<Result> results = new ArrayList<>();
        String query = "SELECT * FROM results";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                results.add(extractResult(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return results;
    }

    public Result getById(int id) {
        String query = "SELECT * FROM results WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractResult(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public Result getByMatchId(int matchId) {
        String query = "SELECT * FROM results WHERE match_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, matchId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractResult(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void add(Result result) {
        String query = "INSERT INTO results (match_id, home_score, away_score, final_status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, result.getMatchId());
            pstmt.setInt(2, result.getHomeScore());
            pstmt.setInt(3, result.getAwayScore());
            pstmt.setString(4, result.getFinalStatus());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Result result) {
        String query = "UPDATE results SET match_id=?, home_score=?, away_score=?, final_status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, result.getMatchId());
            pstmt.setInt(2, result.getHomeScore());
            pstmt.setInt(3, result.getAwayScore());
            pstmt.setString(4, result.getFinalStatus());
            pstmt.setInt(5, result.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM results WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Result extractResult(ResultSet rs) throws SQLException {
        Result result = new Result();
        result.setId(rs.getInt("id"));
        result.setMatchId(rs.getInt("match_id"));
        result.setHomeScore(rs.getInt("home_score"));
        result.setAwayScore(rs.getInt("away_score"));
        result.setFinalStatus(rs.getString("final_status"));
        return result;
    }
}