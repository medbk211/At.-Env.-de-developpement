<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.project.model.Client" %>
<%
    List<Client> clients = (List<Client>) request.getAttribute("clients");
    Client clientToEdit = (Client) request.getAttribute("clientToEdit");
    if (clientToEdit == null) {
        clientToEdit = new Client();
    }

    boolean editing = clientToEdit.getId() > 0;
    String flashMessage = request.getParameter("message");
    if (flashMessage == null) {
        Object messageAttr = request.getAttribute("message");
        flashMessage = messageAttr == null ? null : messageAttr.toString();
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoginMVC | Dashboard Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/admin-dashboard.css">
    <script defer src="<%= request.getContextPath() %>/js/admin-dashboard.js"></script>
</head>
<body>
    <div class="page">
        <div class="hero">
            <h1>Dashboard Admin</h1>
            <p>Gestion des clients avec affichage, ajout et modification dans une seule interface.</p>
            <a class="top-link" href="<%= request.getContextPath() %>/views/login.jsp">Retour vers login</a>
        </div>

        <% if (flashMessage != null && !flashMessage.isBlank()) { %>
            <div class="message" data-flash-message><%= flashMessage %></div>
        <% } %>

        <div class="layout">
            <div class="card">
                <h2 class="section-title">Liste des clients</h2>

                <% if (clients == null || clients.isEmpty()) { %>
                    <div class="empty">Aucun client trouve dans la base de donnees.</div>
                <% } else { %>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nom</th>
                                <th>Email</th>
                                <th>Telephone</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for (Client client : clients) { %>
                            <tr>
                                <td><%= client.getId() %></td>
                                <td><%= client.getFirstName() %> <%= client.getLastName() %></td>
                                <td><%= client.getEmail() %></td>
                                <td><%= client.getPhone() == null ? "" : client.getPhone() %></td>
                                <td>
                                    <a class="action-link"
                                       href="<%= request.getContextPath() %>/admin/dashboard?editId=<%= client.getId() %>">
                                        Edit
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>

            <div class="card">
                <h2 class="section-title"><%= editing ? "Modifier client" : "Ajouter client" %></h2>

                <form action="<%= request.getContextPath() %>/admin/client/save" method="post">
                    <input type="hidden" name="id" value="<%= clientToEdit.getId() %>">

                    <div class="field">
                        <label for="firstName">Prenom</label>
                        <input id="firstName" type="text" name="firstName"
                               value="<%= clientToEdit.getFirstName() == null ? "" : clientToEdit.getFirstName() %>"
                               required>
                    </div>

                    <div class="field">
                        <label for="lastName">Nom</label>
                        <input id="lastName" type="text" name="lastName"
                               value="<%= clientToEdit.getLastName() == null ? "" : clientToEdit.getLastName() %>"
                               required>
                    </div>

                    <div class="field">
                        <label for="email">Email</label>
                        <input id="email" type="email" name="email"
                               value="<%= clientToEdit.getEmail() == null ? "" : clientToEdit.getEmail() %>"
                               required>
                    </div>

                    <div class="field">
                        <label for="phone">Telephone</label>
                        <input id="phone" type="text" name="phone"
                               value="<%= clientToEdit.getPhone() == null ? "" : clientToEdit.getPhone() %>">
                    </div>

                    <div class="actions">
                        <button type="submit"><%= editing ? "Update client" : "Add client" %></button>
                        <% if (editing) { %>
                            <a class="secondary-link" href="<%= request.getContextPath() %>/admin/dashboard">Annuler</a>
                        <% } %>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
