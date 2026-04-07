package com.example.project.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

    private static final String DB_HOST = ApplicationProperties.get("db.host", "localhost");
    private static final String DB_PORT = ApplicationProperties.get("db.port", "3306");
    private static final String DB_NAME = ApplicationProperties.get("db.name", "loginmvc_db");
    private static final String DB_USER = ApplicationProperties.get("db.user", "root");
    private static final String DB_PASSWORD = ApplicationProperties.get("db.password", "mabrouk123");
    private static final String DB_OPTIONS = ApplicationProperties.get(
            "db.options",
            "createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
    );
    private static final String JDBC_URL = buildJdbcUrl();

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver not found.", e);
        }

        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    private static String buildJdbcUrl() {
        StringBuilder builder = new StringBuilder()
                .append("jdbc:mysql://")
                .append(DB_HOST)
                .append(':')
                .append(DB_PORT)
                .append('/')
                .append(DB_NAME);

        if (!DB_OPTIONS.isBlank()) {
            builder.append('?').append(DB_OPTIONS);
        }

        return builder.toString();
    }
}
