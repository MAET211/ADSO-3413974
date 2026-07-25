<?php

require_once __DIR__ . '/config.php';

require_login();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {

    header('Location: tomar_asistencia.php');
    exit;

}

check_csrf();

$pdo = db();

$q = $pdo->prepare("
    SELECT *
    FROM sesiones_asistencia
    WHERE token = ?
    AND activa = 1
    AND vence_en > NOW()
");

$q->execute([
    $_POST['t'] ?? ''
]);

$s = $q->fetch();

if (!$s) {
    exit('Sesiиоn cerrada o vencida.');
}

$q = $pdo->prepare("
    SELECT *
    FROM aprendices
    WHERE documento = ?
    AND activo = 1
");

$q->execute([
    trim($_POST['documento'] ?? '')
]);

$p = $q->fetch();

if (
    !$p ||
    (
        $s['ficha_id'] &&
        $p['ficha_id'] != $s['ficha_id']
    )
) {

    header(
        'Location: sesion.php?t=' .
        $s['token'] .
        '&error=aprendiz'
    );

    exit;

}

try {

    $i = $pdo->prepare("
        INSERT INTO asistencias
        (
            aprendiz_id,
            sesion_id,
            ip,
            user_agent,
            estado_red,
            detalle_red
        )
        VALUES
        (
            ?,
            ?,
            ?,
            ?,
            'permitida',
            'Registro manual por instructor'
        )
    ");

    $i->execute([
        $p['id'],
        $s['id'],
        ip(),
        substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 255)
    ]);

} catch (PDOException $e) {
    // Se ignora si el registro ya existe.
}

header('Location: sesion.php?t=' . $s['token']);

?>