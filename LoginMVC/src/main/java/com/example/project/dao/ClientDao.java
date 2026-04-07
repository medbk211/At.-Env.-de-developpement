package com.example.project.dao;

import com.example.project.model.Client;
import com.example.project.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClientDao {

    public List<Client> findAll() {
        String sql = "SELECT id, first_name, last_name, email, phone FROM clients ORDER BY id DESC";
        List<Client> clients = new ArrayList<>();

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                clients.add(mapClient(resultSet));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error while loading clients.", e);
        }

        return clients;
    }

    public Client findById(int id) {
        String sql = "SELECT id, first_name, last_name, email, phone FROM clients WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapClient(resultSet);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error while loading a client.", e);
        }

        return null;
    }

    public void save(Client client) {
        if (client.getId() > 0) {
            update(client);
            return;
        }

        insert(client);
    }

    private void insert(Client client) {
        String sql = "INSERT INTO clients (first_name, last_name, email, phone) VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, client.getFirstName());
            statement.setString(2, client.getLastName());
            statement.setString(3, client.getEmail());
            statement.setString(4, client.getPhone());
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Database error while adding a client.", e);
        }
    }

    private void update(Client client) {
        String sql = "UPDATE clients SET first_name = ?, last_name = ?, email = ?, phone = ? WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, client.getFirstName());
            statement.setString(2, client.getLastName());
            statement.setString(3, client.getEmail());
            statement.setString(4, client.getPhone());
            statement.setInt(5, client.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Database error while updating a client.", e);
        }
    }

    private Client mapClient(ResultSet resultSet) throws SQLException {
        return new Client(
                resultSet.getInt("id"),
                resultSet.getString("first_name"),
                resultSet.getString("last_name"),
                resultSet.getString("email"),
                resultSet.getString("phone")
        );
    }
}
