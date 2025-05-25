package com.example.ticket.service;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.*;
import com.example.ticket.entity.enums.Status;
import jakarta.persistence.EntityManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

public class PaymentService {
    private final JpaConnection jpa = JpaConnection.getInstance();

    public void processPayment(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String eventId = req.getParameter("eventId");
        String placeName = req.getParameter("placeName");
        String cardId = req.getParameter("cardId");

        EntityManager entityManager = jpa.entityManager();
        User user = entityManager.find(User.class, req.getSession().getAttribute("user_id"));
        Card card = entityManager.find(Card.class, cardId);
        Event event = entityManager.find(Event.class, eventId);
        String[] split = placeName.split(",");

        if (card.getBalance() > event.getPrice() * split.length) {
            entityManager.getTransaction().begin();
            for (String s : split) {
                Ticket build = Ticket.builder()
                        .id(UUID.randomUUID().toString())
                        .placeNumber(s)
                        .event(event)
                        .user(user)
                        .status(Status.ACTIVE)
                        .build();
                entityManager.persist(build
                );

                entityManager.persist(History.builder()
                        .id(UUID.randomUUID().toString())
                        .count(1)
                        .date(LocalDateTime.now())
                        .event(event)
                        .user(user)
                        .ticket(build)
                        .build()
                );
            }

            entityManager.createQuery("update Card c set c.balance=c.balance-:balance where c.owner.id=:userId")
                    .setParameter("userId", user.getId()).setParameter("balance", event.getPrice() * split.length).executeUpdate();

            entityManager.getTransaction().commit();
            resp.sendRedirect("/place?eventId=" + eventId);
        } else {
            resp.sendRedirect("/card-list");
        }

        entityManager.close();
    }
}
