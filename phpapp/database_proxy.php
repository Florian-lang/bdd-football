<?php
if (!isset($_SESSION['username'])) {
    header("Location: index.php");
    exit();
}

function connectTodDb($host, $dbname, $user, $password) {
    $dsn = "pgsql:host=$host;port=5432;dbname=$dbname";
    try {
        $conn = new PDO($dsn, $user, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
        die("La connexion a échoué : " . $e->getMessage());
    }
    return $conn;
}

function executeQuery($query) {
    $user = "postgres";
    $host = $_SESSION['host'];
    $password = $_SESSION['password'];
    $dbname = 'postgres';

    $conn = connectTodDb($host, $dbname, $user, $password);

    try {
        $stmt = $conn->query($query);
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        return [];
    }

    $conn = null;
    return $data;
}
?>