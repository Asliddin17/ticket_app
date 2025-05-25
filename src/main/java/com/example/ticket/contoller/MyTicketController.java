package com.example.ticket.contoller;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.service.EventService;
import com.example.ticket.service.TicketService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/my-tickets")
public class MyTicketController extends HttpServlet {
    EventService eventService = new EventService();
    private final TicketService ticketService = new TicketService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            req.setAttribute("tickets", ticketService.getActiveTickets(req.getSession().getAttribute("user_id").toString()));
            req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
        }else {
            resp.sendRedirect("/signin");
        }
    }

//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        eventService.editEvent(req, resp);
//    }
}
