package com.football.dao;
import com.football.model.Match;
import com.football.model.Team;
import com.football.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatchDAO {
    private TeamDAO teamDAO = new TeamDAO();

    public List<Match> getAll() {
        List<Match> matches = new ArrayList<>();
        String query = "SELECT * FROM matches ORDER BY match_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                matches.add(extractMatch(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return matches;
    }

    public Match getById(int id) {
        String query = "SELECT * FROM matches WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractMatch(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void add(Match match) {
        String query = "INSERT INTO matches (home_team_id, away_team_id, match_date, stadium, tournament, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, match.getHomeTeamId());
            pstmt.setInt(2, match.getAwayTeamId());
            pstmt.setTimestamp(3, Timestamp.valueOf(match.getMatchDate()));
            pstmt.setString(4, match.getStadium());
            pstmt.setString(5, match.getTournament());
            pstmt.setString(6, match.getStatus());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(Match match) {
        String query = "UPDATE matches SET home_team_id=?, away_team_id=?, match_date=?, stadium=?, tournament=?, status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, match.getHomeTeamId());
            pstmt.setInt(2, match.getAwayTeamId());
            pstmt.setTimestamp(3, Timestamp.valueOf(match.getMatchDate()));
            pstmt.setString(4, match.getStadium());
            pstmt.setString(5, match.getTournament());
            pstmt.setString(6, match.getStatus());
            pstmt.setInt(7, match.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM matches WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Match extractMatch(ResultSet rs) throws SQLException {
        Match match = new Match();
        match.setId(rs.getInt("id"));
        match.setHomeTeamId(rs.getInt("home_team_id"));
        match.setAwayTeamId(rs.getInt("away_team_id"));

        Timestamp timestamp = rs.getTimestamp("match_date");
        if (timestamp != null) {
            match.setMatchDate(timestamp.toLocalDateTime());
        }

        match.setStadium(rs.getString("stadium"));
        match.setTournament(rs.getString("tournament"));
        match.setStatus(rs.getString("status"));

        // підтягуємо команди для матчу
        Team homeTeam = teamDAO.getById(match.getHomeTeamId());
        Team awayTeam = teamDAO.getById(match.getAwayTeamId());
        match.setHomeTeam(homeTeam);
        match.setAwayTeam(awayTeam);

        return match;
    }
}