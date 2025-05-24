package com.example.ticket.utils;

import com.example.ticket.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

public interface Util {

    String path = "D:\\Personal\\photos\\";
    String path2 = "C:\\Java\\photos\\";

    static User currentUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute("user_id");
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

    static boolean isValidBalance(String balance) {
        if (balance == null) return false;
        return balance.matches("\\d+(\\.\\d+)?");
    }

    static boolean isValidExpiryDate(String date) {
        if (date == null) return false;
        return date.matches("(0[1-9]|1[0-2])/\\d{2}");
    }

    static boolean isValidCardNumber(String number) {
        if (number == null) return false;
        String digitsOnly = number.replaceAll("\\s+", "");
        return digitsOnly.matches("\\d{16}");
    }

    static boolean isValidCvv(String cvv) {
        if (cvv == null) return false;
        return cvv.matches("\\d{3}");
    }

    static boolean isValidEventName(String eventName) {
        return eventName != null && !eventName.trim().isEmpty();
    }

    static boolean isValidDate(String date) {
        return date != null && !date.trim().isEmpty();
    }

    static boolean isValidCapacity(String capacity) {
        return capacity != null && !capacity.trim().isEmpty() && capacity.matches("\\d+");
    }

    static boolean isValidDescription(String description) {
        return description != null && !description.trim().isEmpty();
    }

    static boolean isValidImage(Part img) {
        if (img == null || img.getSize() == 0) {
            return false;
        }
        String contentType = img.getContentType();
        if (!contentType.startsWith("image/")) {
            return false;
        }
        long maxFileSize = 5 * 1024 * 1024;
        return img.getSize() <= maxFileSize;
    }
}
