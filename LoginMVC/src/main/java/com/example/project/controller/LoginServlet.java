package com.example.project.controller;

import com.example.project.model.User;
import com.example.project.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(username, password);

        if (userService.checkLogin(user)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            if ("admin".equals(username)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            }

            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/home.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("/views/error.jsp").forward(request, response);
    }
}
