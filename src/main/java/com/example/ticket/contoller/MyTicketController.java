package com.example.ticket.contoller;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.service.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/my-tickets")
public class MyTicketController extends HttpServlet {
    EventService eventService = new EventService();
    JpaConnection jpaConnection = JpaConnection.getInstance();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        eventService.editEvent(req, resp);
    }
}
