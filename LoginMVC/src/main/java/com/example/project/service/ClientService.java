package com.example.project.service;

import com.example.project.dao.ClientDao;
import com.example.project.model.Client;
import com.example.project.util.DatabaseInitializer;

import java.util.List;

public class ClientService {

    private final ClientDao clientDao;

    public ClientService() {
        this(new ClientDao());
    }

    public ClientService(ClientDao clientDao) {
        this.clientDao = clientDao;
    }

    public List<Client> getAllClients() {
        DatabaseInitializer.initializeSchema();
        return clientDao.findAll();
    }

    public Client getClientById(int id) {
        DatabaseInitializer.initializeSchema();
        return clientDao.findById(id);
    }

    public void saveClient(Client client) {
        DatabaseInitializer.initializeSchema();
        clientDao.save(client);
    }
}
