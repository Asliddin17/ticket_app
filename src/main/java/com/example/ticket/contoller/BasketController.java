package com.example.ticket.contoller;

import com.example.ticket.service.BasketService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.ticket.utils.Util.isSessionValid;

@WebServlet("/basket")
public class BasketController extends HttpServlet {
    private final BasketService basketService = new BasketService();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (isSessionValid(req)) {
            req.getRequestDispatcher("/dashboard/pages/basket.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            basketService.addBasket(req, resp);
        } else if ("remove".equals(action)) {
            basketService.removeBasket(req, resp);
        } else {
            req.setAttribute("message", "Invalid action");
            req.getRequestDispatcher("/dashboard/pages/basket.jsp").forward(req, resp);
        }
    }
}
