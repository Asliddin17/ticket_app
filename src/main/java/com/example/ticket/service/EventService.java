package com.example.ticket.service;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.Attachment;
import com.example.ticket.entity.Event;
import com.example.ticket.entity.User;
import com.example.ticket.entity.enums.Status;
import com.example.ticket.payload.EventDTO;
import com.example.ticket.utils.Util;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lombok.SneakyThrows;

import java.io.File;
import java.io.FileOutputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class EventService {
    JpaConnection jpaConnection = JpaConnection.getInstance();

    @SneakyThrows
    public void addEvent(HttpServletRequest req, HttpServletResponse resp) {
        EntityManager entityManager = jpaConnection.entityManager();

        String eventName = req.getParameter("name");
        String date = req.getParameter("date");
        String capacity = req.getParameter("capacity");
        String description = req.getParameter("description");
        Part img = req.getPart("img");

        if (Util.isValidEventName(eventName) && isValidDate(date) && Util.isValidCapacity(capacity)
                && Util.isValidDescription(description) && Util.isValidImage(img)) {

            entityManager.getTransaction().begin();

            String imgId = UUID.randomUUID().toString();
            Attachment attachment = Attachment.builder()
                    .id(imgId)
                    .name(img.getSubmittedFileName())
                    .suffix(img.getContentType().split("/")[1])
                    .fileSize(img.getInputStream().available())
                    .path(Util.path2.concat(imgId).concat(".").concat(img.getContentType().split("/")[1]))
                    .build();

            try (FileOutputStream outputStream = new FileOutputStream(attachment.getPath())) {
                outputStream.write(img.getInputStream().readAllBytes());
            }
            entityManager.persist(attachment);
            entityManager.persist(Event.builder()
                    .id(UUID.randomUUID().toString())
                    .name(eventName)
                    .date(LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE))
                    .capacity(Integer.parseInt(capacity))
                    .attachment(attachment)
                    .status(Status.ACTIVE)
                    .description(description)
                    .build()
            );
            entityManager.getTransaction().commit();

            req.setAttribute("message", "Event added successfully.");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
        } else {
            req.setAttribute("message", "The form is incomplete or incorrect. Please fill in all fields correctly.");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
        }

        entityManager.close();
    }

    @SneakyThrows
    public void editEvent(HttpServletRequest req, HttpServletResponse resp) {
        User currentUser = Util.currentUser(req);
        if (currentUser == null) {
            req.setAttribute("message", "Please sign in first");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }

        String eventId = req.getParameter("id");
        String name = req.getParameter("name");
        String date = req.getParameter("date");
        String capacity = req.getParameter("capacity");
        String description = req.getParameter("description");
        String status = req.getParameter("status");
        Part img = req.getPart("img");

        // Validate inputs
        if (eventId == null || eventId.trim().isEmpty()) {
            req.setAttribute("message", "Invalid event ID");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }
        if (!Util.isValidEventName(name)) {
            req.setAttribute("message", "Please enter a valid event name (at least 3 characters)");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }
        if (!isValidDate(date)) {
            req.setAttribute("message", "Please enter a valid event date (on or after 2025-01-01)");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }
        if (!Util.isValidCapacity(capacity)) {
            req.setAttribute("message", "Please enter a valid capacity (positive number)");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }
        if (!Util.isValidDescription(description)) {
            req.setAttribute("message", "Please enter a valid description (at least 10 characters)");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }
        if (status == null || status.trim().isEmpty()) {
            req.setAttribute("message", "Please select a valid status");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }
        try {
            Status.valueOf(status);
        } catch (IllegalArgumentException e) {
            req.setAttribute("message", "Invalid status value");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }

        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            // Find the event by ID
            Event event = entityManager.find(Event.class, eventId);
            if (event == null) {
                req.setAttribute("message", "Event not found");
                req.setAttribute("events", getAllEventsForAdmin());
                req.getRequestDispatcher("/dashboard").forward(req, resp);
                return;
            }

            // Update event details
            event.setName(name);
            event.setDate(LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE));
            event.setCapacity(Integer.parseInt(capacity));
            event.setDescription(description);
            event.setStatus(Status.valueOf(status));

            // Handle image upload if provided
            if (img != null && img.getSize() > 0 && Util.isValidImage(img)) {
                // Delete old attachment file if it exists
                if (event.getAttachment() != null) {
                    File oldFile = new File(event.getAttachment().getPath());
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                    entityManager.remove(event.getAttachment());
                }

                String imgId = UUID.randomUUID().toString();
                Attachment attachment = Attachment.builder()
                        .id(imgId)
                        .name(img.getSubmittedFileName())
                        .suffix(img.getContentType().split("/")[1])
                        .fileSize(img.getInputStream().available())
                        .path(Util.path2.concat(imgId).concat(".").concat(img.getContentType().split("/")[1]))
                        .build();

                try (FileOutputStream outputStream = new FileOutputStream(attachment.getPath())) {
                    outputStream.write(img.getInputStream().readAllBytes());
                }
                entityManager.persist(attachment);
                event.setAttachment(attachment);
            }

            entityManager.merge(event);
            transaction.commit();
            req.setAttribute("message", "Event updated successfully");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", "Error updating event: " + e.getMessage());
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
        } finally {
            entityManager.close();
        }
    }

    @SneakyThrows
    public void deleteEvent(HttpServletRequest req, HttpServletResponse resp) {
        User currentUser = Util.currentUser(req);
        if (currentUser == null) {
            req.setAttribute("message", "Please sign in first");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }

        String eventId = req.getParameter("id");

        if (eventId == null || eventId.trim().isEmpty()) {
            req.setAttribute("message", "Invalid event ID");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }

        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            Event event = entityManager.find(Event.class, eventId);
            if (event == null) {
                req.setAttribute("message", "Event not found");
                req.setAttribute("events", getAllEventsForAdmin());
                req.getRequestDispatcher("/dashboard").forward(req, resp);
                return;
            }

            // Delete attachment file if it exists
            if (event.getAttachment() != null) {
                File file = new File(event.getAttachment().getPath());
                if (file.exists()) {
                    file.delete();
                }
                entityManager.remove(event.getAttachment());
            }

            entityManager.remove(event);
            transaction.commit();

            req.setAttribute("message", "Event deleted successfully");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", "Error deleting event: " + e.getMessage());
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
        } finally {
            entityManager.close();
        }
    }

    @SneakyThrows
    public void changeStatusEvent(HttpServletRequest req, HttpServletResponse resp) {
        User currentUser = Util.currentUser(req);
        if (currentUser == null) {
            req.setAttribute("message", "Please sign in first");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }

        String eventId = req.getParameter("eventId");
        String status = req.getParameter("status");

        if (eventId == null || eventId.trim().isEmpty()) {
            req.setAttribute("message", "Please enter event ID");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }
        if (status == null || status.trim().isEmpty()) {
            req.setAttribute("message", "Please select event status");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
            return;
        }

        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Event event = entityManager.find(Event.class, eventId);
            if (event == null) {
                req.setAttribute("message", "Event not found");
                req.setAttribute("events", getAllEventsForAdmin());
                req.getRequestDispatcher("/dashboard").forward(req, resp);
                return;
            }
            Status eventStatus;
            try {
                eventStatus = Status.valueOf(status);
            } catch (IllegalArgumentException e) {
                req.setAttribute("message", "Please select a valid status");
                req.setAttribute("events", getAllEventsForAdmin());
                req.getRequestDispatcher("/dashboard").forward(req, resp);
                return;
            }
            event.setStatus(eventStatus);

            entityManager.merge(event);
            transaction.commit();

            req.setAttribute("message", "Event status updated successfully");
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", "Error updating event status: " + e.getMessage());
            req.setAttribute("events", getAllEventsForAdmin());
            req.getRequestDispatcher("/dashboard").forward(req, resp);
        } finally {
            entityManager.close();
        }
    }

    public List<EventDTO> getAllEventsForAdmin() {
        EntityManager entityManager = jpaConnection.entityManager();
        List<Event> events = entityManager.createQuery("select e from Event e", Event.class).getResultList();
        entityManager.close();

        return events.stream()
                .map(event -> EventDTO.builder()
                        .id(event.getId())
                        .name(event.getName())
                        .date(event.getDate())
                        .capacity(event.getCapacity())
                        .attachmentId(event.getAttachment() != null ? event.getAttachment().getId() : null)
                        .status(event.getStatus())
                        .description(event.getDescription())
                        .build()
                )
                .collect(Collectors.toList());
    }

    // Enhanced date validation to match JSP
    private boolean isValidDate(String date) {
        if (!Util.isValidDate(date)) return false;
        try {
            LocalDate parsedDate = LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
            return !parsedDate.isBefore(LocalDate.of(2025, 1, 1));
        } catch (DateTimeParseException e) {
            return false;
        }
    }
}