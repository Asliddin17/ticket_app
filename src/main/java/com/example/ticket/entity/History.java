package com.example.ticket.entity;

import lombok.Data;

import java.time.LocalDate;

@Data
public class History {
    private String id;
    private User user;
    private Ticket ticket;
    private Event event;
    private int count;
    private LocalDate date;
}
