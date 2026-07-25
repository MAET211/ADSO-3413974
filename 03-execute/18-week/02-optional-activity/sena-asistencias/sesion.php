<?php

require_once __DIR__ . '/layout.php';

require_login();

$pdo = db();

$q = $pdo->prepare("
    SELECT
        s.*,
        f.numero,
        f.programa
    FROM sesiones_asistencia s
    LEFT JOIN fichas f
        ON f.id = s.ficha_id
    WHERE s.token = ?
");

$q->execute([
    $_GET['t'] ?? ''
]);

$s = $q->fetch();

if (!$s) {
    exit('Sesión no encontrada');
}

$rows = $pdo->prepare("
    SELECT
        a.fecha_hora,
        a.tarde_minutos,
        a.latitud,
        a.longitud,
        p.nombre,
        p.documento
    FROM asistencias a
    JOIN aprendices p
        ON p.id = a.aprendiz_id
    WHERE a.sesion_id = ?
    ORDER BY a.fecha_hora DESC
");

$rows->execute([
    $s['id']
]);

$base =
    (isset($_SERVER['HTTPS']) ? 'https' : 'http') .
    '://' .
    $_SERVER['HTTP_HOST'] .
    rtrim(dirname($_SERVER['PHP_SELF']), '/\\') .
    '/';

head('Sesión activa');

?>

<div class="toolbar">

    <div>

        <h1>
            Asistencia · ficha <?= e($s['numero']) ?>
        </h1>

        <p class="sub">
            Inicio: <?= e($s['inicia_en']) ?>
            · Tolerancia: <?= $s['tolerancia_minutos'] ?> min
            · QR vence en 30 s y la sesión en
            <?= e($s['vence_en']) ?>.
        </p>

    </div>

    <a
        class="btn danger"
        href="cerrar_sesion.php?t=<?= e($s['token']) ?>"
    >
        Cerrar sesión
    </a>

</div>

<section class="scanner">

    <div
        class="card"
        style="text-align:center"
    >

        <h2>
            Los aprendices escanean este QR
        </h2>

        <div
            id="qr"
            style="display:inline-block;padding:16px;border:1px solid #ddd"
        ></div>

        <p class="sub">
            El QR rota automáticamente.
            Si no pueden escanear, abren
            <br>

            <b>
                <?= e($base . 'codigo.php') ?>
            </b>

            <br>

            e ingresan:
        </p>

        <div
            style="font-size:42px;font-weight:800;letter-spacing:8px;color:#39a900"
        >
            <?= e($s['codigo']) ?>
        </div>

    </div>

    <div class="card">

        <h2>
            Registro manual
        </h2>

        <form
            method="post"
            action="registro_manual.php"
        >

            <input
                type="hidden"
                name="csrf"
                value="<?= csrf() ?>"
            >

            <input
                type="hidden"
                name="t"
                value="<?= e($s['token']) ?>"
            >

            <label>
                Documento del aprendiz
            </label>

            <input
                name="documento"
                required
            >

            <button style="margin-top:12px">
                Registrar manualmente
            </button>

        </form>

        <hr>

        <h2>
            Registrados (<?= count($rows->fetchAll()) ?>)
        </h2>

        <?php $rows->execute([$s['id']]); ?>

        <?php foreach ($rows as $r): ?>

            <p>

                <b>
                    <?= e($r['nombre']) ?>
                </b>

                <?= $r['tarde_minutos']
                    ? '<span class="badge">Tarde: ' .
                      $r['tarde_minutos'] .
                      ' min</span>'
                    : ''
                ?>

                <br>

                <small>
                    <?= e(
                        $r['fecha_hora'] .
                        ' · GPS: ' .
                        $r['latitud'] .
                        ', ' .
                        $r['longitud']
                    ) ?>
                </small>

            </p>

        <?php endforeach ?>

    </div>

</section>

<script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>

<script>

const q = document.querySelector('#qr');

const base = <?= json_encode($base . 'registro.php?s=' . $s['token']) ?>;

function draw() {

    q.innerHTML = '';

    new QRCode(q, {
        text: base + '&r=' + Math.floor(Date.now() / 30000),
        width: 290,
        height: 290,
        colorDark: '#173100',
        colorLight: '#fff'
    });

}

draw();

setInterval(draw, 30000);

</script>

<?php

foot();

?>