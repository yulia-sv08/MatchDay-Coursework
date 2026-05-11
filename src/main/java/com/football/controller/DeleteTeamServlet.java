package com.football.controller;

import com.football.dao.TeamDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/delete-team")
public class DeleteTeamServlet extends HttpServlet {
    private TeamDAO teamDAO = new TeamDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // перевіряємо що це адмін
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            teamDAO.delete(Integer.parseInt(idParam));
        }

        // повертаємося в адмін-панель
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}