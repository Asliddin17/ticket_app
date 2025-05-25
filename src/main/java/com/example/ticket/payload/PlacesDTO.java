package com.example.ticket.payload;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PlacesDTO {
    private String placeNumber;
    private String eventId;
    private int capacity;
    private Double price;
}
