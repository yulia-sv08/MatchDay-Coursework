package com.football.controller;

import com.football.dao.MatchDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/delete-match")
public class DeleteMatchServlet extends HttpServlet {
    private MatchDAO matchDAO = new MatchDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            matchDAO.delete(Integer.parseInt(idParam));
        }

        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
