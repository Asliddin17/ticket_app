package com.example.ticket.contoller;

import com.example.ticket.db.JpaConnection;
import com.example.ticket.entity.Attachment;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@WebServlet("/download")
public class DownloadController extends HttpServlet {
    private final JpaConnection jpaConnection = JpaConnection.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager entityManager = jpaConnection.entityManager();
        resp.setContentType("application/octet-stream");

        Attachment attachment = entityManager.find(Attachment.class, req.getParameter("fileId"));
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
    }
}
