package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Ticket {
    @Id
    private String id;

    @ManyToOne
    private Event event;

    private String price;

    @ManyToOne
    private User user;

    @ManyToOne
    private Basket basket;

    @Enumerated(EnumType.STRING)
    private Status status;
}
