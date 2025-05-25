package com.example.ticket.contoller;

import com.example.ticket.service.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/edit")
@MultipartConfig
public class EditEventController extends HttpServlet {
    private final EventService eventService = new EventService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        eventService.editEvent(req, resp);
    }
}
