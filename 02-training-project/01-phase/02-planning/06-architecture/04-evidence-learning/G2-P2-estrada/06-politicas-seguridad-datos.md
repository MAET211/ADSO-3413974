# B6 · Políticas de Seguridad de los Datos y Matriz de Roles
**Evidencia:** Guía 2 · Producto 2 (`G2-P2`) — Artefacto B6  
**Competencia:** 220501095 · **RAP:** 593101 (Criterio 5)  
**Aprendiz:** `MAET211` (Carpeta: `G2-P2-estrada`)  

---

## 1. Políticas Concretas de Seguridad de Datos (Integridad, Confidencialidad y Disponibilidad)

Dando cumplimiento al **Criterio 5 (Nivel 100)** de `Rubricas_G2.md`, se definen **9 políticas concretas (3 por cada principio CIA)** aplicadas directamente sobre las tablas y columnas reales del esquema PostgreSQL 18 del SGA, alineadas con `RNF-001`..`RNF-007`, `RNF-028`..`RNF-029` y la Ley Estatutaria 1581 de 2012 (*Habeas Data*):

| # | Principio | Política Concreta Aplicada al Modelo SGA | Tablas / Columnas y Mecanismo Técnico | Requisito / Norma |
| :-: |---|---|---|---|
| **P1** | **Integridad** | **Validación declarativa de cierre clínico REPS y justificación manual.** Ningún servicio pasa a `'Finalizado'` ni cambia a asignación manual sin sus campos obligatorios validados en base de datos. | `servicios` (`CHECK ck_srv_cierre_reps`, `ck_srv_mot_manual`, `ck_srv_estado`) y `novedades` (`ck_nov_cierre`); llaves foráneas `ON DELETE RESTRICT` en `solicitudes_emergencia`, `ambulancias` y `facturas`. | `RF-023`, `RF-025`, `RN-005`, `RN-007` |
| **P2** | **Integridad** | **Inmutabilidad estricta de facturas y trazabilidad append-only en auditoría.** Queda prohibido ejecutar `UPDATE` o `DELETE` desde el rol aplicativo sobre `facturas`, `historial_estados_servicio` y `auditorias`; las correcciones financieras solo insertan registros en `notas_credito_debito`. | `facturas` (`es_inmutable = TRUE`), `notas_credito_debito`, `auditorias` (`valores_anteriores`/`valores_nuevos JSONB`); revocación SQL de `UPDATE`/`DELETE` en auditoría. | `RF-031`, `RF-056`, `RN-010`, `RN-014` |
| **P3** | **Integridad** | **Control de unicidad institucional y bloqueo de vigencia operativa.** Impide duplicar placas, códigos REPS, radicados o asignar personal por fuera de su jornada continua máxima. | Índices `UNIQUE` en `ambulancias(placa, num_habilitacion_reps)`, `personal(tarjeta_profesional)`, `usuarios(correo)` y `CHECK (horas_turno_continuas BETWEEN 0 AND 24)`. | `RF-008`, `RF-014`, `RN-003`, `RN-004` |
| **P4** | **Confidencialidad** | **Almacenamiento irreversible de contraseñas con hash y sal única + política 90 días.** Queda prohibido almacenar contraseñas en texto plano o con cifrado simétrico reversible. Se aplica `Argon2id` (o `bcrypt` factor $\ge 12$) con sal única por usuario, expiración a 90 días y bloqueo automático de 30 min tras 5 fallos. | `usuarios.password_hash`, `usuarios.intentos_fallidos`, `usuarios.bloqueado_hasta`, `usuarios.password_expira`. | `RNF-001`, `RNF-005`, `RN-008`, `RN-009` |
| **P5** | **Confidencialidad** | **Cifrado de tráfico en tránsito (TLS 1.3) y protección de datos clínicos en reposo.** Toda transmisión SPA $\leftrightarrow$ API usa `HTTPS/WSS (TLS 1.3)`, conexiones app $\leftrightarrow$ BD usan `PostgreSQL SSL (TCP 5432)`, y los campos sensibles de pacientes se cifran en disco/columna bajo autorización explícita. | Canal `TLS 1.3`, volumen cifrado `AES-256`; columnas `pacientes(numero_documento, antecedentes_medicos)` y `paciente_telefonos(numero_telefono)` visibles solo a roles clínicos/coordinación. | `RNF-002`, `RNF-004` (Ley 1581/2012) |
| **P6** | **Confidencialidad** | **Tratamiento de datos personales (finalidad y autorización) + RBAC por mínimo privilegio.** Los datos de identificación y salud se recopilan con finalidad exclusiva de atención prehospitalaria/facturación bajo autorización del titular o urgencia vital, y el acceso se restringe en middleware `JWT` + permisos por rol. | `roles`, `usuarios.id_rol`; el rol `Vigilante` nunca consulta `pacientes` ni `facturas`; el rol `Ciudadano` consulta PQRS únicamente por `codigo_radicado`. | `RF-005`, `RF-018`, `RF-042`, `RNF-003`, Ley 1581 |
| **P7** | **Disponibilidad** | **Respaldo automático diario con retención de 30 copias y prueba mensual de restauración.** Ejecución diaria de `pg_dump` cifrado hacia bóveda externa (`Boveda_Respaldos_30d`) asegurando recuperación ante fallos con `RTO <= 4 h` y `RPO <= 24 h`, más simulacro mensual de restauración documentado en acta. | Esquema completo `public` de PostgreSQL 18 (16 tablas + índices) + retención mínima 5 años para `auditorias`. | `RNF-013`, `RNF-015`, `RNF-021`, `RNF-029` |
| **P8** | **Disponibilidad** | **Operación continua 24/7 con monitoreo, failover de contenedores e índices críticos.** Despliegue Docker con reinicio automático, alertas `Prometheus/Grafana` e índices compuestos que evitan bloqueos en consultas de emergencia de $\le 2\text{ s}$. | `idx_ambulancias_estado_tipo`, `idx_servicios_estado`, `idx_auditorias_modulo_fecha` (uptime objetivo $\ge 97\%$). | `RNF-008`, `RNF-009`, `RNF-013` |
| **P9** | **Disponibilidad** | **Aislamiento de red y mitigación de fuerza bruta/denegación de servicio.** El nodo PostgreSQL solo acepta tráfico desde la IP privada de aplicación (`TCP 5432`), protegido por Firewall UFW y `Fail2Ban` en el Edge Nginx. | Topología VPC (`Nodo_Proxy_Reverso` $\rightarrow$ `Nodo_Aplicacion_Docker` $\rightarrow$ `Nodo_Datos_Respaldo`). | `RNF-002`, `RNF-006`, `RNF-013` |

---

## 2. Matriz de Privilegios RBAC: 5 Roles SGA $\times$ 16 Tablas Lógicas

Convenciones: `S` = `SELECT`, `I` = `INSERT`, `U` = `UPDATE`, `D` = `DELETE (solo baja lógica / autorizado)`, `—` = Sin acceso. *(Ningún rol aplicativo posee `UPDATE` ni `DELETE` sobre `auditorias` ni `DELETE` sobre `facturas` o `historial_estados_servicio`.)*

| Tabla (`B2`/`B5`) | `Administrador` | `Coordinador` | `Paramedico` | `Conductor` | `Vigilante` |
|---|---|---|---|---|---|
| `sedes` | `S, I, U` | `S` | `S` | `S` | `S` |
| `roles` | `S, I, U` | `S` | — | — | — |
| `usuarios` | `S, I, U` *(propio/gestión)* | `S` *(propio/tripulación)* | `S, U` *(solo propia clave)* | `S, U` *(solo propia clave)* | `S, U` *(solo propia clave)* |
| `personal` | `S, I, U` | `S, U` *(disponibilidad)* | `S` *(propia ficha)* | `S` *(propia ficha)* | — |
| `pacientes` | `S` | `S, I, U` | `S, I, U` *(atención activa)* | — | — |
| `paciente_telefonos` | `S` | `S, I, U` | `S, I` | — | — |
| `ambulancias` | `S, I, U` | `S, U` *(estado operativo)* | `S` | `S` | `S` *(solo placa/estado entrada sede)* |
| `solicitudes_emergencia` | `S` | `S, I, U` | `S` *(asignadas)* | — | — |
| `servicios` | `S` | `S, I, U` | `S, U` *(cierre REPS asignado)* | `S` *(asignados)* | — |
| `personal_servicio` | `S` | `S, I, U` | `S` *(propios)* | `S` *(propios)* | — |
| `historial_estados_servicio` | `S` *(solo lectura)* | `S, I` | `S, I` | `S` | — |
| `facturas` | `S, I` *(nunca `U`/`D`)* | `S` *(solo lectura)* | `S` *(disparo cierre)* | — | — |
| `notas_credito_debito` | `S, I` *(ajuste formal)* | — | — | — | — |
| `pqrs` | `S, I, U` | `S, U` *(asignados)* | `S` *(propios)* | — | — |
| `novedades` | `S, I, U` | `S, I, U` | `S, I, U` *(en turno)* | `S, I` *(falla mecánica)* | `S, I` *(novedad acceso sede)* |
| `auditorias` | `S` *(solo lectura, `RF-057`)* | — *(solo escritura vía sistema `I`)* | — *(escritura vía sistema `I`)* | — *(escritura vía sistema `I`)* | — *(escritura vía sistema `I`)* |

*(Nota sobre `Usuario / Ciudadano` en PQRS pública `RF-042`: accede exclusivamente mediante consulta parametrizada de endpoint público por `codigo_radicado` sobre una vista restringida de `pqrs` sin exponer datos de `pacientes` ni de otros usuarios).*
