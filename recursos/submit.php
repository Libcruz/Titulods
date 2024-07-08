<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = htmlspecialchars($_POST['nombre']);
    $cuenta = htmlspecialchars($_POST['cuenta']);
    echo "<h1>Información del Alumno</h1>";
    echo "<p>Nombre Completo: $nombre</p>";
    echo "<p>Número de Cuenta: $cuenta</p>";
}
?>
