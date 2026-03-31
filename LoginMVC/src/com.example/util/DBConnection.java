package com.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_HOST = getEnv("DB_HOST", "localhost");
    private static final String DB_PORT = getEnv("DB_PORT", "3306");
    private static final String DB_NAME = getEnv("DB_NAME", "loginmvc_db");
    private static final String USER = getEnv("DB_USER", "root");
    private static final String PASSWORD = getEnv("DB_PASSWORD", "mabrouk123");
    private static final String URL =
            "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME;

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    private static String getEnv(String key, String defaultValue) {
        String value = System.getenv(key);
        return value == null || value.isBlank() ? defaultValue : value;
    }
}
