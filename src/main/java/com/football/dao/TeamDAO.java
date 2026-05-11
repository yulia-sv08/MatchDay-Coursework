package com.football.dao;
import com.football.model.Team;
import com.football.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TeamDAO {

    public List<Team> getAll() {
        List<Team> teams = new ArrayList<>();
        String query = "SELECT * FROM teams";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                teams.add(extractTeam(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teams;
    }

    public Team getById(int id) {
        String query = "SELECT * FROM teams WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractTeam(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void add(Team team) {
        String query = "INSERT INTO teams (name, country, city, foundation_year, logo) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, team.getName());
            pstmt.setString(2, team.getCountry());
            pstmt.setString(3, team.getCity());
            pstmt.setInt(4, team.getFoundationYear());
            pstmt.setString(5, team.getLogo());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Team team) {
        String query = "UPDATE teams SET name=?, country=?, city=?, foundation_year=?, logo=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, team.getName());
            pstmt.setString(2, team.getCountry());
            pstmt.setString(3, team.getCity());
            pstmt.setInt(4, team.getFoundationYear());
            pstmt.setString(5, team.getLogo());
            pstmt.setInt(6, team.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM teams WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Team extractTeam(ResultSet rs) throws SQLException {
        return new Team(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("country"),
                rs.getString("city"),
                rs.getInt("foundation_year"),
                rs.getString("logo")
        );
    }
}