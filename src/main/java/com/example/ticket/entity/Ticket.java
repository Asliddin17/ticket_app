package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
public class Ticket {
    @Id
    private String id;
    @OneToOne
    private Event event;
    @OneToOne
    private User user;
    @Enumerated(EnumType.STRING)
    private Status status;
}
