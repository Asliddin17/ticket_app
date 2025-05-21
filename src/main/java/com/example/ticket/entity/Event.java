package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import lombok.Data;

import java.time.LocalDate;

@Data
public class Event {
    private String id;
    private String name;
    private LocalDate date;
    private int capacity;
    private Status status;
    private String description;
}
