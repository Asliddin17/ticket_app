package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Data
@Entity
public class Basket {
    @Id
    private String id;

    private Ticket ticket;
    private User user;
    private Status status;
}
