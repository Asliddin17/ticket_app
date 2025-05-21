package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Basket {
    @Id
    private String id;
    @OneToMany
    private Ticket ticket;
    @OneToMany
    private User user;
    @Enumerated(EnumType.STRING)
    private Status status;
}
