package com.example.ticket.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
public class History {
    @Id
    private String id;
    @OneToMany
    private User user;
    @OneToMany
    private Ticket ticket;
    @OneToMany
    private Event event;
    private int count;
    private LocalDate date;
}
