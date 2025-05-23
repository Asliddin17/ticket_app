package com.example.ticket.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Card {
    @Id
    private String id;

    @ManyToOne
    private User owner;
    private String holderName;
    private String cardNumber;
    private String cardExpiryDate;
    private String cardCVV;
    private Double balance;
}

