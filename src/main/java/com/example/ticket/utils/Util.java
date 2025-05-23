package com.example.ticket.utils;

import com.example.ticket.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public interface Util {
    static User currentUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute("currentUser");
    }

    static boolean isSessionValid(HttpServletRequest req) {
        Object id = req.getSession().getAttribute("user_id");
        return id != null && id.toString() != null && !id.toString().isEmpty();
    }

    static boolean isValidEmail(String email) {
        if (email == null || email.isBlank()) return false;
        return email.contains("@") && email.indexOf('@') > 0 && email.lastIndexOf('.') > email.indexOf('@') + 1;
    }

    static boolean isValidPassword(String password) {
        if (password == null || password.length() < 6) return false;

        boolean hasLetter = false;
        boolean hasDigit = false;

        for (char c : password.toCharArray()) {
            if (Character.isLetter(c)) hasLetter = true;
            else if (Character.isDigit(c)) hasDigit = true;

            if (hasLetter && hasDigit) return true;
        }

        return false;
    }

    static boolean isValidFullName(String fullName) {
        if (fullName == null || fullName.isBlank()) return false;

        for (char c : fullName.toCharArray()) {
            if (!Character.isLetter(c) && c != ' ' && c != '\'') return false;
        }

        return true;
    }
}
