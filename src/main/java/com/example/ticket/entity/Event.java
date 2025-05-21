package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Id;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
public class Event {
    @Id
    private String id;
    private String name;
    private LocalDate date;
    private int capacity;
    @Enumerated(EnumType.STRING)
    private Status status;
    private String description;
}
