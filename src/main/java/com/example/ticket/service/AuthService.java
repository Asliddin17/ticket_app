package com.example.ticket.service;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.User;
import com.example.ticket.entity.enums.Role;
import jakarta.persistence.EntityManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;

import java.util.UUID;

import static com.example.ticket.utils.Util.*;

public class AuthService {
    private final JpaConnection jpa = JpaConnection.getInstance();

    @SneakyThrows
    public void signIn(HttpServletRequest req, HttpServletResponse resp) {
        EntityManager entityManager = jpa.entityManager();

        String email = req.getParameter("email");
        String pass = req.getParameter("pass");

        if (isValidEmail(email) && isValidPassword(pass)) {
            User singleResult = entityManager.createQuery("select u from User u where u.email= :email and u.password= :pass", User.class).setParameter("email", email).setParameter("pass", pass).getSingleResultOrNull();
            if (singleResult != null) {
                req.getSession().setAttribute("user_id", singleResult.getId());
                req.getSession().setAttribute("role", singleResult.getRole());
                if (req.getSession().getAttribute("role") == Role.USER) {
                    resp.sendRedirect("/user");
                } else {
                    resp.sendRedirect("/admin");
                }
            } else {
                req.setAttribute("message", "Invalid email or password. Please try again.");
                req.getRequestDispatcher("/auth/signin.jsp").forward(req, resp);
            }

        } else {
            req.setAttribute("message", "There was an error with the provided information.");
            req.getRequestDispatcher("/auth/signin.jsp").forward(req, resp);
        }
        entityManager.close();
    }

    @SneakyThrows
    public void signUp(HttpServletRequest req, HttpServletResponse resp) {
        EntityManager entityManager = jpa.entityManager();

        String fullName = req.getParameter("name");
        String email = req.getParameter("email");
        String pass = req.getParameter("pass");

        if (isValidEmail(email) && isValidPassword(pass) && isValidFullName(fullName)) {
            if (entityManager.createQuery("select u from User u where u.email = :email", User.class).setParameter("email", email).getSingleResultOrNull() == null) {
                entityManager.getTransaction().begin();
                String id = UUID.randomUUID().toString();
                entityManager.persist(User.builder()
                        .id(id)
                        .fullName(fullName)
                        .email(email)
                        .password(pass)
                        .role(Role.USER)
                        .build()
                );
                entityManager.getTransaction().commit();
                req.getSession().setAttribute("user_id", id);

                req.getRequestDispatcher("/dashboard/user.jsp").forward(req, resp);
            } else {
                req.setAttribute("message", "This email already registered");
                req.getRequestDispatcher("/auth/signup.jsp").forward(req, resp);
            }

        } else {
            req.setAttribute("message", "There was an error with the provided information.");
            req.getRequestDispatcher("/auth/signup.jsp").forward(req, resp);
        }

        entityManager.close();
    }

    @SneakyThrows
    public void logOut(HttpServletRequest req, HttpServletResponse resp) {
        req.getSession().invalidate();
        resp.sendRedirect("/");
    }
}
