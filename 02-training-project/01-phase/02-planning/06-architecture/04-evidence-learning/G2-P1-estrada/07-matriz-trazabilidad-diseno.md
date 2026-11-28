# A7 · Matriz de Trazabilidad Bidireccional Análisis ↔ Diseño
**Evidencia:** Guía 2 · Producto 1 (`G2-P1`) — Artefacto A7  
**Competencia:** 220501095 · **RAP:** 593103 (Criterio 7 — Trazabilidad 100 % hacia adelante y hacia atrás)  
**Aprendiz:** `MAET211` (Carpeta: `G2-P1-estrada`)  

---

## 1. Matriz Hacia Adelante: 100 % de Requisitos Funcionales (`RF-001` a `RF-065`) y RNF Clave $\rightarrow$ Diseño

| Requisito (SRS) | Caso de Uso (`G1`) | Clase(s) de Diseño (`A2`) | Tabla(s) Lógicas (`B2`/`B5`) | Componente (`A5`) | Decisión / Patrón (`A3`/`A4`) |
|---|---|---|---|---|---|
| **RF-001** | `CU-01` | `Usuario`, `RegistroAuditoria` | `usuarios`, `auditorias` | `Comp_SeguridadAcceso` | CRUD auditado + RBAC en Capa 2 |
| **RF-002** | `CU-01` | `Usuario`, `Rol` | `usuarios`, `roles` | `Comp_SeguridadAcceso` | Token JWT expiración $\le 8\text{ h}$ (`RNF-001`) |
| **RF-003** | `CU-01` | `Usuario` | `usuarios` | `Comp_SeguridadAcceso` | Expiración por inactividad 15 min |
| **RF-004** | `CU-01` | `Usuario` | `usuarios` | `Comp_SeguridadAcceso` | Enlace SMTP `TLS 587` vigente 30 min |
| **RF-005** | `CU-01` | `Rol`, `Usuario` | `roles`, `usuarios` | `Comp_SeguridadAcceso` | Middleware `IAutorizacionRBAC` por 5 perfiles |
| **RF-006** | `CU-01` / `CU-06` | `Rol`, `RegistroAuditoria` | `roles`, `auditorias` | `Comp_SeguridadAcceso` | Auditoría automática de cambios de rol (`RN-010`) |
| **RF-007** | `CU-01.1` | `Usuario`, `RegistroAuditoria` | `usuarios`, `auditorias` | `Comp_SeguridadAcceso` | Bloqueo automático 30 min tras 5 fallos (`RN-009`) |
| **RF-008** | `CU-08` | `Ambulancia`, `AmbulanciaTAB`, `AmbulanciaTAM` | `ambulancias`, `sedes` | `Comp_FlotaPersonal` | Herencia `Ambulancia` + discriminador STI `TAB/TAM` |
| **RF-009** | `CU-07` | `Ambulancia` | `ambulancias` | `Comp_FlotaPersonal` | Canal WebSockets tiempo real (`Gateway_WebSockets_SMTP`) |
| **RF-010** | `CU-08` | `Ambulancia` | `ambulancias`, `sedes` | `Comp_FlotaPersonal` | Índice compuesto `(estado_operativo, tipo)` |
| **RF-011** | `CU-09` | `Ambulancia` | `ambulancias` | `Comp_FlotaPersonal` | Validación REPS/SOAT bloqueante (`RN-003`) |
| **RF-012** | `CU-08` | `Ambulancia`, `NovedadOperativa` | `ambulancias`, `novedades` | `Comp_FlotaPersonal` | Registro operativo de mantenimientos y fallas |
| **RF-013** | `CU-08` / `CU-09` | `AmbulanciaTAB`, `AmbulanciaTAM` | `ambulancias` | `Comp_FlotaPersonal` | Polimorfismo `validarDotacionMinima()` Res. 3100 |
| **RF-014** | `CU-03` / `CU-01` | `PersonalSalud`, `Usuario` | `personal`, `usuarios` | `Comp_FlotaPersonal` | Relación `1:0..1` usuario-personal (`UNIQUE FK`) |
| **RF-015** | `CU-03` / `CU-07` | `PersonalSalud` | `personal` | `Comp_FlotaPersonal` | Disponibilidad de tripulación en tiempo real |
| **RF-016** | `CU-03` | `PersonalSalud` | `personal` | `Comp_FlotaPersonal` | Verificación `estaHabilitado()` (`RN-004`) |
| **RF-017** | `CU-05` | `PersonalSalud`, `ServicioAsistencial` | `personal_servicio`, `servicios` | `Comp_FlotaPersonal` | Tabla intermedia N:M con horas continuas |
| **RF-018** | `CU-02` | `Paciente` | `pacientes`, `paciente_telefonos` | `Comp_NucleoEmergencias` | Tabla 1FN `paciente_telefonos` + Ley 1581 (`RNF-004`) |
| **RF-019** | `CU-02` | `Paciente`, `ServicioAsistencial` | `pacientes`, `servicios` | `Comp_NucleoEmergencias` | Vinculación clínica inicial del paciente |
| **RF-020** | `CU-02` | `Paciente`, `ServicioAsistencial` | `pacientes`, `solicitudes_emergencia`, `servicios` | `Comp_NucleoEmergencias` | Consulta histórica filtrada bajo RBAC |
| **RF-021** | `CU-02` | `SolicitudEmergencia` | `solicitudes_emergencia` | `Comp_NucleoEmergencias` | Captura y triage (`Rojo`..`Verde`) en `FachadaEmergenciaSGA` |
| **RF-022** | `CU-03` | `FachadaEmergenciaSGA`, `IEstrategiaAsignacion`, `AsignacionAutomaticaProximidad`, `ServicioAsistencial` | `servicios`, `ambulancias` | `Comp_NucleoEmergencias` | **GoF Strategy + Facade** en $\le 2\text{ s}$ (`RNF-009`) |
| **RF-023** | `CU-04` | `FachadaEmergenciaSGA`, `IEstrategiaAsignacion`, `AsignacionManualContingencia`, `HistorialEstado` | `servicios`, `historial_estados_servicio` | `Comp_NucleoEmergencias` | **GoF Strategy** manual + motivo `RN-007` (`CHECK`) |
| **RF-024** | `CU-05` | `ServicioAsistencial`, `HistorialEstado` | `servicios`, `historial_estados_servicio` | `Comp_NucleoEmergencias` | Composición `1 *-- 1..*` máquina 7 estados |
| **RF-025** | `CU-05` | `FachadaEmergenciaSGA`, `ServicioAsistencial` | `servicios` | `Comp_NucleoEmergencias` | **GoF Facade** + `CHECK ck_srv_cierre_reps` (`RN-005`) |
| **RF-026** | `CU-05` / `CU-06` | `ServicioAsistencial`, `HistorialEstado`, `RegistroAuditoria` | `servicios`, `historial_estados_servicio`, `auditorias` | `Comp_NucleoEmergencias` | Cancelación justificada solo en estados iniciales (`RN-006`) |
| **RF-027** | `CU-05` | `ServicioAsistencial` | `servicios` | `Comp_NucleoEmergencias` | Consulta de historial con exportación solo lectura |
| **RF-028** | `CU-07` | `Ambulancia`, `AmbulanciaTAB`, `AmbulanciaTAM` | `ambulancias` | `Comp_FlotaPersonal` | Panel tiempo real `Socket.IO` diferenciando TAB/TAM |
| **RF-029** | `CU-07` | `ServicioAsistencial`, `Ambulancia`, `NovedadOperativa` | `servicios`, `ambulancias`, `novedades` | `Comp_FlotaPersonal` | KPIs operativos y alertas críticas en tablero |
| **RF-030** | `CU-11` | `Factura` | `facturas` | `Comp_FacturacionCartera` | Separación de responsabilidad de cobro (Regla 5) |
| **RF-031** | `CU-11` / `CU-05` | `FachadaEmergenciaSGA`, `Factura` | `facturas`, `notas_credito_debito` | `Comp_FacturacionCartera` | Factura inmutable (`RN-014`) + notas de ajuste |
| **RF-032** | `CU-11` | `Factura` | `facturas` | `Comp_FacturacionCartera` | Cálculo automático mora día 1 y bloqueo día 30 (`RN-015`) |
| **RF-033** | `CU-11` | `Factura` | `facturas` | `Comp_FacturacionCartera` | Alertas Cron de cobranza 3 días antes de vencimiento |
| **RF-034** | `CU-11` | `Factura`, `RegistroAuditoria` | `facturas`, `auditorias` | `Comp_FacturacionCartera` | Generación e historial inalterable de comprobantes |
| **RF-035** | `CU-11` | `Factura` | `facturas`, `notas_credito_debito` | `Comp_FacturacionCartera` | Consulta de estado de cuenta autorizado |
| **RF-036** | `CU-08` | `Usuario`, `RegistroAuditoria` | `sedes`, `auditorias` | `Comp_FlotaPersonal` | Control de ingreso/salida física en sedes (`RN-017`) |
| **RF-037** | `CU-08` | `Usuario`, `RegistroAuditoria` | `sedes`, `auditorias` | `Comp_FlotaPersonal` | Validación de identidad y alertas en sede |
| **RF-038** | `CU-08` | `Usuario` | `usuarios`, `sedes` | `Comp_SeguridadAcceso` | Pre-autorización interna de visitas por usuario |
| **RF-039** | `CU-08` | `RegistroAuditoria` | `auditorias`, `sedes` | `Comp_FlotaPersonal` | Historial de accesos y reportes por sede |
| **RF-040** | `CU-10` | `PQRS` | `pqrs` | `Comp_PQRSeInformes` | Radicación PQRS con código único (`UNIQUE`) y plazo legal |
| **RF-041** | `CU-10` | `PQRS`, `Usuario` | `pqrs`, `usuarios` | `Comp_PQRSeInformes` | Asignación obligatoria responsable $\le 24\text{ h}$ (`RN-011`) |
| **RF-042** | `CU-10` | `PQRS` | `pqrs` | `Comp_PQRSeInformes` | Consulta pública sin sesión por `codigo_radicado` |
| **RF-043** | `CU-10` | `PQRS` | `pqrs` | `Comp_PQRSeInformes` | Respuesta formal con soporte y alerta de vencimiento |
| **RF-044** | `CU-10` | `PQRS`, `RegistroAuditoria` | `pqrs`, `auditorias` | `Comp_PQRSeInformes` | Trazabilidad inalterable e informes de satisfacción |
| **RF-045** | `CU-08` | `Ambulancia` | `ambulancias`, `sedes` | `Comp_FlotaPersonal` | Vinculación de unidades a sedes y clasificación |
| **RF-046** | `CU-08` | `Ambulancia`, `RegistroAuditoria` | `ambulancias`, `auditorias` | `Comp_FlotaPersonal` | Control contractual/operativo e historial de cambios |
| **RF-047** | `CU-08` | `Ambulancia` | `ambulancias`, `sedes` | `Comp_FlotaPersonal` | Control de vigencia con alertas 30/15/5 días (`RN-012`) |
| **RF-048** | `CU-08` | `Ambulancia`, `RegistroAuditoria` | `ambulancias`, `auditorias` | `Comp_FlotaPersonal` | Bloqueo por vencimiento contractual y notificaciones |
| **RF-049** | `CU-08` | `RegistroAuditoria` | `auditorias` | `Comp_FlotaPersonal` | Registro de evaluación de cumplimiento |
| **RF-050** | `CU-08` | `Ambulancia`, `RegistroAuditoria` | `ambulancias`, `auditorias` | `Comp_FlotaPersonal` | Control documental MIME/tamaño y metadatos |
| **RF-051** | `CU-08` | `RegistroAuditoria` | `auditorias` | `Comp_FlotaPersonal` | Control de duplicados e inmutabilidad oficial (`RN-013`) |
| **RF-052** | `CU-08` | `RegistroAuditoria` | `auditorias` | `Comp_FlotaPersonal` | Búsqueda filtrada y descarga controlada por auditoría |
| **RF-053** | `CU-08` / `CU-01` | `Rol`, `RegistroAuditoria` | `roles`, `auditorias` | `Comp_SeguridadAcceso` | RBAC sobre repositorio documental |
| **RF-054** | `CU-08` | `RegistroAuditoria` | `auditorias` | `Comp_FlotaPersonal` | Clasificación modular y reportes de repositorio |
| **RF-055** | `CU-06` | `RegistroAuditoria`, `FachadaEmergenciaSGA` | `auditorias`, `historial_estados_servicio` | `Comp_PersistenciaAuditoria` | Bitácora automática `INSERT/UPDATE/LOGIN/CIERRE` |
| **RF-056** | `CU-06` | `RegistroAuditoria` | `auditorias` | `Comp_PersistenciaAuditoria` | Append-only sin `UPDATE`/`DELETE` por 5 años (`RN-010`) |
| **RF-057** | `CU-06` | `RegistroAuditoria` | `auditorias` | `Comp_PersistenciaAuditoria` | Consulta `JSONB` `valores_anteriores` / `valores_nuevos` |
| **RF-058** | `CU-06` | `RegistroAuditoria` | `auditorias` | `Comp_PersistenciaAuditoria` | Detección y alerta de eventos anómalos de seguridad |
| **RF-059** | `CU-07` / `CU-05` | `NovedadOperativa`, `ServicioAsistencial` | `novedades`, `servicios` | `Comp_FlotaPersonal` | Registro tipificado de incidentes y fallas |
| **RF-060** | `CU-05` | `NovedadOperativa` | `novedades` | `Comp_FlotaPersonal` | Ciclo de vida `Pendiente -> Cerrado` (`CHECK ck_nov_cierre`, `RN-016`) |
| **RF-061** | `CU-07` | `NovedadOperativa` | `novedades` | `Comp_FlotaPersonal` | Resaltado crítico y alertas por superación de SLA |
| **RF-062** | `CU-05` | `NovedadOperativa` | `novedades` | `Comp_FlotaPersonal` | Seguimiento cronológico y consulta filtrada de novedades |
| **RF-063** | `CU-08` | `NovedadOperativa`, `Ambulancia` | `novedades`, `ambulancias` | `Comp_FlotaPersonal` | Reportes de incidentes correlacionados por ambulancia |
| **RF-064** | `CU-07` / `CU-11` | `ServicioAsistencial`, `Factura`, `PQRS` | `servicios`, `facturas`, `pqrs` | `Comp_PQRSeInformes` | Exportación programada PDF/Excel de solo lectura (`RN-018`) |
| **RF-065** | `CU-07` | `ServicioAsistencial`, `PQRS` | `servicios`, `pqrs` | `Comp_PQRSeInformes` | KPIs interactivos de oportunidad, uso TAB/TAM y PQRS |
| **RNF-001**..**RNF-004** | Transversal | `Usuario`, `Rol`, `Paciente` | `usuarios`, `roles`, `pacientes` | `Comp_SeguridadAcceso` | Hash `Argon2id/bcrypt` + sal, `TLS 1.3`, RBAC y Ley 1581 |
| **RNF-008**..**RNF-010** | Transversal | `FachadaEmergenciaSGA`, `AsignacionAutomaticaProximidad`, `Ambulancia` | `ambulancias`, `servicios` | `Comp_NucleoEmergencias` | Índices PostgreSQL + `Strategy` $\le 2\text{ s}$ y `WSS` $\ge 20$ usuarios |
| **RNF-013**, **RNF-028**, **RNF-029** | Transversal | `RegistroAuditoria` | `auditorias`, todas | `Comp_PersistenciaAuditoria` | Contenedores Docker 97 % 24/7 + respaldo diario 30 copias |

---

## 2. Verificación Inversa: Clases, Tablas y Componentes $\rightarrow$ Requisitos (Cero Huérfanos)

| Tipo de Elemento | Total en Modelo | Cobertura Verificada Hacia Atrás | ¿Algún Elemento sin Requisito? |
|---|---|---|---|
| **Clases e Interfaces de Diseño (`A2`)** | **18 / 18** (`Rol`, `Usuario`, `Paciente`, `SolicitudEmergencia`, `Ambulancia`, `AmbulanciaTAB`, `AmbulanciaTAM`, `PersonalSalud`, `ServicioAsistencial`, `HistorialEstado`, `Factura`, `RegistroAuditoria`, `PQRS`, `NovedadOperativa`, `IEstrategiaAsignacion`, `AsignacionAutomaticaProximidad`, `AsignacionManualContingencia`, `FachadaEmergenciaSGA`) | 100 % trazadas a `RF-001`..`RF-065` | **Ninguna (0 huérfanas)** |
| **Tablas Lógicas en 3FN (`B2`/`B5`)** | **16 / 16** (`sedes`, `roles`, `usuarios`, `personal`, `pacientes`, `paciente_telefonos`, `ambulancias`, `solicitudes_emergencia`, `servicios`, `personal_servicio`, `historial_estados_servicio`, `facturas`, `notas_credito_debito`, `pqrs`, `novedades`, `auditorias`) | 100 % trazadas a requisitos del SRS | **Ninguna (0 huérfanas)** |
| **Componentes (`A5`)** | **7 / 7** (`Comp_InterfazWebMovil`, `Comp_SeguridadAcceso`, `Comp_NucleoEmergencias`, `Comp_FlotaPersonal`, `Comp_FacturacionCartera`, `Comp_PQRSeInformes`, `Comp_PersistenciaAuditoria`) | 100 % trazados a grupos `RF` y `RNF` | **Ninguno (0 huérfanos)** |
