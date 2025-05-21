package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import lombok.Data;

@Data
public class Ticket {
    private String id;
    private Event event;
    private User user;
    private Status status;
}
