<?php
session_start();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $regions = ['est', 'ouest', 'sud', 'nord', 'centre'];
    $isAuthenticated = false;

    foreach ($regions as $region) {
        $host = $region;
        $dbname = 'postgres';
        $user = $username;
        $pass = $password;

        $dsn = "pgsql:host=$host;dbname=$dbname";
        try {
            $conn = new PDO($dsn, $user, $pass);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $isAuthenticated = true;
            $_SESSION['username'] = $username;
            $_SESSION['region'] = $region;
            $_SESSION['host'] = $host;
            $_SESSION['password'] = $pass;
            break;
        } catch (PDOException $e) {
            // Continue to the next region
        }
    }

    if ($isAuthenticated) {
        header("Location: index.php");
        exit();
    } else {
        $error = "Connexion échouée. Veuillez vérifier vos informations d'identification.";
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="login-form">
        <h2>Connexion</h2>
        <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>
        <form action="login.php" method="POST">
            <input type="text" name="username" placeholder="Nom d'utilisateur" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <button type="submit">Se connecter</button>
        </form>
    </div>
</body>
</html>