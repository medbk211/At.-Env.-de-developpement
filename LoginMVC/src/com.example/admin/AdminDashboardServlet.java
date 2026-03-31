package com.example.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {

    private final ClientService clientService = new ClientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("username"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.setAttribute("clients", clientService.getAllClients());

        String editId = request.getParameter("editId");
        Client clientToEdit = new Client();

        if (editId != null && !editId.isBlank()) {
            try {
                Client loadedClient = clientService.getClientById(Integer.parseInt(editId));
                if (loadedClient != null) {
                    clientToEdit = loadedClient;
                }
            } catch (NumberFormatException ignored) {
                request.setAttribute("message", "Client invalide.");
            }
        }

        request.setAttribute("clientToEdit", clientToEdit);
        request.getRequestDispatcher("/DashbordAdmin/admin.jsp").forward(request, response);
    }
}
