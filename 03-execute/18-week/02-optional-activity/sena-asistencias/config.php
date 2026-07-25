<?php

// Cambia estos valores por los de tu servidor MySQL.
const DB_HOST = 'localhost';
const DB_NAME = 'sena_asistencia';
const DB_USER = 'sena_asistencia';
const DB_PASS = '6~*8{*n[N@7~0(l{';

// Configura las coordenadas reales de la sede y el radio máximo permitido (metros).
// 0 desactiva el cerco.
const SENA_LAT = 0.0;
const SENA_LNG = 0.0;
const RADIO_MAX_METROS = 300;

session_start();

function db(): PDO
{
    static $pdo;

    if (!$pdo) {

        $pdo = new PDO(
            'mysql:host=' . DB_HOST .
            ';dbname=' . DB_NAME .
            ';charset=utf8mb4',
            DB_USER,
            DB_PASS,
            [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
            ]
        );

        ensure_attendance_schema($pdo);
    }

    return $pdo;
}

function ensure_attendance_schema(PDO $pdo): void
{
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS sesiones_asistencia (
            id INT AUTO_INCREMENT PRIMARY KEY,
            token VARCHAR(64) NOT NULL UNIQUE,
            codigo VARCHAR(8) NOT NULL UNIQUE,
            ficha_id INT NULL,
            creada_por VARCHAR(100) NOT NULL,
            inicia_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            vence_en DATETIME NOT NULL,
            activa TINYINT(1) DEFAULT 1,
            INDEX(token),
            INDEX(codigo)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
    ");

    $column = $pdo->query("
        SHOW COLUMNS
        FROM asistencias
        LIKE 'sesion_id'
    ")->fetch();

    if (!$column) {

        $pdo->exec("
            ALTER TABLE asistencias
            ADD COLUMN sesion_id INT NULL
            AFTER aprendiz_id
        ");

        try {

            $pdo->exec("
                ALTER TABLE asistencias
                ADD UNIQUE KEY un_registro_sesion(aprendiz_id, sesion_id)
            ");

        } catch (PDOException $ignored) {
        }
    }

    foreach (
        [
            'latitud' => 'DECIMAL(10,7) NULL',
            'longitud' => 'DECIMAL(10,7) NULL',
            'precision_gps' => 'DECIMAL(8,2) NULL',
            'tarde_minutos' => 'INT NOT NULL DEFAULT 0',
            'verificado_gps' => 'TINYINT(1) NOT NULL DEFAULT 0',
            'consentimiento_datos' => 'TINYINT(1) NOT NULL DEFAULT 0'
        ] as $name => $type
    ) {

        if (
            !$pdo->query("
                SHOW COLUMNS
                FROM asistencias
                LIKE '$name'
            ")->fetch()
        ) {

            $pdo->exec("
                ALTER TABLE asistencias
                ADD COLUMN $name $type
            ");
        }
    }

    foreach (
        [
            'tolerancia_minutos' => 'INT NOT NULL DEFAULT 10'
        ] as $name => $type
    ) {

        if (
            !$pdo->query("
                SHOW COLUMNS
                FROM sesiones_asistencia
                LIKE '$name'
            ")->fetch()
        ) {

            $pdo->exec("
                ALTER TABLE sesiones_asistencia
                ADD COLUMN $name $type
            ");
        }
    }
}

function distancia_metros(
    float $lat1,
    float $lng1,
    float $lat2,
    float $lng2
): float {

    $r = 6371000;

    $dlat = deg2rad($lat2 - $lat1);
    $dlng = deg2rad($lng2 - $lng1);

    $a =
        sin($dlat / 2) ** 2 +
        cos(deg2rad($lat1)) *
        cos(deg2rad($lat2)) *
        sin($dlng / 2) ** 2;

    return $r * 2 * atan2(
        sqrt($a),
        sqrt(1 - $a)
    );
}

function logged(): bool
{
    return !empty($_SESSION['admin']);
}

function require_login(): void
{
    if (!logged()) {

        header('Location: index.php');
        exit;

    }
}

function e($v): string
{
    return htmlspecialchars(
        (string)$v,
        ENT_QUOTES,
        'UTF-8'
    );
}

function csrf(): string
{
    if (empty($_SESSION['csrf'])) {

        $_SESSION['csrf'] = bin2hex(
            random_bytes(32)
        );

    }

    return $_SESSION['csrf'];
}

function check_csrf(): void
{
    if (
        !hash_equals(
            $_SESSION['csrf'] ?? '',
            $_POST['csrf'] ?? ''
        )
    ) {

        http_response_code(419);
        exit('Solicitud no válida.');

    }
}

function ip(): string
{
    return $_SERVER['REMOTE_ADDR'] ?? 'desconocida';
}

?>