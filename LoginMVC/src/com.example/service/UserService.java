package com.example.service;

import com.example.model.User;

public class UserService {

    public boolean checkLogin(User user){

        
        if(user.getUsername().equals("admin") &&
           user.getPassword().equals("1234")){
            return true;
        }

        return false;
    }
}
