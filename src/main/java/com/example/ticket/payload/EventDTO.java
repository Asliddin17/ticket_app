package com.example.ticket.payload;

import com.example.ticket.entity.Attachment;
import com.example.ticket.entity.enums.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class EventDTO {
    private String id;
    private String name;
    private LocalDate date;
    private int capacity;
    private String attachmentId;
    private Status status;
    private String description;
}
