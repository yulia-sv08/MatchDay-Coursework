package com.football.controller;

import com.football.dao.MatchDAO;
import com.football.dao.ResultDAO;
import com.football.dao.TeamDAO;
import com.football.model.Match;
import com.football.model.Result;
import java.time.LocalDateTime;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/match-form")
public class MatchFormServlet extends HttpServlet {
    private MatchDAO matchDAO = new MatchDAO();
    private TeamDAO teamDAO = new TeamDAO();
    private ResultDAO resultDAO = new ResultDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login"); return;
        }

        request.setAttribute("teams", teamDAO.getAll()); // список команд для випадаючого списку

        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            int matchId = Integer.parseInt(id);
            request.setAttribute("match", matchDAO.getById(matchId));
            request.setAttribute("result", resultDAO.getByMatchId(matchId));
        }
        request.getRequestDispatcher("/WEB-INF/jsp/admin/match-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");

        Match match = new Match();
        if (id != null && !id.isEmpty()) match.setId(Integer.parseInt(id));

        match.setHomeTeamId(Integer.parseInt(request.getParameter("homeTeamId")));
        match.setAwayTeamId(Integer.parseInt(request.getParameter("awayTeamId")));

        String dateStr = request.getParameter("matchDate");
        if (dateStr.length() == 16) dateStr += ":00"; // datetime-local повертає "yyyy-MM-ddTHH:mm" (16 символів), додаємо секунди
        match.setMatchDate(LocalDateTime.parse(dateStr));

        match.setStadium(request.getParameter("stadium"));
        match.setTournament(request.getParameter("tournament"));
        match.setStatus(request.getParameter("status"));

        if (match.getId() > 0) {
            matchDAO.update(match);

            // Зберігаємо рахунок
            String hScore = request.getParameter("homeScore");
            String aScore = request.getParameter("awayScore");
            if (hScore != null && !hScore.isEmpty() && aScore != null && !aScore.isEmpty()) {
                Result r = resultDAO.getByMatchId(match.getId());
                boolean isNew = (r == null);
                if (isNew) { r = new Result(); r.setMatchId(match.getId()); }
                r.setHomeScore(Integer.parseInt(hScore));
                r.setAwayScore(Integer.parseInt(aScore));

                if (isNew) resultDAO.add(r); else resultDAO.update(r);
            }
        } else {
            matchDAO.add(match);
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}