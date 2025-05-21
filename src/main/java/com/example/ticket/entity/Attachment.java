package com.example.ticket.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Attachment {
    @Id
    private String id;
    private String name;
    private String suffix;
    private Integer fileSize;
    private String path;
}
