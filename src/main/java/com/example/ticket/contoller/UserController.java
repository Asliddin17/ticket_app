package com.example.ticket.contoller;

import com.example.ticket.service.EventService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user")
public class UserController extends HttpServlet {
    private final EventService eventService = new EventService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            req.setAttribute("events", eventService.getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard/user.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }
}
