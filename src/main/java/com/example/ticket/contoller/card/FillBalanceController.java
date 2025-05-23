package com.example.ticket.contoller.card;

import com.example.ticket.service.CardService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/fill")
public class FillBalanceController extends HttpServlet {
    private final CardService cardService = CardService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            req.setAttribute("cards", cardService.getAllCards(req, resp));
            req.getRequestDispatcher("/dashboard/pages/fill.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (Util.isSessionValid(req)) {
            cardService.fillBalanceCard(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }
}
