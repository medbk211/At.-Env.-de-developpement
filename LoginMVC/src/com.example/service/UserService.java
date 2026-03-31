package com.example.service;

import com.example.model.User;
import com.example.util.DatabaseInitializer;
import com.example.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserService {

    public boolean checkLogin(User user) {
        DatabaseInitializer.initializeSchema();
        String sql = "SELECT id FROM users WHERE username = ? AND password = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, user.getUsername());
            statement.setString(2, user.getPassword());

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error while checking login.", e);
        }
    }
}
