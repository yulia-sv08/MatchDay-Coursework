package com.football.controller;

import com.football.dao.MatchDAO;
import com.football.dao.ResultDAO;
import com.football.model.Match;
import com.football.model.Result;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private MatchDAO matchDAO = new MatchDAO();
    private ResultDAO resultDAO = new ResultDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Match> matches = matchDAO.getAll();

        // live матчі завжди йдуть першими
        matches.sort((m1, m2) -> {
            boolean isLive1 = "live".equals(m1.getStatus());
            boolean isLive2 = "live".equals(m2.getStatus());
            if (isLive1 && !isLive2) return -1;
            if (!isLive1 && isLive2) return 1;
            return 0;
        });

        List<Result> results = resultDAO.getAll();
        Map<Integer, Result> resultsMap = new HashMap<>();
        for (Result r : results) {
            resultsMap.put(r.getMatchId(), r);
        }

        request.setAttribute("matches", matches);
        request.setAttribute("resultsMap", resultsMap);

        request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
    }
}