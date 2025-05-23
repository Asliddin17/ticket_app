package com.example.ticket.service;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.Basket;
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

public class BasketService {
    private final JpaConnection jpaConnection = JpaConnection.getInstance();

    @SneakyThrows
    public void addBasket(HttpServletRequest req, HttpServletResponse resp) {
        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        User currentUser = Util.currentUser(req);

        transaction.begin();
        Basket basket = new Basket();
        basket.setId(UUID.randomUUID().toString());
        basket.setUser(currentUser);
        basket.setStatus(Status.ACTIVE);

        entityManager.persist(basket);
        transaction.commit();
        entityManager.close();
    }

    @SneakyThrows
    public void removeBasket(HttpServletRequest req, HttpServletResponse resp) {
        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        User currentUser = Util.currentUser(req);

        String basketId = req.getParameter("basketId");
        String[] ticketIds = req.getParameterValues("ticketIds");

        if (basketId != null || basketId.isEmpty()) {
            req.setAttribute("message", "invalid basketId");
            req.getRequestDispatcher("/dashboard/pages/basket.jsp").forward(req, resp);
            entityManager.close();
            return;
        }
        if (ticketIds == null || ticketIds.length == 0) {
            req.setAttribute("message", "Please provide at least one ticket ID to remove");
            req.getRequestDispatcher("/dashboard/pages/basket.jsp").forward(req, resp);
            entityManager.close();
            return;
        }

        transaction.begin();

        Basket basket = entityManager.find(Basket.class, basketId);
        if (basket == null) {
            req.setAttribute("message", "basket not found");
            req.getRequestDispatcher("/dashboard/pages/basket.jsp").forward(req, resp);
            entityManager.close();
            return;
        }

        if (!basket.getUser().getId().equals(currentUser.getId())) {
            req.setAttribute("message", "You are not authorized to delete this basket");
            req.getRequestDispatcher("/dashboard/pages/basket.jsp").forward(req, resp);
            transaction.rollback();
            entityManager.close();
            return;
        }
        for (String ticketId : ticketIds) {
            Ticket ticket = entityManager.find(Ticket.class, ticketId);
            if (ticket != null && basket.equals(ticket.getBasket())) {
                ticket.setBasket(null); // Remove the ticket from the basket
                entityManager.merge(ticket);
            }
        }
        transaction.commit();
        entityManager.close();
    }
}
