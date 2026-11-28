# B4 · Diccionario de Datos Técnico (PostgreSQL 18 · 3FN)
**Evidencia:** Guía 2 · Producto 2 (`G2-P2`) — Artefacto B4  
**Competencia:** 220501095 · **RAP:** 593101 (Criterio 4)  
**Aprendiz:** `MAET211` (Carpeta: `G2-P2-estrada`)  

---

## 1. Estándar de Nombrado Declarado
- **Tablas:** Sustantivos en plural en `snake_case` minúsculas (ej. `ambulancias`, `servicios`, `paciente_telefonos`).
- **Columnas:** Nombres descriptivos en `snake_case` sin abreviaturas ambiguas.
- **Llaves Primarias (PK):** Prefijo `id_<entidad_singular>` de tipo `UUID` (`DEFAULT gen_random_uuid()`), salvo la entidad débil `historial_estados_servicio` con clave compuesta `(id_servicio, numero_secuencia)`.
- **Llaves Foráneas (FK) y Restricciones:** Nomenclatura `fk_<tabla>_<referencia>`, `uq_<tabla>_<campo>` y `ck_<tabla>_<regla>`. Coincidencia 100 % exacta con [`05-script-creacion-sga.sql`](./05-script-creacion-sga.sql) y [`02-modelo-logico-relacional.svg`](./02-modelo-logico-relacional.svg).

---

## 2. Definición Completa de Tablas y Columnas (`16` Tablas · 100 %)

### 2.1 `sedes` (Sedes y bases operativas de despacho)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_sede` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador único UUID v4 |
| `codigo_sede` | `VARCHAR` | 20 | `NOT NULL`, `UNIQUE` | Código institucional de base (ej. `SEDE-CEN`) |
| `nombre_sede` | `VARCHAR` | 120 | `NOT NULL` | Nombre oficial de la sede |
| `ciudad` | `VARCHAR` | 80 | `NOT NULL` | Municipio donde opera la sede |
| `direccion` | `VARCHAR` | 180 | `NOT NULL` | Dirección física de la sede |
| `activa` | `BOOLEAN` | 1 B | `NOT NULL`, `DEFAULT TRUE` | `{TRUE, FALSE}` estado de operación |
| `created_at` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha y hora de creación |

### 2.2 `roles` (Perfiles RBAC del sistema — `RF-005`, `RF-006`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_rol` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador único del rol |
| `nombre_rol` | `VARCHAR` | 50 | `NOT NULL`, `UNIQUE`, `CHECK` (`ck_roles_nombre`) | `{'Administrador','Coordinador','Paramedico','Conductor','Vigilante'}` |
| `descripcion` | `TEXT` | Variable | `NULL` | Alcance funcional del perfil |
| `activo` | `BOOLEAN` | 1 B | `NOT NULL`, `DEFAULT TRUE` | `{TRUE, FALSE}` |
| `created_at` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha de registro |

### 2.3 `usuarios` (Cuentas autenticadas — `RF-001`..`RF-007`, `RN-008`, `RN-009`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_usuario` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador único del usuario |
| `id_rol` | `UUID` | 16 B | `NOT NULL`, `FK → roles(id_rol) ON DELETE RESTRICT ON UPDATE CASCADE` | Rol RBAC asignado |
| `id_sede` | `UUID` | 16 B | `NOT NULL`, `FK → sedes(id_sede) ON DELETE RESTRICT ON UPDATE CASCADE` | Sede base del usuario |
| `nombre_completo` | `VARCHAR` | 150 | `NOT NULL` | Nombre del funcionario o usuario interno |
| `correo` | `VARCHAR` | 200 | `NOT NULL`, `UNIQUE` | Correo electrónico único de acceso |
| `password_hash` | `VARCHAR` | 255 | `NOT NULL` | Hash con sal única (`bcrypt` o `Argon2`, `RNF-001`) |
| `activo` | `BOOLEAN` | 1 B | `NOT NULL`, `DEFAULT TRUE` | `{TRUE, FALSE}` (soporte baja lógica) |
| `intentos_fallidos` | `INTEGER` | 4 B | `NOT NULL`, `DEFAULT 0`, `CHECK` (`0..5`) | Contador bloqueo 5 fallos (`RN-009`) |
| `bloqueado_hasta` | `TIMESTAMP` | 8 B | `NULL` | Fin de bloqueo automático 30 min (`RN-009`) |
| `password_expira` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT +90 days` | Expiración obligatoria cada 90 días (`RN-008`) |
| `ultimo_acceso` | `TIMESTAMP` | 8 B | `NULL` | Último inicio de sesión válido |
| `created_at` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha de creación de cuenta |

### 2.4 `personal` (Talento asistencial y conductores — `RF-014`..`RF-017`, `RN-004`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_personal` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador único de personal |
| `id_usuario` | `UUID` | 16 B | `NOT NULL`, `UNIQUE`, `FK → usuarios(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE` | Relación `1:0..1` con cuenta |
| `tarjeta_profesional` | `VARCHAR` | 40 | `NOT NULL`, `UNIQUE` | Registro ReTHUS / licencia de conducción |
| `tipo_personal` | `VARCHAR` | 30 | `NOT NULL`, `CHECK` (`ck_personal_tipo`) | `{'Medico','Paramedico','Auxiliar','Conductor'}` |
| `estado_disponibilidad` | `VARCHAR` | 25 | `NOT NULL`, `DEFAULT 'Disponible'`, `CHECK` | `{'Disponible','En servicio','En descanso','Incapacitado'}` |
| `vigencia_certificacion` | `DATE` | 4 B | `NOT NULL` | Fecha límite habilitación soporte vital (`RN-004`) |
| `horas_turno_continuas` | `DECIMAL` | `(4,1)` | `NOT NULL`, `DEFAULT 0.0`, `CHECK (0..24)` | Horas trabajadas en turno continuo (`RF-017`) |

### 2.5 `pacientes` (Titulares atendidos — `RF-018`..`RF-020`, Ley 1581/2012)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_paciente` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador único del paciente |
| `tipo_documento` | `VARCHAR` | 10 | `NOT NULL`, `CHECK` (`ck_pacientes_tipo_doc`) | `{'CC','TI','CE','PA','RC'}` |
| `numero_documento` | `VARCHAR` | 25 | `NOT NULL`, `UNIQUE(tipo_documento, numero_documento)` | Número de identificación único por tipo |
| `nombre_completo` | `VARCHAR` | 150 | `NOT NULL` | Nombre completo del paciente |
| `fecha_nacimiento` | `DATE` | 4 B | `NOT NULL` | Fecha de nacimiento |
| `antecedentes_medicos` | `TEXT` | Variable | `NULL` | Alergias y condiciones previas relevantes |

### 2.6 `paciente_telefonos` (Teléfonos de contacto derivados de 1FN — `RF-018`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_telefono` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador único de contacto |
| `id_paciente` | `UUID` | 16 B | `NOT NULL`, `FK → pacientes(id_paciente) ON DELETE CASCADE ON UPDATE CASCADE` | Paciente propietario del teléfono |
| `tipo_contacto` | `VARCHAR` | 25 | `NOT NULL`, `CHECK` (`ck_tel_tipo`) | `{'Personal','Familiar','Acompanante'}` |
| `numero_telefono` | `VARCHAR` | 25 | `NOT NULL` | Número telefónico atómico |
| `es_principal` | `BOOLEAN` | 1 B | `NOT NULL`, `DEFAULT FALSE` | `{TRUE, FALSE}` |

### 2.7 `ambulancias` (Flota TAB/TAM con discriminador — `RF-008`..`RF-013`, `RN-001`..`RN-003`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_ambulancia` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador único del móvil |
| `id_sede` | `UUID` | 16 B | `NOT NULL`, `FK → sedes(id_sede) ON DELETE RESTRICT ON UPDATE CASCADE` | Sede base donde estaciona |
| `numero_unidad` | `VARCHAR` | 20 | `NOT NULL`, `UNIQUE` | Código interno de flota (ej. `M-104`) |
| `placa` | `VARCHAR` | 10 | `NOT NULL`, `UNIQUE` | Matrícula vehicular única |
| `tipo` | `VARCHAR` | 5 | `NOT NULL`, `CHECK` (`ck_ambulancias_tipo`) | `{'TAB','TAM'}` (Resolución 3100 `RN-002`) |
| `marca` | `VARCHAR` | 60 | `NOT NULL` | Marca del vehículo |
| `modelo` | `VARCHAR` | 60 | `NOT NULL` | Línea o referencia |
| `anio` | `INTEGER` | 4 B | `NOT NULL`, `CHECK (anio >= 1990)` | Año modelo $\ge 1990$ |
| `num_habilitacion_reps` | `VARCHAR` | 50 | `NOT NULL`, `UNIQUE` | Código oficial REPS vigente |
| `estado_operativo` | `VARCHAR` | 25 | `NOT NULL`, `DEFAULT 'Disponible'`, `CHECK` | `{'Disponible','En servicio','En mantenimiento','Fuera de servicio'}` |
| `vigencia_soat_tecno` | `DATE` | 4 B | `NOT NULL` | Vencimiento documental bloqueante (`RN-003`) |

### 2.8 `solicitudes_emergencia` (Recepción y triage — `RF-021`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_solicitud` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador de solicitud |
| `id_paciente` | `UUID` | 16 B | `NOT NULL`, `FK → pacientes(id_paciente) ON DELETE RESTRICT ON UPDATE CASCADE` | Paciente afectado |
| `codigo_radicado` | `VARCHAR` | 30 | `NOT NULL`, `UNIQUE` | Código único de radicación |
| `nombre_solicitante` | `VARCHAR` | 120 | `NOT NULL` | Persona que reporta la llamada |
| `direccion_evento` | `VARCHAR` | 180 | `NOT NULL` | Ubicación del incidente |
| `coordenadas_gps` | `VARCHAR` | 60 | `NULL` | Latitud/longitud cuando aplica |
| `prioridad_triage` | `VARCHAR` | 15 | `NOT NULL`, `CHECK` (`ck_sol_triage`) | `{'Rojo','Naranja','Amarillo','Verde'}` |
| `sintomatologia` | `TEXT` | Variable | `NOT NULL` | Descripción clínica inicial |
| `fecha_hora_solicitud` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Instante de captura |
| `estado_solicitud` | `VARCHAR` | 25 | `NOT NULL`, `DEFAULT 'Recibida'`, `CHECK` | `{'Recibida','Despachada','Cancelada'}` |

### 2.9 `servicios` (Núcleo asistencial — `RF-022`..`RF-027`, `RN-005`, `RN-007`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_servicio` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador único del servicio |
| `id_solicitud` | `UUID` | 16 B | `NOT NULL`, `UNIQUE`, `FK → solicitudes_emergencia(id_solicitud) ON DELETE RESTRICT ON UPDATE CASCADE` | Relación `1:1` sin servicios huérfanos |
| `id_ambulancia` | `UUID` | 16 B | `NOT NULL`, `FK → ambulancias(id_ambulancia) ON DELETE RESTRICT ON UPDATE CASCADE` | Unidad asignada al despacho |
| `id_responsable_cierre` | `UUID` | 16 B | `NULL`, `FK → personal(id_personal) ON DELETE SET NULL ON UPDATE CASCADE` | Obligatorio si `estado = 'Finalizado'` (`ck_srv_cierre_reps`) |
| `asignacion_manual` | `BOOLEAN` | 1 B | `NOT NULL`, `DEFAULT FALSE` | Indica si anuló sugerencia automática |
| `motivo_asignacion_manual` | `TEXT` | Variable | `NULL`, `CHECK` (`ck_srv_mot_manual`) | Obligatorio si `asignacion_manual = TRUE` (`RN-007`) |
| `estado` | `VARCHAR` | 20 | `NOT NULL`, `DEFAULT 'Solicitado'`, `CHECK` | `{'Solicitado','Asignado','En ruta','En atencion','Traslado','Finalizado','Cancelado'}` |
| `hora_asignacion` | `TIMESTAMP` | 8 B | `NULL` | Marca temporal de despacho |
| `hora_llegada` | `TIMESTAMP` | 8 B | `NULL` | Marca temporal de arribo a escena |
| `hora_finalizacion` | `TIMESTAMP` | 8 B | `NULL` | Marca temporal de cierre |
| `resultado_atencion` | `TEXT` | Variable | `NULL`, `CHECK` (`ck_srv_cierre_reps`) | Obligatorio al finalizar (`RN-005`) |
| `estado_paciente_final` | `VARCHAR` | 20 | `NULL`, `CHECK` (`ck_srv_est_pac`) | `{'Estable','Critico','Fallecido'}` |
| `destino_traslado` | `VARCHAR` | 200 | `NULL`, `CHECK` (`ck_srv_cierre_reps`) | IPS receptora / destino de cierre (`RN-005`) |
| `created_at` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha de creación del servicio |

### 2.10 `personal_servicio` (Tabla asociativa N:M — `RF-017`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_personal_servicio` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador de asignación |
| `id_servicio` | `UUID` | 16 B | `NOT NULL`, `FK → servicios(id_servicio) ON DELETE CASCADE ON UPDATE CASCADE` | Servicio asignado |
| `id_personal` | `UUID` | 16 B | `NOT NULL`, `FK → personal(id_personal) ON DELETE RESTRICT ON UPDATE CASCADE` | Miembro tripulante (`UNIQUE(id_servicio, id_personal)`) |
| `rol_operativo` | `VARCHAR` | 40 | `NOT NULL` | Rol desempeñado en la tripulación |
| `hora_asignacion` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Inicio asignación a servicio |
| `hora_liberacion` | `TIMESTAMP` | 8 B | `NULL`, `CHECK (>= hora_asignacion)` | Fin asignación / liberación |
| `activo_en_tripulacion` | `BOOLEAN` | 1 B | `NOT NULL`, `DEFAULT TRUE` | `{TRUE, FALSE}` |

### 2.11 `historial_estados_servicio` (Entidad débil identificadora — `RF-024`, `RF-026`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_servicio` | `UUID` | 16 B | `PK (compuesta)`, `NOT NULL`, `FK → servicios(id_servicio) ON DELETE CASCADE ON UPDATE CASCADE` | Parte identificadora del padre |
| `numero_secuencia` | `INTEGER` | 4 B | `PK (compuesta)`, `NOT NULL`, `CHECK (>= 1)` | Discriminador secuencial $\ge 1$ |
| `id_usuario_responsable` | `UUID` | 16 B | `NULL`, `FK → usuarios(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE` | Operador o tripulante que transicionó |
| `estado_anterior` | `VARCHAR` | 20 | `NULL` | Estado previo (`NULL` en creación) |
| `estado_nuevo` | `VARCHAR` | 20 | `NOT NULL` | Estado resultante |
| `fecha_hora_cambio` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Instante de transición |
| `motivo_justificacion` | `TEXT` | Variable | `NULL` | Justificación manual o cancelación |

### 2.12 `facturas` (Liquidación financiera inmutable — `RF-030`..`RF-035`, `RN-014`, `RN-015`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_factura` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador de factura |
| `id_servicio` | `UUID` | 16 B | `NOT NULL`, `UNIQUE`, `FK → servicios(id_servicio) ON DELETE RESTRICT ON UPDATE CASCADE` | Relación `1:0..1` con servicio |
| `numero_factura` | `VARCHAR` | 30 | `NOT NULL`, `UNIQUE` | Consecutivo oficial único |
| `fecha_emision` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Emisión al cierre (`RF-031`) |
| `valor_total` | `DECIMAL` | `(12,2)` | `NOT NULL`, `CHECK (valor_total > 0)` | Monto liquidado en COP (> 0) |
| `estado_pago` | `VARCHAR` | 20 | `NOT NULL`, `DEFAULT 'Pendiente'`, `CHECK` | `{'Pendiente','Pagada','En mora'}` |
| `dias_mora` | `INTEGER` | 4 B | `NOT NULL`, `DEFAULT 0`, `CHECK (>= 0)` | Días vencidos (`RN-015`) |
| `es_inmutable` | `BOOLEAN` | 1 B | `NOT NULL`, `DEFAULT TRUE` | Bloqueo de alteración directa (`RN-014`) |

### 2.13 `notas_credito_debito` (Ajustes contables permitidos — `RF-031`, `RN-014`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_nota` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador de nota |
| `id_factura` | `UUID` | 16 B | `NOT NULL`, `FK → facturas(id_factura) ON DELETE RESTRICT ON UPDATE CASCADE` | Factura inmutable referenciada |
| `id_usuario_autoriza` | `UUID` | 16 B | `NOT NULL`, `FK → usuarios(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE` | Responsable que autoriza ajuste |
| `tipo_nota` | `VARCHAR` | 15 | `NOT NULL`, `CHECK` (`ck_ncd_tipo`) | `{'Credito','Debito'}` |
| `valor_ajuste` | `DECIMAL` | `(12,2)` | `NOT NULL`, `CHECK (valor_ajuste > 0)` | Valor monetario del ajuste (> 0) |
| `motivo` | `TEXT` | Variable | `NOT NULL` | Motivo contable obligatorio |
| `fecha_emision` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha de expedición |

### 2.14 `pqrs` (Peticiones, Quejas, Reclamos, Sugerencias y Denuncias — `RF-040`..`RF-044`, `RN-011`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_pqrs` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador de PQRS |
| `id_paciente` | `UUID` | 16 B | `NULL`, `FK → pacientes(id_paciente) ON DELETE SET NULL ON UPDATE CASCADE` | Ciudadano/paciente opcional |
| `id_usuario_responsable` | `UUID` | 16 B | `NULL`, `FK → usuarios(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE` | Responsable asignado $\le 24\text{ h}$ (`RN-011`) |
| `codigo_radicado` | `VARCHAR` | 30 | `NOT NULL`, `UNIQUE` | Código público de seguimiento (`RF-042`) |
| `tipo_pqrs` | `VARCHAR` | 15 | `NOT NULL`, `CHECK` (`ck_pqrs_tipo`) | `{'Peticion','Queja','Reclamo','Sugerencia','Denuncia'}` |
| `descripcion_motivo` | `TEXT` | Variable | `NOT NULL` | Contenido radicado por el usuario |
| `fecha_radicacion` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha/hora de radicación |
| `fecha_vencimiento_legal` | `DATE` | 4 B | `NOT NULL` | Plazo límite legal de respuesta |
| `estado_tramite` | `VARCHAR` | 20 | `NOT NULL`, `DEFAULT 'Radicada'`, `CHECK` | `{'Radicada','Asignada','Respondida','Cerrada'}` |

### 2.15 `novedades` (Incidentes operativos y fallas — `RF-059`..`RF-063`, `RN-016`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_novedad` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador de novedad |
| `id_servicio` | `UUID` | 16 B | `NULL`, `FK → servicios(id_servicio) ON DELETE SET NULL ON UPDATE CASCADE` | Servicio asociado opcional |
| `id_ambulancia` | `UUID` | 16 B | `NULL`, `FK → ambulancias(id_ambulancia) ON DELETE SET NULL ON UPDATE CASCADE` | Ambulancia asociada opcional |
| `id_usuario_reporta` | `UUID` | 16 B | `NOT NULL`, `FK → usuarios(id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE` | Quien registra el incidente |
| `tipo_novedad` | `VARCHAR` | 40 | `NOT NULL` | Falla técnica, retraso, accidente, etc. |
| `prioridad` | `VARCHAR` | 15 | `NOT NULL`, `CHECK` (`ck_nov_prioridad`) | `{'Baja','Media','Alta','Critica'}` |
| `descripcion` | `TEXT` | Variable | `NOT NULL` | Relato detallado del evento |
| `resolucion` | `TEXT` | Variable | `NULL`, `CHECK` (`ck_nov_cierre`) | Obligatoria para pasar a `'Cerrado'` (`RN-016`) |
| `estado` | `VARCHAR` | 20 | `NOT NULL`, `DEFAULT 'Pendiente'`, `CHECK` | `{'Pendiente','En proceso','Resuelto','Cerrado'}` |
| `fecha_reporte` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Timestamp de creación |

### 2.16 `auditorias` (Bitácora inmutable 5 años — `RF-055`..`RF-058`, `RN-010`)
| Columna | Tipo PostgreSQL | Tamaño / Precisión | Restricciones | Dominio / Regla de Negocio |
|---|---|---:|---|---|
| `id_auditoria` | `UUID` | 16 B | `PRIMARY KEY`, `DEFAULT gen_random_uuid()` | Identificador de registro inmutable |
| `id_usuario` | `UUID` | 16 B | `NULL`, `FK → usuarios(id_usuario) ON DELETE SET NULL ON UPDATE CASCADE` | `NULL` cuando actúa proceso automático |
| `modulo` | `VARCHAR` | 50 | `NOT NULL` | Módulo afectado |
| `accion` | `VARCHAR` | 30 | `NOT NULL`, `CHECK` (`ck_aud_accion`) | `{'INSERT','UPDATE','DELETE','LOGIN','LOGOUT','BLOQUEO','CIERRE'}` |
| `entidad_afectada` | `VARCHAR` | 50 | `NULL` | Nombre de la tabla auditada |
| `id_entidad` | `UUID` | 16 B | `NULL` | PK del registro afectado |
| `valores_anteriores` | `JSONB` | Variable | `NULL` | Estado previo (`OLD.*`, `RF-057`) |
| `valores_nuevos` | `JSONB` | Variable | `NULL` | Estado posterior (`NEW.*`, `RF-057`) |
| `ip_origen` | `INET` | 7/19 B | `NULL` | IPv4/IPv6 del cliente |
| `fecha_hora` | `TIMESTAMP` | 8 B | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Marca temporal append-only sin borrado (`RN-010`) |
