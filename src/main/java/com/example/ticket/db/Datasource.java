package com.example.ticket.db;

import lombok.SneakyThrows;

import java.sql.Connection;
import java.sql.DriverManager;

public class Datasource {
    private static Connection connection;

    @SneakyThrows
    public static Connection connection() {
        if (connection == null || connection.isClosed()) {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/app",
                    "postgres",
                    "Root1234"
            );
        }
        return connection;
    }
}
