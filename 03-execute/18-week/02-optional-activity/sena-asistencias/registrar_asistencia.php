<?php

require_once __DIR__ . '/config.php';

header('Content-Type: application/json; charset=utf-8');

if (!logged()) {

    http_response_code(401);

    echo json_encode([
        'ok' => false,
        'error' => 'Sesión expirada.'
    ]);

    exit;
}

$data = json_decode(
    file_get_contents('php://input'),
    true
) ?: [];

$token = trim($data['token'] ?? '');

if (!$token) {

    echo json_encode([
        'ok' => false,
        'error' => 'Código QR vacío.'
    ]);

    exit;
}

$pdo = db();

$q = $pdo->prepare("
    SELECT *
    FROM aprendices
    WHERE qr_token = ?
    AND activo = 1
");

$q->execute([$token]);

$p = $q->fetch();

if (!$p) {

    echo json_encode([
        'ok' => false,
        'error' => 'QR no reconocido o aprendiz inactivo.'
    ]);

    exit;
}

/*
|--------------------------------------------------------------------------
| La decisión se toma en el servidor.
| Bloquea IP privadas y proxies explícitos.
| Para VPN comerciales se recomienda integrar una API de reputación IP
| en un entorno de producción.
|--------------------------------------------------------------------------
*/

$clientIp = ip();

$headers = [
    'HTTP_VIA',
    'HTTP_X_FORWARDED_FOR',
    'HTTP_X_REAL_IP',
    'HTTP_FORWARDED'
];

$proxy = [];

foreach ($headers as $h) {

    if (!empty($_SERVER[$h])) {
        $proxy[] = $h;
    }
}

$local = in_array(
    $clientIp,
    ['127.0.0.1', '::1'],
    true
);

$private =
    !$local &&
    !filter_var(
        $clientIp,
        FILTER_VALIDATE_IP,
        FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE
    );

$status = $private
    ? 'bloqueada'
    : ($proxy ? 'sospechosa' : 'permitida');

$detail = $local
    ? 'Entorno local de pruebas'
    : (
        $private
            ? 'IP privada/no verificable'
            : (
                $proxy
                    ? 'Posible proxy: ' . implode(', ', $proxy)
                    : 'Sin indicadores de proxy'
            )
    );

if ($status === 'bloqueada') {

    echo json_encode([
        'ok' => false,
        'error' => 'Registro bloqueado: la IP de origen es privada o no verificable.',
        'status' => $status
    ]);

    exit;
}

$s = $pdo->prepare("
    INSERT INTO asistencias
    (
        aprendiz_id,
        ip,
        user_agent,
        estado_red,
        detalle_red
    )
    VALUES (?, ?, ?, ?, ?)
");

$s->execute([
    $p['id'],
    $clientIp,
    substr($_SERVER['HTTP_USER_AGENT'] ?? '', 0, 255),
    $status,
    $detail
]);

echo json_encode([
    'ok' => true,
    'nombre' => $p['nombre'],
    'message' => $status === 'sospechosa'
        ? 'Asistencia registrada con alerta de red.'
        : 'Asistencia registrada correctamente.',
    'status' => $status
]);