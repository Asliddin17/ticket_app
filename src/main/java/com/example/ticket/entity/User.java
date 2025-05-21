package com.example.ticket.entity;

import com.example.ticket.entity.enums.Role;
import lombok.Data;

@Data
public class User {
    private String id;
    private String fullName;
    private String email;
    private String password;
    private Role role;
}
