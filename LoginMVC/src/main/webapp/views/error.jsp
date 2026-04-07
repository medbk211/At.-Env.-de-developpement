<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoginMVC | Login Failed</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/status-page.css">
</head>
<body>
    <main class="status-page error-theme">
        <section class="status-card">
            <p class="eyebrow">Acces refuse</p>
            <h1>Login failed</h1>
            <p>Verifier le username et le password puis reessaye.</p>
            <a href="<%= request.getContextPath() %>/views/login.jsp">Try again</a>
        </section>
    </main>
</body>
</html>
