<?php
session_start();
if (!isset($_SESSION['username'])) {
    header("Location: index.php");
    exit();
}

include_once 'database_proxy.php';

$query = "SELECT * FROM club_sportif";
if($_SESSION['region'] !== 'centre') {
    $query = "SELECT * FROM club_sportif_{$_SESSION['region']}";
}

$query = "SELECT * FROM club_sportif";
$clubs = executeQuery($query);
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Clubs</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <?php include_once 'header.php'; ?>
    <div class="content">
        <h1>Gestion des Clubs</h1>
        <table>
            <thead>
                <tr>
                    <th>Code Club</th>
                    <th>Dirigeant</th>
                    <th>Nom</th>
                    <th>Région</th>
                    <th>Date de création</th>
                    <th>Ville</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php
                    if (empty($clubs)) {
                        echo "<tr><td colspan='7'>Aucun club trouvé.</td></tr>";
                    }
                
                    foreach ($clubs as $club): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($club['code_club']); ?></td>
                            <td><?php echo htmlspecialchars($club['dirigeant']); ?></td>
                            <td><?php echo htmlspecialchars($club['nom_club']); ?></td>
                            <td><?php echo htmlspecialchars($club['region']); ?></td>
                            <td><?php echo htmlspecialchars($club['date_creation']); ?></td>
                            <td><?php echo htmlspecialchars($club['ville']); ?></td>
                            <td><button>Modifier</button> <button>Supprimer</button></td>
                        </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <form action="ajouter_club.php" method="POST">
            <input type="text" name="nom_club" placeholder="Nom du Club" required>
            <input type="text" name="ville_club" placeholder="Ville" required>
            <button type="submit">Ajouter un Club</button>
        </form>
    </div>
</body>
</html>