package com.example.ticket.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
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
    private LocalDateTime date;
}
