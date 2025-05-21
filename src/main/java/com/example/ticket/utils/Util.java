package com.example.ticket.utils;

import com.example.ticket.entity.User;
import jakarta.servlet.http.HttpServletRequest;

public interface Util {
    static User currentUser(HttpServletRequest request){
        return (User)request.getSession().getAttribute("currentUser");
    }
}
