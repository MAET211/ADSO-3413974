-- =============================================================================
-- SCRIPT SQL DE CREACIÓN DE BASE DE DATOS · SISTEMA GESTOR DE AMBULANCIAS (SGA)
-- Evidencia: Guía 2 · Producto 2 (G2-P2) — Artefacto B5
-- Motor Objetivo: PostgreSQL 18.x (Estándar relacional 3FN)
-- Aprendiz Autor: MAET211 (Carpeta: G2-P2-estrada) · Ficha: 3413974
-- Reglas y Requisitos: RF-001..RF-065, RNF-001..RNF-029, RN-001..RN-018
-- Estándar de nombrado: Tablas en plural snake_case, columnas snake_case, PK id_<singular>
-- =============================================================================

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- 1. SEDES OPERATIVAS
CREATE TABLE sedes (
  id_sede      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo_sede  VARCHAR(20)  NOT NULL UNIQUE,
  nombre_sede  VARCHAR(120) NOT NULL,
  ciudad       VARCHAR(80)  NOT NULL,
  direccion    VARCHAR(180) NOT NULL,
  activa       BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. ROLES DE ACCESO (RBAC - RF-005, RF-006)
CREATE TABLE roles (
  id_rol       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre_rol   VARCHAR(50)  NOT NULL UNIQUE,
  descripcion  TEXT,
  activo       BOOLEAN      NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT ck_roles_nombre CHECK (nombre_rol IN ('Administrador','Coordinador','Paramedico','Conductor','Vigilante'))
);

-- 3. USUARIOS DEL SISTEMA (RF-001..RF-007, RN-008, RN-009)
CREATE TABLE usuarios (
  id_usuario        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_rol            UUID         NOT NULL,
  id_sede           UUID         NOT NULL,
  nombre_completo   VARCHAR(150) NOT NULL,
  correo            VARCHAR(200) NOT NULL UNIQUE,
  password_hash     VARCHAR(255) NOT NULL,
  activo            BOOLEAN      NOT NULL DEFAULT TRUE,
  intentos_fallidos INTEGER      NOT NULL DEFAULT 0,
  bloqueado_hasta   TIMESTAMP,
  password_expira   TIMESTAMP    NOT NULL DEFAULT (CURRENT_TIMESTAMP + INTERVAL '90 days'),
  ultimo_acceso     TIMESTAMP,
  created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_usuarios_rol  FOREIGN KEY (id_rol)  REFERENCES roles (id_rol)  ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_usuarios_sede FOREIGN KEY (id_sede) REFERENCES sedes (id_sede) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_usuarios_intentos CHECK (intentos_fallidos BETWEEN 0 AND 5)
);

-- 4. PERSONAL MÉDICO Y OPERATIVO (Relación 1:0..1 con usuarios - RF-014..RF-017, RN-004)
CREATE TABLE personal (
  id_personal            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_usuario             UUID          NOT NULL UNIQUE,
  tarjeta_profesional    VARCHAR(40)   NOT NULL UNIQUE,
  tipo_personal          VARCHAR(30)   NOT NULL,
  estado_disponibilidad  VARCHAR(25)   NOT NULL DEFAULT 'Disponible',
  vigencia_certificacion DATE          NOT NULL,
  horas_turno_continuas  DECIMAL(4,1)  NOT NULL DEFAULT 0.0,
  CONSTRAINT fk_personal_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_personal_tipo    CHECK (tipo_personal IN ('Medico','Paramedico','Auxiliar','Conductor')),
  CONSTRAINT ck_personal_estado  CHECK (estado_disponibilidad IN ('Disponible','En servicio','En descanso','Incapacitado')),
  CONSTRAINT ck_personal_horas   CHECK (horas_turno_continuas >= 0 AND horas_turno_continuas <= 24)
);

-- 5. PACIENTES (RF-018..RF-020, Ley 1581/2012)
CREATE TABLE pacientes (
  id_paciente          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo_documento       VARCHAR(10)  NOT NULL,
  numero_documento     VARCHAR(25)  NOT NULL,
  nombre_completo      VARCHAR(150) NOT NULL,
  fecha_nacimiento     DATE         NOT NULL,
  antecedentes_medicos TEXT,
  CONSTRAINT uq_pacientes_documento UNIQUE (tipo_documento, numero_documento),
  CONSTRAINT ck_pacientes_tipo_doc  CHECK (tipo_documento IN ('CC','TI','CE','PA','RC'))
);

-- 6. TELÉFONOS DE PACIENTES (Tabla derivada de atributo multivaluado en 1FN)
CREATE TABLE paciente_telefonos (
  id_telefono      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_paciente      UUID        NOT NULL,
  tipo_contacto    VARCHAR(25) NOT NULL,
  numero_telefono  VARCHAR(25) NOT NULL,
  es_principal     BOOLEAN     NOT NULL DEFAULT FALSE,
  CONSTRAINT fk_tel_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ck_tel_tipo     CHECK (tipo_contacto IN ('Personal','Familiar','Acompanante'))
);

-- 7. AMBULANCIAS (Generalización TAB/TAM unificada con discriminador - RF-008..RF-013, RN-001..RN-003)
CREATE TABLE ambulancias (
  id_ambulancia         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_sede               UUID        NOT NULL,
  numero_unidad         VARCHAR(20) NOT NULL UNIQUE,
  placa                 VARCHAR(10) NOT NULL UNIQUE,
  tipo                  VARCHAR(5)  NOT NULL,
  marca                 VARCHAR(60) NOT NULL,
  modelo                VARCHAR(60) NOT NULL,
  anio                  INTEGER     NOT NULL,
  num_habilitacion_reps VARCHAR(50) NOT NULL UNIQUE,
  estado_operativo      VARCHAR(25) NOT NULL DEFAULT 'Disponible',
  vigencia_soat_tecno   DATE        NOT NULL,
  CONSTRAINT fk_ambulancias_sede   FOREIGN KEY (id_sede) REFERENCES sedes (id_sede) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_ambulancias_tipo   CHECK (tipo IN ('TAB','TAM')),
  CONSTRAINT ck_ambulancias_anio   CHECK (anio >= 1990),
  CONSTRAINT ck_ambulancias_estado CHECK (estado_operativo IN ('Disponible','En servicio','En mantenimiento','Fuera de servicio'))
);

-- 8. SOLICITUDES DE EMERGENCIA (RF-021)
CREATE TABLE solicitudes_emergencia (
  id_solicitud         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_paciente          UUID         NOT NULL,
  codigo_radicado      VARCHAR(30)  NOT NULL UNIQUE,
  nombre_solicitante   VARCHAR(120) NOT NULL,
  direccion_evento     VARCHAR(180) NOT NULL,
  coordenadas_gps      VARCHAR(60),
  prioridad_triage     VARCHAR(15)  NOT NULL,
  sintomatologia       TEXT         NOT NULL,
  fecha_hora_solicitud TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  estado_solicitud     VARCHAR(25)  NOT NULL DEFAULT 'Recibida',
  CONSTRAINT fk_sol_paciente   FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_sol_triage     CHECK (prioridad_triage IN ('Rojo','Naranja','Amarillo','Verde')),
  CONSTRAINT ck_sol_estado     CHECK (estado_solicitud IN ('Recibida','Despachada','Cancelada'))
);

-- 9. SERVICIOS ASISTENCIALES (Entidad central - RF-022..RF-027, RN-005, RN-007)
CREATE TABLE servicios (
  id_servicio              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_solicitud             UUID        NOT NULL UNIQUE,
  id_ambulancia            UUID        NOT NULL,
  id_responsable_cierre    UUID,
  asignacion_manual        BOOLEAN     NOT NULL DEFAULT FALSE,
  motivo_asignacion_manual TEXT,
  estado                   VARCHAR(20) NOT NULL DEFAULT 'Solicitado',
  hora_asignacion          TIMESTAMP,
  hora_llegada             TIMESTAMP,
  hora_finalizacion        TIMESTAMP,
  resultado_atencion       TEXT,
  estado_paciente_final    VARCHAR(20),
  destino_traslado         VARCHAR(200),
  created_at               TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_srv_solicitud   FOREIGN KEY (id_solicitud)          REFERENCES solicitudes_emergencia (id_solicitud) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_srv_ambulancia  FOREIGN KEY (id_ambulancia)         REFERENCES ambulancias (id_ambulancia)           ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_srv_resp_cierre FOREIGN KEY (id_responsable_cierre) REFERENCES personal (id_personal)                ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT ck_srv_estado      CHECK (estado IN ('Solicitado','Asignado','En ruta','En atencion','Traslado','Finalizado','Cancelado')),
  CONSTRAINT ck_srv_est_pac     CHECK (estado_paciente_final IS NULL OR estado_paciente_final IN ('Estable','Critico','Fallecido')),
  CONSTRAINT ck_srv_mot_manual  CHECK (asignacion_manual = FALSE OR (motivo_asignacion_manual IS NOT NULL AND LENGTH(TRIM(motivo_asignacion_manual)) > 0)),
  CONSTRAINT ck_srv_cierre_reps CHECK (estado <> 'Finalizado' OR (resultado_atencion IS NOT NULL AND estado_paciente_final IS NOT NULL AND destino_traslado IS NOT NULL AND id_responsable_cierre IS NOT NULL))
);

-- 10. PERSONAL_SERVICIO (Tabla asociativa N:M entre servicios y personal - RF-017)
CREATE TABLE personal_servicio (
  id_personal_servicio  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_servicio           UUID        NOT NULL,
  id_personal           UUID        NOT NULL,
  rol_operativo         VARCHAR(40) NOT NULL,
  hora_asignacion       TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  hora_liberacion       TIMESTAMP,
  activo_en_tripulacion BOOLEAN     NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_ps_servicio  FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio) ON DELETE CASCADE  ON UPDATE CASCADE,
  CONSTRAINT fk_ps_personal  FOREIGN KEY (id_personal) REFERENCES personal (id_personal)  ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT uq_ps_serv_pers UNIQUE (id_servicio, id_personal),
  CONSTRAINT ck_ps_horas     CHECK (hora_liberacion IS NULL OR hora_liberacion >= hora_asignacion)
);

-- 11. HISTORIAL DE ESTADOS DEL SERVICIO (Entidad débil con PK compuesta - RF-024, RF-026)
CREATE TABLE historial_estados_servicio (
  id_servicio            UUID        NOT NULL,
  numero_secuencia       INTEGER     NOT NULL,
  id_usuario_responsable UUID,
  estado_anterior        VARCHAR(20),
  estado_nuevo           VARCHAR(20) NOT NULL,
  fecha_hora_cambio      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  motivo_justificacion   TEXT,
  PRIMARY KEY (id_servicio, numero_secuencia),
  CONSTRAINT fk_hes_servicio FOREIGN KEY (id_servicio)            REFERENCES servicios (id_servicio) ON DELETE CASCADE  ON UPDATE CASCADE,
  CONSTRAINT fk_hes_usuario  FOREIGN KEY (id_usuario_responsable) REFERENCES usuarios (id_usuario)   ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT ck_hes_seq      CHECK (numero_secuencia >= 1)
);

-- 12. FACTURAS (Relación 1:0..1 con servicios, inmutable - RF-030..RF-035, RN-014, RN-015)
CREATE TABLE facturas (
  id_factura    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_servicio   UUID          NOT NULL UNIQUE,
  numero_factura VARCHAR(30)  NOT NULL UNIQUE,
  fecha_emision TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  valor_total   DECIMAL(12,2) NOT NULL,
  estado_pago   VARCHAR(20)   NOT NULL DEFAULT 'Pendiente',
  dias_mora     INTEGER       NOT NULL DEFAULT 0,
  es_inmutable  BOOLEAN       NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_fac_servicio FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_fac_valor    CHECK (valor_total > 0),
  CONSTRAINT ck_fac_estado   CHECK (estado_pago IN ('Pendiente','Pagada','En mora')),
  CONSTRAINT ck_fac_mora     CHECK (dias_mora >= 0)
);

-- 13. NOTAS CRÉDITO Y DÉBITO (Correcciones sobre facturas inmutables - RF-031, RN-014)
CREATE TABLE notas_credito_debito (
  id_nota             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_factura          UUID          NOT NULL,
  id_usuario_autoriza UUID          NOT NULL,
  tipo_nota           VARCHAR(15)   NOT NULL,
  valor_ajuste        DECIMAL(12,2) NOT NULL,
  motivo              TEXT          NOT NULL,
  fecha_emision       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_ncd_factura FOREIGN KEY (id_factura)          REFERENCES facturas (id_factura)  ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_ncd_usuario FOREIGN KEY (id_usuario_autoriza) REFERENCES usuarios (id_usuario)  ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_ncd_tipo    CHECK (tipo_nota IN ('Credito','Debito')),
  CONSTRAINT ck_ncd_valor   CHECK (valor_ajuste > 0)
);

-- 14. PQRS (Peticiones, Quejas, Reclamos, Sugerencias y Denuncias - RF-040..RF-044, RN-011)
CREATE TABLE pqrs (
  id_pqrs                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_paciente             UUID,
  id_usuario_responsable  UUID,
  codigo_radicado         VARCHAR(30) NOT NULL UNIQUE,
  tipo_pqrs               VARCHAR(15) NOT NULL,
  descripcion_motivo      TEXT        NOT NULL,
  fecha_radicacion        TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_vencimiento_legal DATE        NOT NULL,
  estado_tramite          VARCHAR(20) NOT NULL DEFAULT 'Radicada',
  CONSTRAINT fk_pqrs_paciente FOREIGN KEY (id_paciente)            REFERENCES pacientes (id_paciente) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_pqrs_resp     FOREIGN KEY (id_usuario_responsable) REFERENCES usuarios (id_usuario)   ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT ck_pqrs_tipo     CHECK (tipo_pqrs IN ('Peticion','Queja','Reclamo','Sugerencia','Denuncia')),
  CONSTRAINT ck_pqrs_estado   CHECK (estado_tramite IN ('Radicada','Asignada','Respondida','Cerrada'))
);

-- 15. NOVEDADES OPERATIVAS (RF-059..RF-063, RN-016)
CREATE TABLE novedades (
  id_novedad         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_servicio        UUID,
  id_ambulancia      UUID,
  id_usuario_reporta UUID        NOT NULL,
  tipo_novedad       VARCHAR(40) NOT NULL,
  prioridad          VARCHAR(15) NOT NULL,
  descripcion        TEXT        NOT NULL,
  resolucion         TEXT,
  estado             VARCHAR(20) NOT NULL DEFAULT 'Pendiente',
  fecha_reporte      TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_nov_servicio   FOREIGN KEY (id_servicio)        REFERENCES servicios (id_servicio)     ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_nov_ambulancia FOREIGN KEY (id_ambulancia)      REFERENCES ambulancias (id_ambulancia) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk_nov_usuario    FOREIGN KEY (id_usuario_reporta) REFERENCES usuarios (id_usuario)       ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_nov_prioridad  CHECK (prioridad IN ('Baja','Media','Alta','Critica')),
  CONSTRAINT ck_nov_estado     CHECK (estado IN ('Pendiente','En proceso','Resuelto','Cerrado')),
  CONSTRAINT ck_nov_cierre     CHECK (estado <> 'Cerrado' OR (resolucion IS NOT NULL AND LENGTH(TRIM(resolucion)) > 0))
);

-- 16. AUDITORÍA TRANSACCIONAL INMUTABLE (RF-055..RF-058, RN-010 - retención >= 5 años)
CREATE TABLE auditorias (
  id_auditoria       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  id_usuario         UUID,
  modulo             VARCHAR(50) NOT NULL,
  accion             VARCHAR(30) NOT NULL,
  entidad_afectada   VARCHAR(50),
  id_entidad         UUID,
  valores_anteriores JSONB,
  valores_nuevos     JSONB,
  ip_origen          INET,
  fecha_hora         TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_aud_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT ck_aud_accion  CHECK (accion IN ('INSERT','UPDATE','DELETE','LOGIN','LOGOUT','BLOQUEO','CIERRE'))
);

-- ÍNDICES DE RENDIMIENTO (A4 / RNF-008 / RNF-009 <= 2 s)
CREATE INDEX idx_ambulancias_estado_tipo ON ambulancias (estado_operativo, tipo);
CREATE INDEX idx_servicios_estado ON servicios (estado);
CREATE INDEX idx_auditorias_modulo_fecha ON auditorias (modulo, fecha_hora DESC);
