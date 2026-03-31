package com.example.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

import com.example.model.User;
import com.example.service.UserService;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(username, password);

        UserService service = new UserService();

        if(service.checkLogin(user)){
            request.setAttribute("username", username);
            request.getRequestDispatcher("home.jsp")
                   .forward(request, response);
        } else {
            request.getRequestDispatcher("error.jsp")
                   .forward(request, response);
        }
    }
}
