package com.football.controller;
import com.football.dao.TeamDAO;
import com.football.model.Team;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/teams")
public class TeamsPublicServlet extends HttpServlet {
    private TeamDAO teamDAO = new TeamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Team> teams = teamDAO.getAll();
        request.setAttribute("teams", teams);
        request.getRequestDispatcher("/WEB-INF/jsp/teams.jsp").forward(request, response);
    }
}
