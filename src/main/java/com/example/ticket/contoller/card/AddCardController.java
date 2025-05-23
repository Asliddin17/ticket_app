package com.example.ticket.contoller.card;

import com.example.ticket.service.CardService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/card")
public class AddCardController extends HttpServlet {
    private final CardService cardService = CardService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            req.getRequestDispatcher("/dashboard/pages/card.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            cardService.addCard(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }
}
