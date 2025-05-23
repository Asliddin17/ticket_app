package com.example.ticket.service;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.Card;
import com.example.ticket.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import static com.example.ticket.utils.Util.*;

public class CardService {
    private static CardService instance;
    private final JpaConnection jpa = JpaConnection.getInstance();

    public void addCard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager entityManager = jpa.entityManager();
        String number = req.getParameter("number");
        String holder = req.getParameter("holder");
        String cvv = req.getParameter("cvv");
        String date = req.getParameter("date");
        String balance = req.getParameter("balance");

        if (isValidFullName(holder) && isValidBalance(balance) && isValidExpiryDate(date) && isValidCvv(cvv) && isValidCardNumber(number)) {
            if (entityManager.createQuery("select c from Card c where c.cardExpiryDate = :number", Card.class).setParameter("number", number).getSingleResultOrNull() == null) {

                entityManager.getTransaction().begin();

                entityManager.persist(
                        Card.builder()
                                .id(UUID.randomUUID().toString())
                                .owner(entityManager.find(User.class, req.getSession().getAttribute("user_id")))
                                .holderName(holder)
                                .cardNumber(number)
                                .cardExpiryDate(date)
                                .cardCVV(cvv)
                                .balance(Double.parseDouble(balance))
                                .build());

                entityManager.getTransaction().commit();

                req.setAttribute("message", "Card added successfully\nYou can view your card in the list of cards.");
                req.getRequestDispatcher("/dashboard/pages/card.jsp").forward(req, resp);
            } else {
                req.setAttribute("message", "Card information is incorrect.");
                req.getRequestDispatcher("/dashboard/pages/card.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("message", "Invalid information. Please try again.");
            req.getRequestDispatcher("/dashboard/pages/card.jsp").forward(req, resp);
        }

        entityManager.close();
    }

    public List<Card> getAllCards(HttpServletRequest req, HttpServletResponse resp) {
        EntityManager entityManager = jpa.entityManager();
        List<Card> resultList = entityManager.createQuery("select c from Card c where owner.id = :id", Card.class).setParameter("id", req.getSession().getAttribute("user_id")).getResultList();
        entityManager.close();

        return resultList;
    }

    @SneakyThrows
    public void fillBalanceCard(HttpServletRequest req, HttpServletResponse resp) {
        EntityManager entityManager = jpa.entityManager();
        Card card = entityManager.createQuery("select c from Card c where c.id = :number and c.owner.id = :id", Card.class)
                .setParameter("number", req.getParameter("card"))
                .setParameter("id", req.getSession().getAttribute("user_id"))
                .getSingleResultOrNull();

        if (card != null) {
            entityManager.getTransaction().begin();
            card.setBalance(card.getBalance() + Double.parseDouble(req.getParameter("balance")));
            entityManager.persist(card);
            entityManager.getTransaction().commit();
            req.setAttribute("message", "Balance filled successfully");
            req.getRequestDispatcher("/dashboard/pages/fill.jsp").forward(req, resp);
        } else {
            req.setAttribute("message", "Card not found. Please try again.");
            req.getRequestDispatcher("/dashboard/pages/card.jsp").forward(req, resp);
        }

        entityManager.close();
    }

    public static CardService getInstance() {
        if (instance == null) {
            instance = new CardService();
        }
        return instance;
    }
}
