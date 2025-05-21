package com.example.ticket.contoller;

import com.example.ticket.entity.Attachment;
import com.example.ticket.repository.AttachmentRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

@WebServlet("/download")
public class DownloadController extends HttpServlet {
    private final AttachmentRepository attachmentRepository = new AttachmentRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/octet-stream");

        Optional<Attachment> photoById = attachmentRepository.getPhotoById(UUID.fromString(req.getParameter("fileId")));

        if (photoById.isPresent()) {
            Attachment attachment = photoById.get();
            resp.setHeader("Content-disposition", "inline; filename=\"" + attachment.getName() + "\"");

            File file = new File(attachment.getPath());
            if (file.exists()) {
                FileInputStream fileInputStream = new FileInputStream(file);
                byte[] content = new byte[fileInputStream.available()];
                fileInputStream.read(content);
                ServletOutputStream outputStream = resp.getOutputStream();
                outputStream.write(content);
                fileInputStream.close();
            }

        } else {
            resp.sendRedirect("/admin");
        }
    }
}
