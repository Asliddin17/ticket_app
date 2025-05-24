package com.example.ticket.contoller;

import com.example.ticket.service.PaymentService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/payment")
public class PaymentController extends HttpServlet {
    private final PaymentService paymentService = new PaymentService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (Util.isSessionValid(req)) {
            paymentService.processPayment(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }
}
