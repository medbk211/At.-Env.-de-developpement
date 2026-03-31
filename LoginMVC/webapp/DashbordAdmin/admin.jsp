<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.admin.Client" %>
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
    <title>Dashboard Admin</title>
    <style>
        :root {
            --bg: #f4efe6;
            --card: #fffaf2;
            --ink: #1f2937;
            --muted: #6b7280;
            --line: #e6dccd;
            --accent: #0f766e;
            --accent-dark: #115e59;
            --soft: #d1fae5;
            --warn: #9a3412;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, sans-serif;
            color: var(--ink);
            background:
                radial-gradient(circle at top left, #fff8eb 0, #fff8eb 18%, transparent 18%),
                linear-gradient(135deg, #f3eadb, #e6f4f1);
            min-height: 100vh;
        }

        .page {
            width: min(1100px, calc(100% - 32px));
            margin: 32px auto;
        }

        .hero {
            background: linear-gradient(135deg, #134e4a, #0f766e);
            color: #fff;
            border-radius: 24px;
            padding: 28px;
            box-shadow: 0 22px 50px rgba(15, 118, 110, 0.22);
        }

        .hero h1 {
            margin: 0 0 8px;
            font-size: 32px;
        }

        .hero p {
            margin: 0;
            color: rgba(255, 255, 255, 0.88);
        }

        .layout {
            display: grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap: 24px;
            margin-top: 24px;
        }

        .card {
            background: var(--card);
            border: 1px solid rgba(230, 220, 205, 0.9);
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 18px 35px rgba(31, 41, 55, 0.08);
        }

        .section-title {
            margin: 0 0 18px;
            font-size: 22px;
        }

        .message {
            margin-top: 18px;
            background: var(--soft);
            color: var(--accent-dark);
            border-radius: 14px;
            padding: 12px 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            text-align: left;
            padding: 14px 10px;
            border-bottom: 1px solid var(--line);
            vertical-align: top;
        }

        th {
            color: var(--muted);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.08em;
        }

        .action-link {
            display: inline-block;
            padding: 8px 12px;
            border-radius: 999px;
            text-decoration: none;
            background: rgba(15, 118, 110, 0.1);
            color: var(--accent-dark);
            font-weight: 600;
        }

        .empty {
            padding: 18px;
            border: 1px dashed var(--line);
            border-radius: 16px;
            color: var(--muted);
            background: #fff;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        .field {
            margin-bottom: 16px;
        }

        input {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #d8ccba;
            border-radius: 12px;
            font-size: 15px;
            background: #fff;
        }

        input:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 4px rgba(15, 118, 110, 0.12);
        }

        .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 8px;
        }

        button, .secondary-link {
            border: none;
            border-radius: 999px;
            padding: 12px 18px;
            font-size: 15px;
            text-decoration: none;
            cursor: pointer;
        }

        button {
            background: var(--accent);
            color: #fff;
            font-weight: 700;
        }

        button:hover {
            background: var(--accent-dark);
        }

        .secondary-link {
            background: #efe7d8;
            color: var(--warn);
            font-weight: 600;
        }

        .top-link {
            display: inline-block;
            margin-top: 18px;
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }

        @media (max-width: 900px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .hero h1 {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>
    <div class="page">
        <div class="hero">
            <h1>Dashboard Admin</h1>
            <p>Gestion des clients: affichage depuis la base, ajout et modification dans la meme page.</p>
            <a class="top-link" href="<%= request.getContextPath() %>/login.jsp">Retour vers login</a>
        </div>

        <% if (flashMessage != null && !flashMessage.isBlank()) { %>
            <div class="message"><%= flashMessage %></div>
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
