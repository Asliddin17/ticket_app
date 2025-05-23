package com.example.ticket.contoller.auth;

import com.example.ticket.entity.enums.Role;
import com.example.ticket.service.AuthService;
import com.example.ticket.utils.Util;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/signup")
public class SignUpController extends HttpServlet {
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!Util.isSessionValid(req)) {
            req.getRequestDispatcher("/auth/signup.jsp").forward(req, resp);
        } else if (Util.isSessionValid(req) && req.getSession().getAttribute("role").equals(Role.ADMIN)) {
            req.getRequestDispatcher("/dashboard/admin.jsp").forward(req, resp);
        } else if (Util.isSessionValid(req) && req.getSession().getAttribute("role").equals(Role.USER)) {
            req.getRequestDispatcher("/dashboard/user.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("/signin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        authService.signUp(req, resp);
    }
}
