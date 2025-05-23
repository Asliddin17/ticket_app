package com.example.ticket.service;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.Event;
import com.example.ticket.entity.Ticket;
import com.example.ticket.entity.User;
import com.example.ticket.entity.enums.Status;
import com.example.ticket.utils.Util;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;

import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.UUID;

import static com.example.ticket.db.JpaConnection.jpaConnection;

public class EventService {
    JpaConnection jpaConnection = JpaConnection.getInstance();
    @SneakyThrows
    public void addEvent(HttpServletRequest req, HttpServletResponse resp) {
//        User currentUser = Util.currentUser(req);
//        if (currentUser == null) {
//            req.setAttribute("message", "please sign in first");
//            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
//        }
        String eventName = req.getParameter("eventName");
        String date = req.getParameter("date");
        String capacity = req.getParameter("capacity");
        String attachmentId = req.getParameter("attachmentId");
        String status = req.getParameter("status");
        String description = req.getParameter("description");
        String ticketId = req.getParameter("ticketId");


        if (eventName == null || eventName.isEmpty()) {
            req.setAttribute("message", "please enter eventName");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
        }
        if (date == null || date.isEmpty()) {
            req.setAttribute("message", "Please enter event date");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }
        if (capacity == null || capacity.isEmpty()) {
            req.setAttribute("message", "Please enter event capacity");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }
        if (status == null || status.isEmpty()) {
            req.setAttribute("message", "Please select event status");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }
        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            LocalDateTime evenDate;
            try {
                evenDate = LocalDateTime.parse(date);
            } catch (DateTimeParseException e) {
                req.setAttribute("message", "Please enter event date");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                return;
            }
            int eventCapacity = Integer.parseInt(capacity);
            try {
                if (eventCapacity <= 0) {
                    req.setAttribute("message", "Please enter event capacity");
                    req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                req.setAttribute("message", "Please enter event capacity");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                return;
            }
            Status eventStatus;
            try {
                eventStatus = Status.valueOf(status);
            } catch (IllegalArgumentException e) {
                req.setAttribute("message", "Please select event status");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                return;
            }

            Event event = new Event();
            event.setId(UUID.randomUUID().toString());
            event.setName(eventName);
            event.setDate(evenDate);
            event.setCapacity(eventCapacity);
            event.setAttachmentId(attachmentId);
            event.setStatus(eventStatus);
            event.setDescription(description);

            if (ticketId != null) {
                List<Ticket> tickets = entityManager.createQuery(
                                "select t from Ticket t where t.id =:ticketId", Ticket.class)
                        .setParameter("ticketId", ticketId)
                        .getResultList();
                event.setTickets(tickets);
            }
            entityManager.persist(event);
            transaction.commit();

            resp.sendRedirect("/dashboard");
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", "Something went wrong");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
        } finally {
            entityManager.close();
        }
    }

    @SneakyThrows
    public void editEvent(HttpServletRequest req, HttpServletResponse resp) {
        User currentUser = Util.currentUser(req);
        if (currentUser == null) {
            req.setAttribute("message", "please sign in first");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }
        String eventName = req.getParameter("eventName");
        String date = req.getParameter("date");
        String capacity = req.getParameter("capacity");
        String attachmentId = req.getParameter("attachmentId");
        String status = req.getParameter("status");
        String description = req.getParameter("description");
        String ticketId = req.getParameter("ticketId");

        if (eventName == null || eventName.isEmpty()) {
            req.setAttribute("message", "Please enter event name");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
            return;
        }
        if (date == null || date.isEmpty()) {
            req.setAttribute("message", "Please enter event date");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
            return;
        }
        if (capacity == null || capacity.isEmpty()) {
            req.setAttribute("message", "Please enter event capacity");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
            return;
        }
        if (status == null || status.isEmpty()) {
            req.setAttribute("message", "Please select event status");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
            return;
        }

        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            Event event = entityManager.find(Event.class, UUID.fromString(eventName));
            if(event == null) {
                req.setAttribute("message", "Please enter event name");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
                return;
            }
            LocalDateTime evenDate;
            try {
                evenDate = LocalDateTime.parse(date);
            } catch (DateTimeParseException e) {
                req.setAttribute("message", "Please enter event date");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
                return;
            }
            int eventCapacity;
            try {
                eventCapacity = Integer.parseInt(capacity);
                if (eventCapacity <= 0) {
                    req.setAttribute("message", "Please enter event capacity");
                    req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
                    return;
                }
            }catch (NumberFormatException e) {
                req.setAttribute("message", "Please enter event capacity");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
                return;
            }
            Status eventStatus;
            try {
                eventStatus = Status.valueOf(status);
            }catch (IllegalArgumentException e) {
                req.setAttribute("message", "Please select event status");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
                return;
            }

            event.setName(eventName);
            event.setDate(evenDate);
            event.setCapacity(eventCapacity);
            event.setAttachmentId(attachmentId);
            event.setStatus(eventStatus);
            event.setDescription(description);

            if(ticketId != null && !ticketId.isEmpty()) {
                List<Ticket> tickets = entityManager.createQuery
                        ("select t from Ticket t where t.id =:ticketId", Ticket.class)
                        .setParameter("ticketId",ticketId)
                        .getResultList();
                event.setTickets(tickets);
            }else {
                event.setTickets(null);
            }
            entityManager.merge(event);
            transaction.commit();
            resp.sendRedirect("/dashboard");
        }catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", "Something went wrong");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
        }finally {
            entityManager.close();
        }

    }

    @SneakyThrows
    public void changeStatusEvent(HttpServletRequest req, HttpServletResponse resp) {
        User currentUser = Util.currentUser(req);
        if (currentUser == null) {
            req.setAttribute("message", "Please sign in first");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
            return;
        }

        String eventId = req.getParameter("eventId");
        String status = req.getParameter("status");

        if (eventId == null || eventId.isEmpty()) {
            req.setAttribute("message", "Please enter event ID");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }
        if (status == null || status.isEmpty()) {
            req.setAttribute("message", "Please select event status");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }

        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Event event = entityManager.find(Event.class, UUID.fromString(eventId));
            if(event == null) {
                req.setAttribute("message", "Please enter event name");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req,resp);
                return;
            }
            Status eventStatus;
            try {
                eventStatus = Status.valueOf(status);
            }catch (IllegalArgumentException e) {
                req.setAttribute("message", "Please select event status");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                return;
            }
            event.setStatus(eventStatus);

            entityManager.merge(event);
            transaction.commit();

            resp.sendRedirect("/dashboard");
        }catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", "Something went wrong");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
        }finally {
            entityManager.close();
        }
    }
}
