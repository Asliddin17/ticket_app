package com.example.ticket.contoller;


import com.example.ticket.payload.EventDTO;
import com.example.ticket.service.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

//@WebServlet(urlPatterns = {"/edit", "/add", "/delete", "/changeStatus", "/dashboard"})
//@MultipartConfig
public class EventController extends HttpServlet {
//    private final EventService eventService = new EventService();
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String path = req.getServletPath();
//        switch (path) {
//            case "/edit":
//                eventService.editEvent(req, resp);
//                break;
//            case "/add":
//                eventService.addEvent(req, resp);
//                break;
//            case "/delete":
////                eventService.deleteEvent(req, resp);
//                break;
//            case "/changeStatus":
//                eventService.changeStatusEvent(req, resp);
//                break;
//            default:
//                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
//        }
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String path = req.getServletPath();
//        if ("/dashboard".equals(path)) {
//            req.setAttribute("events", eventService.getAllEventsForAdmin());
//            req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
//        } else if ("/edit".equals(path)) {
//            String eventId = req.getParameter("id");
//            if (eventId == null || eventId.trim().isEmpty()) {
//                req.setAttribute("message", "Invalid event ID");
//                req.setAttribute("events", eventService.getAllEventsForAdmin());
//                req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
//                return;
//            }
//
//
//            List<EventDTO> events = eventService.getAllEventsForAdmin();
//            EventDTO eventDTO = events.stream()
//                    .filter(event -> event.getId().equals(eventId))
//                    .findFirst()
//                    .orElse(null);
//
//            if (eventDTO == null) {
//                req.setAttribute("message", "Event not found");
//                req.setAttribute("events", events);
//                req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
//                return;
//            }
//
//            req.setAttribute("eventDTO", eventDTO);
//            req.getRequestDispatcher("/edit.jsp").forward(req, resp);
//        } else {
//            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
//        }
//    }
}
