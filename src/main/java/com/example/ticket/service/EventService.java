package com.example.ticket.service;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.*;
import com.example.ticket.entity.enums.Status;
import com.example.ticket.payload.EventDTO;
import com.example.ticket.payload.PlacesDTO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lombok.SneakyThrows;

import java.io.FileOutputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import static com.example.ticket.utils.Util.*;

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

        if (isValidDate(date) && isValidEventName(eventName) && isValidCapacity(capacity)
                && isValidDescription(description) && isValidImage(img)) {

            entityManager.getTransaction().begin();

            String imgId = UUID.randomUUID().toString();
            Attachment attachment = Attachment.builder()
                    .id(imgId)
                    .name(img.getSubmittedFileName())
                    .suffix(img.getContentType().split("/")[1])
                    .fileSize(img.getInputStream().available())
                    .path(path.concat(imgId).concat(".").concat(img.getContentType().split("/")[1]))
                    .build();

            try (FileOutputStream outputStream = new FileOutputStream(path.concat(imgId).concat(".").concat(img.getContentType().split("/")[1]))) {
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
//        if (currentUser == null) {
//            req.setAttribute("message", "please sign in first");
//            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
//            return;
//        }
        String id = req.getParameter("id");
        String eventName = req.getParameter("eventName");
        String date = req.getParameter("date");
        String capacity = req.getParameter("capacity");
        String attachmentId = req.getParameter("attachmentId");
        String status = req.getParameter("status");
        String description = req.getParameter("description");

        System.err.println("eventName: " + eventName + ", date: " + date + ", capacity: " + capacity + ", attachmentId: " + attachmentId + ", status: " + status);

        if (eventName == null || eventName.isEmpty()) {
            req.setAttribute("message", "Please enter event name");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }
        if (date == null || date.isEmpty()) {
            req.setAttribute("message", "Please enter event date");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }
        if (capacity == null || capacity.isEmpty()) {
            req.setAttribute("message", "Please enter event capacity");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }
        if (status == null || status.isEmpty()) {
            req.setAttribute("message", "Please select event status");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
            return;
        }

        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();
            Event event = entityManager.find(Event.class, id);
            if (event == null) {
                req.setAttribute("message", "Please enter event name");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                return;
            }
            LocalDate evenDate;
            try {
                evenDate = LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
            } catch (DateTimeParseException e) {
                req.setAttribute("message", "Please enter event date");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                return;
            }
            int eventCapacity;
            try {
                eventCapacity = Integer.parseInt(capacity);
                if (eventCapacity <= 0) {
                    req.setAttribute("message", "Please enter event capacity");
                    req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                req.setAttribute("message", "Please enter event capacity");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                return;
            }
            Status eventStatus;
            try {
                eventStatus = Status.valueOf(status);
            } catch (IllegalArgumentException e) {
                req.setAttribute("message", "Please select event status");
                req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
                return;
            }

            event.setName(eventName);
            event.setDate(evenDate);
            event.setCapacity(eventCapacity);
//            event.setAttachmentId(attachmentId);
            event.setStatus(eventStatus);
            event.setDescription(description);

            entityManager.merge(event);
            transaction.commit();
            resp.sendRedirect("/admin");
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", "Something went wrong");
            req.getRequestDispatcher("/dashboard/pages/addEvent.jsp").forward(req, resp);
        } finally {
            entityManager.close();
        }

    }

    @SneakyThrows
    public void changeStatusEvent(HttpServletRequest req, HttpServletResponse resp) {
        String eventId = req.getParameter("eventId");
        String status = req.getParameter("status");

        if (eventId == null || eventId.isEmpty()) {
            req.setAttribute("message", "Please enter event ID");
            req.getRequestDispatcher("/dashboard/admin.jsp").forward(req, resp);
            return;
        }
        if (status == null || status.isEmpty()) {
            req.setAttribute("message", "Please select event status");
            req.getRequestDispatcher("/dashboard/admin.jsp").forward(req, resp);
            return;
        }

        EntityManager entityManager = jpaConnection.entityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Event event = entityManager.find(Event.class, eventId);

            Status eventStatus;
            try {
                eventStatus = Status.valueOf(status);
            } catch (IllegalArgumentException e) {
                req.setAttribute("message", "Please select event status");
                req.getRequestDispatcher("/dashboard/admin.jsp").forward(req, resp);
                return;
            }
            event.setStatus(eventStatus);

            if (eventStatus.equals(Status.CANCELLED)) {
                List<Ticket> tickets = entityManager
                        .createQuery("SELECT t FROM Ticket t WHERE t.event.id = :eventId", Ticket.class)
                        .setParameter("eventId", eventId)
                        .getResultList();

                for (Ticket ticket : tickets) {
                    User user = ticket.getUser();

                    Card card = user.getCards().isEmpty() ? null : user.getCards().get(0);

                    if (card != null) {
                        card.setBalance(card.getBalance() + event.getPrice());
                        entityManager.merge(card);
                    }

                    ticket.setStatus(Status.CANCELLED);

                    entityManager.persist(History.builder()
                            .id(UUID.randomUUID().toString())
                            .ticket(ticket)
                            .user(user)
                            .event(event)
                            .by("Event cancelled")
                            .date(LocalDateTime.now())
                            .count(0)
                            .build());

                    entityManager.merge(ticket);
                }

            } else if (eventStatus.equals(Status.INACTIVE)) {
                List<Ticket> tickets = entityManager
                        .createQuery("SELECT t FROM Ticket t WHERE t.event.id = :eventId", Ticket.class)
                        .setParameter("eventId", eventId)
                        .getResultList();

                for (Ticket ticket : tickets) {
                    User user = ticket.getUser();

                    ticket.setStatus(Status.INACTIVE);

                    entityManager.persist(History.builder()
                            .id(UUID.randomUUID().toString())
                            .ticket(ticket)
                            .user(user)
                            .event(event)
                            .by("Ticket time over")
                            .date(LocalDateTime.now())
                            .count(0)
                            .build());

                    entityManager.merge(ticket);
                }
            }

            transaction.commit();

            resp.sendRedirect("/admin");
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            req.setAttribute("message", "Something went wrong");
            req.getRequestDispatcher("/dashboard/admin.jsp").forward(req, resp);
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
                        .attachmentId(event.getAttachment().getId())
                        .price(event.getPrice())
                        .status(event.getStatus())
                        .description(event.getDescription())
                        .build()
                )
                .collect(Collectors.toList());
    }

    public List<PlacesDTO> placesDTOS(String eventId) {
        EntityManager entityManager = jpaConnection.entityManager();
        Event event = entityManager.find(Event.class, eventId);

        List<Ticket> tickets = entityManager.createQuery(
                        "select t from Ticket t where t.event.id = :eventId and t.status='ACTIVE'", Ticket.class)
                .setParameter("eventId", eventId)
                .getResultList();

        if (tickets.isEmpty()) {
            List<PlacesDTO> result = new ArrayList<>();
            result.add(PlacesDTO.builder()
                    .price(event.getPrice())
                    .capacity(event.getCapacity())
                    .build());
            return result;
        }

        List<PlacesDTO> collect = tickets.stream()
                .map(ticket -> PlacesDTO.builder()
                        .eventId(ticket.getEvent().getId())
                        .placeNumber(ticket.getPlaceNumber())
                        .price(ticket.getEvent().getPrice())
                        .capacity(event.getCapacity())
                        .build())
                .collect(Collectors.toList());

        entityManager.close();

        collect.forEach(System.out::println);

        return collect;
    }

}
