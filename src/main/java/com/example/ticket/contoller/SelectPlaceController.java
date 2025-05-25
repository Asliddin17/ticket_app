package com.example.ticket.contoller;


import com.example.ticket.service.CardService;
import com.example.ticket.service.EventService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/place")
public class SelectPlaceController extends HttpServlet {
    private final EventService eventService = new EventService();
    private final CardService cardService = CardService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            req.setAttribute("places", eventService.placesDTOS(req.getParameter("eventId")));
            req.setAttribute("cards", cardService.getAllCards(req, resp));

            req.getRequestDispatcher("/dashboard/pages/places.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
