package com.example.project.service;

import com.example.project.dao.UserDao;
import com.example.project.model.User;
import com.example.project.util.DatabaseInitializer;

public class UserService {

    private final UserDao userDao;

    public UserService() {
        this(new UserDao());
    }

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public boolean checkLogin(User user) {
        DatabaseInitializer.initializeSchema();
        return userDao.existsByCredentials(user);
    }
}
