package com.example.ticket.service;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.Basket;
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

import java.util.UUID;


public class TicketService {
    JpaConnection jpaConnection = JpaConnection.getInstance();

    @SneakyThrows
    public void buyTicket(HttpServletRequest req, HttpServletResponse resp) {
        User currentUser = Util.currentUser(req);
        String eventId = req.getParameter("eventId");
        String basketId = req.getParameter("basketId");

        if (eventId == null || eventId.isEmpty()) {
            req.setAttribute("message", "Please select an event");
            req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
            return;
        }
        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            Event event = entityManager.find(Event.class, eventId);
            if (event == null) {
                req.setAttribute("message", "Event not found");
                req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
                return;
            }
            if (event.getStatus() == null) {
                req.setAttribute("message", "Event status not found");
                req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
                return;
            }
            long ticketCount = entityManager.createQuery
                            ("select count(t) from Ticket t where t.event.id = :eventId and t.status = :status", Long.class)
                    .setParameter("eventId", eventId)
                    .getSingleResult();
            if (ticketCount >= event.getCapacity()) {
                req.setAttribute("message", "Event capacity exceeded");
                req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
                return;
            }
            Basket basket = null;
            if (basketId != null) {
                basket = entityManager.find(Basket.class, basketId);
                if (basket == null) {
                    req.setAttribute("message", "Basket not found");
                    req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
                    return;
                }
            }
            Ticket ticket = new Ticket();
            ticket.setId(UUID.randomUUID().toString());
            ticket.setEvent(event);
            ticket.setUser(currentUser);
            ticket.setBasket(basket);
            ticket.setStatus(Status.ACTIVE);

            entityManager.persist(ticket);
            transaction.commit();
            resp.sendRedirect(req.getContextPath() + "/my_ticket");
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", e.getMessage());
            req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
        } finally {
            entityManager.close();
        }
    }

    @SneakyThrows
    public void cancelTicket(HttpServletRequest req, HttpServletResponse resp) {
        User currentUser = Util.currentUser(req);
        String ticketId = req.getParameter("ticketId");
        if (ticketId == null || ticketId.isEmpty()) {
            req.setAttribute("message", "Please select an event");
            req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
        }
        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            Ticket ticket = entityManager.find(Ticket.class, ticketId);
            if (ticket == null) {
                req.setAttribute("message", "Ticket not found");
                req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
                return;
            }
            if (!ticket.getUser().getId().equals(currentUser.getId())) {
                req.setAttribute("message", "You are not allowed to cancel this ticket");
                req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
                return;
            }
            if (ticket.getStatus() == Status.ACTIVE) {
                req.setAttribute("message", "Ticket cancelled");
                req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
                return;
            }
            ticket.setStatus(Status.INACTIVE);
            entityManager.merge(ticket);
            transaction.commit();
            resp.sendRedirect(req.getContextPath() + "/my_ticket");
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", e.getMessage());
            req.getRequestDispatcher("/dashboard/pages/my_ticket.jsp").forward(req, resp);
        } finally {
            entityManager.close();
        }
    }
}
