package com.example.ticket.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
public class History {
    @Id
    private String id;

    @ManyToOne
    private User user;

    @ManyToOne
    private Ticket ticket;

    @ManyToOne
    private Event event;

    private int count;
    private LocalDate date;
}
