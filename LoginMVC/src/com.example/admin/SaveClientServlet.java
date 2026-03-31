package com.example.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class SaveClientServlet extends HttpServlet {

    private final ClientService clientService = new ClientService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("username"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int id = parseId(request.getParameter("id"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (isBlank(firstName) || isBlank(lastName) || isBlank(email)) {
            response.sendRedirect(request.getContextPath()
                    + "/admin/dashboard?message="
                    + URLEncoder.encode("Merci de remplir les champs obligatoires.", StandardCharsets.UTF_8));
            return;
        }

        Client client = new Client(
                id,
                firstName.trim(),
                lastName.trim(),
                email.trim(),
                phone == null ? "" : phone.trim()
        );

        try {
            clientService.saveClient(client);
        } catch (RuntimeException e) {
            response.sendRedirect(request.getContextPath()
                    + "/admin/dashboard?message="
                    + URLEncoder.encode("Operation impossible. Verifie les donnees du client.", StandardCharsets.UTF_8));
            return;
        }

        String successMessage = id > 0 ? "Client modifie avec succes." : "Client ajoute avec succes.";
        response.sendRedirect(request.getContextPath()
                + "/admin/dashboard?message="
                + URLEncoder.encode(successMessage, StandardCharsets.UTF_8));
    }

    private int parseId(String idValue) {
        if (idValue == null || idValue.isBlank()) {
            return 0;
        }

        try {
            return Integer.parseInt(idValue);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.isBlank();
    }
}
