<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoginMVC | Sign in</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/login.css">
</head>
<body>
    <main class="auth-page">
        <section class="auth-card">
            <p class="eyebrow">LoginMVC</p>
            <h1>Espace de connexion</h1>
            <p class="subtitle">Connecte-toi pour acceder a l'espace utilisateur ou au dashboard admin.</p>

            <form action="<%= request.getContextPath() %>/login" method="post" class="auth-form">
                <label for="username">Username</label>
                <input id="username" type="text" name="username" placeholder="admin" required>

                <label for="password">Password</label>
                <input id="password" type="password" name="password" placeholder="1234" required>

                <button type="submit">Login</button>
            </form>

            <p class="hint">Compte demo admin: <strong>admin / 1234</strong></p>
        </section>
    </main>
</body>
</html>
