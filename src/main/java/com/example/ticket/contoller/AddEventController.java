package com.example.ticket.contoller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.ticket.utils.Util.isSessionValid;

@WebServlet("/event")
public class AddEventController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (isSessionValid(req)) {
            req.getRequestDispatcher("/dashboard/pages/add.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/login");
        }
    }
}
