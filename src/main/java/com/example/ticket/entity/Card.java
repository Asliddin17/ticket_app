package com.example.ticket.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Data;

@Data
@Entity
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
