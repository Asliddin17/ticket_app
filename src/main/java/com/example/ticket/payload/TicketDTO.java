package com.example.ticket.payload;

import com.example.ticket.entity.enums.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class TicketDTO {
    private String id;
    private String placeNumber;
    private String eventName;
    private Status status;
    private String attachmentId;

}
