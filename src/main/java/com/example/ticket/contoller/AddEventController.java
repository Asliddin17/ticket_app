package com.example.ticket.contoller;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.Event;
import com.example.ticket.entity.Ticket;
import com.example.ticket.entity.User;
import com.example.ticket.entity.enums.Status;
import com.example.ticket.service.EventService;
import com.example.ticket.utils.Util;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.UUID;

import static com.example.ticket.utils.Util.isSessionValid;

@WebServlet("/event")
public class AddEventController extends HttpServlet {
    EventService eventService = new EventService();
    JpaConnection jpaConnection = JpaConnection.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (isSessionValid(req)) {
            req.getRequestDispatcher("/dashboard/pages/add.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        eventService.addEvent(req, resp);
    }
}


