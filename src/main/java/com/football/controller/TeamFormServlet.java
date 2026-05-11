package com.football.controller;

import com.football.dao.TeamDAO;
import com.football.model.Team;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/team-form")
public class TeamFormServlet extends HttpServlet {
    private TeamDAO teamDAO = new TeamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login"); return;
        }
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            request.setAttribute("team", teamDAO.getById(Integer.parseInt(id)));
        }
        request.getRequestDispatcher("/WEB-INF/jsp/admin/team-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");

        Team team = new Team();
        team.setName(request.getParameter("name"));
        team.setCountry(request.getParameter("country"));
        team.setCity(request.getParameter("city"));
        team.setFoundationYear(Integer.parseInt(request.getParameter("foundationYear")));
        team.setLogo(request.getParameter("logo"));

        if (id != null && !id.isEmpty()) {
            team.setId(Integer.parseInt(id));
            teamDAO.update(team);
        } else {
            teamDAO.add(team);
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}