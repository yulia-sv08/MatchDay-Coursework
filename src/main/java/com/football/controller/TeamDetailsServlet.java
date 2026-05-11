package com.football.controller;

import com.football.dao.MatchDAO;
import com.football.dao.ResultDAO;
import com.football.dao.TeamDAO;
import com.football.model.Match;
import com.football.model.Result;
import com.football.model.Team;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/team")
public class TeamDetailsServlet extends HttpServlet {
    private TeamDAO teamDAO = new TeamDAO();
    private MatchDAO matchDAO = new MatchDAO();
    private ResultDAO resultDAO = new ResultDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int teamId = Integer.parseInt(idParam);
        Team team = teamDAO.getById(teamId);

        if (team == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Шукаємо всі матчі, де грає ця команда (вдома або в гостях)
        List<Match> allMatches = matchDAO.getAll();
        List<Match> teamMatches = new ArrayList<>();
        for (Match m : allMatches) {
            if ((m.getHomeTeam() != null && m.getHomeTeam().getId() == teamId) ||
                    (m.getAwayTeam() != null && m.getAwayTeam().getId() == teamId)) {
                teamMatches.add(m);
            }
        }

        List<Result> results = resultDAO.getAll();
        Map<Integer, Result> resultsMap = new HashMap<>();
        for (Result r : results) {
            resultsMap.put(r.getMatchId(), r);
        }

        request.setAttribute("team", team);
        request.setAttribute("matches", teamMatches);
        request.setAttribute("resultsMap", resultsMap);

        request.getRequestDispatcher("/WEB-INF/jsp/team-details.jsp").forward(request, response);
    }
}

