package com.example.ticket.contoller;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.service.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ChangeStatusEventController extends HttpServlet {
    EventService eventService = new EventService();
    JpaConnection jpaConnection = JpaConnection.getInstance();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/event").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        eventService.changeStatusEvent(req, resp);
    }
}
