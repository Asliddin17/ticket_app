package com.example.ticket.contoller;

import com.example.ticket.service.EventService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/changeStatus")
public class ChangeStatusEventController extends HttpServlet {
    private final EventService eventService = new EventService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            eventService.changeStatusEvent(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }
}
