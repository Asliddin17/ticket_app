package com.example.ticket.contoller;

import com.example.ticket.entity.enums.Role;
import com.example.ticket.service.EventService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private final EventService eventService = new EventService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req) && req.getSession().getAttribute("role").equals(Role.ADMIN)) {
            req.setAttribute("events", eventService.getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard/admin.jsp").forward(req, resp);
        } else if (Util.isSessionValid(req) && req.getSession().getAttribute("role").equals(Role.USER)) {
            req.setAttribute("events", eventService.getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard/user.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }
}
