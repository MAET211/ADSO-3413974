<?php

require_once __DIR__ . '/config.php';

function head(string $title, bool $auth = true): void
{
?>

<!doctype html>

<html lang="es">

<head>

    <meta charset="utf-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1"
    >

    <title>
        <?= e($title) ?> ， SENA
    </title>

    <link
        rel="stylesheet"
        href="assets/app.css"
    >

</head>

<body>

<?php if ($auth): ?>

    <header class="top">

        <a href="dashboard.php">

            <img
                src="assets/sena-logo.svg"
                alt="SENA"
            >

        </a>

        <nav>

            <a href="dashboard.php">
                Inicio
            </a>

            <a href="aprendices.php">
                Aprendices
            </a>

            <a href="asistencias.php">
                Historial
            </a>

            <a
                href="tomar_asistencia.php"
                class="btn"
            >
                Tomar asistencia
            </a>

            <a href="logout.php">
                Salir
            </a>

        </nav>

    </header>

<?php endif; ?>

<main class="<?= $auth ? 'shell' : 'login' ?>">

<?php
}

function foot(): void
{
?>

</main>

<footer class="footer">

    SENA ， Servicio Nacional de Aprendizaje ，
    Sistema de control de asistencia ，

    <a href="politica_datos.php">
        Tratamiento de datos personales
    </a>

</footer>

</body>

</html>

<?php
}
?>