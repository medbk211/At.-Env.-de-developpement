<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoginMVC | Home</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/status-page.css">
</head>
<body>
    <main class="status-page">
        <section class="status-card">
            <p class="eyebrow">Session ouverte</p>
            <h1>Welcome ${username}</h1>
            <p>La connexion s'est faite avec succes.</p>
            <a href="<%= request.getContextPath() %>/views/login.jsp">Retour au login</a>
        </section>
    </main>
</body>
</html>
