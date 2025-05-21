package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
@Entity
public class Event {
    @Id
    private String id;

    private String name;
    private LocalDate date;
    private int capacity;
    private String attachmentId;

    @Enumerated(EnumType.STRING)
    private Status status;

    private String description;

    @OneToMany(mappedBy = "event")
    private List<Ticket> tickets;

    @OneToMany(mappedBy = "event")
    private List<History> histories;
}
