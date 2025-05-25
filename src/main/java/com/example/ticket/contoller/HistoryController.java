package com.example.ticket.contoller;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.History;
import com.example.ticket.utils.Util;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class HistoryController extends HttpServlet {
    private final JpaConnection jpaConnection = JpaConnection.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            EntityManager entityManager = jpaConnection.entityManager();
            List<History> resultList = entityManager.createQuery(
                            "select h from History h where h.user.id = :userId order by h.date desc", History.class)
                    .setParameter("userId", req.getSession().getAttribute("user_id"))
                    .getResultList();

            req.setAttribute("history", resultList);
            req.getRequestDispatcher("/dashboard/pages/history.jsp").forward(req, resp);
            entityManager.close();
        } else {
            resp.sendRedirect("/signin");
        }
    }
}
