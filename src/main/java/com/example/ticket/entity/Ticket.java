package com.example.ticket.entity;

import com.example.ticket.entity.enums.Status;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Ticket {
    @Id
    private String id;

    private String placeNumber;

    @ManyToOne
    private Event event;

    @ManyToOne
    private User user;

    @Enumerated(EnumType.STRING)
    private Status status;
}
