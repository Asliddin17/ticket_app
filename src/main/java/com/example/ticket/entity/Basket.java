package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
public class Basket {
    @Id
    private String id;

    @ManyToOne
    private User user;

    @OneToMany(mappedBy = "basket")
    private List<Ticket> tickets;

    @Enumerated(EnumType.STRING)
    private Status status;
}
