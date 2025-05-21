package com.example.ticket.repository;

import com.example.ticket.entity.Attachment;
import lombok.SneakyThrows;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Optional;
import java.util.UUID;

import static com.example.ticket.db.Datasource.connection;


public class AttachmentRepository {

    @SneakyThrows
    public void saveData(Attachment attachment) {
        try (PreparedStatement ps = connection().prepareStatement("INSERT INTO attachment values (?, ?, ?, ?, ?)")) {
            ps.setObject(1, attachment.getId());
            ps.setString(2, attachment.getName());
            ps.setString(3, attachment.getSuffix());
            ps.setInt(4, attachment.getFileSize());
            ps.setString(5, attachment.getPath());

            ps.execute();
        }
    }

    @SneakyThrows
    public Optional<Attachment> getPhotoById(UUID id) {
        try (PreparedStatement ps = connection().prepareStatement("SELECT * FROM attachment WHERE id = ?::uuid")) {
            ps.setObject(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(Attachment.builder()
                            .id(rs.getString("id"))
                            .name(rs.getString("name"))
                            .suffix(rs.getString("suffix"))
                            .fileSize(rs.getInt("file_size"))
                            .path(rs.getString("path"))
                            .build());
                }
                return Optional.empty();
            }
        }
    }
}
