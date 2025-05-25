package com.example.ticket.contoller;

import com.example.ticket.service.TicketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/cancel")
public class CancelTicketController extends HttpServlet {
    private final TicketService ticketService = new TicketService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ticketService.cancelTicket(req, resp);
    }
}
