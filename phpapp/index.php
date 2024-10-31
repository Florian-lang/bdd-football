<?php
session_start();
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Application Football</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <?php include_once 'header.php'; ?>
    <div class="content">
        <h1>Bienvenue dans l'application de gestion de football</h1>
        <?php if (!isset($_SESSION['username'])): ?>
            <p>Connectez-vous pour accéder aux fonctionnalités.</p>
            <a href="login.php" class="button">Connexion</a>
        <?php else: ?>
            <p>Bonjour, <?php echo htmlspecialchars($_SESSION['username']); ?>! Utilisez le menu pour naviguer entre les sections.
                Vous êtes connecté au site <?= $_SESSION['host'] ?>
            </p>
        <?php endif; ?>
    </div>
</body>
</html>