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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private TeamDAO teamDAO = new TeamDAO();
    private MatchDAO matchDAO = new MatchDAO();
    private ResultDAO resultDAO = new ResultDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Team> teams = teamDAO.getAll();
        List<Match> matches = matchDAO.getAll();
        List<Result> results = resultDAO.getAll();

        // Підтягуємо рахунки для матчів
        Map<Integer, Result> resultsMap = new HashMap<>();
        for (Result r : results) {
            resultsMap.put(r.getMatchId(), r);
        }

        request.setAttribute("teams", teams);
        request.setAttribute("matches", matches);
        request.setAttribute("resultsMap", resultsMap); // Передаємо рахунки на сторінку адмінки

        request.getRequestDispatcher("/WEB-INF/jsp/admin/dashboard.jsp").forward(request, response);
    }
}