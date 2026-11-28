# Matriz de Trazabilidad Requisito → Artefactos de Análisis
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592373 (Criterio C8) — Matriz de trazabilidad con 90 % o más de los requisitos funcionales trazados  
**Formato Oficial:** Anexo C (`Rubricas_G1.md` y `Plantilla_README_Entrega_G1.md`)  
**Aprendiz Autor:** `MAET211` (Carpeta: `G1-P2-estrada`)  
**Ficha:** 3413974 · ADSO · Centro de la Industria, la Empresa y los Servicios (CIES)  
**Tasa de Cobertura Alcanzada:** 100 % (65 de 65 Requisitos Funcionales trazados)  

---

## 1. Convenciones y Alcance de Trazabilidad

Esta matriz integra al 100 % los requisitos funcionales reales del proyecto **SGA** (`RF-001` a `RF-065`) utilizando exclusivamente los identificadores verificables en los demás artefactos de la entrega:
- **Requisito (`SRS`):** Identificador oficial del requisito funcional en los 15 módulos del SRS (`RF-001` a `RF-065`).
- **Caso de uso (`G1-P1/04`):** Identificador perteneciente estrictamente al catálogo de 12 casos de uso (`CU-01`, `CU-01.1`, `CU-02`, `CU-03`, `CU-04`, `CU-05`, `CU-06`, `CU-07`, `CU-08`, `CU-09`, `CU-10`, `CU-11`) definidos en [`04-matriz-requisito-caso-uso.md`](../G1-P1-estrada/04-matriz-requisito-caso-uso.md).
- **Diagrama de actividades (`01-diagramas-actividades.svg`):** Referencia a los dos flujos críticos modelados en G1-P2: `DA-01 (CU-03 / CU-02)` y `DA-02 (CU-05 / CU-11 / CU-06)`; los módulos netamente administrativos/soporte se señalan como `N/A (Soporte operativo — G1-P1)`.
- **Plantilla:** Plantilla extendida Anexo A en [`02-plantillas-casos-de-uso.md`](./02-plantillas-casos-de-uso.md) para los 3 casos críticos (`CU-03`, `CU-04`, `CU-05`), o especificación base en [`05-especificacion-casos-de-uso.md`](../G1-P1-estrada/05-especificacion-casos-de-uso.md) (`Catálogo Base (G1-P1/05)`).
- **Clase de dominio (`03-modelo-dominio.svg`):** Exclusivamente entre las **13 clases conceptuales**: `Rol`, `Usuario`, `RegistroAuditoria`, `Ambulancia`, `TAB (Básica)`, `TAM (Medicalizada)`, `PersonalSalud`, `Paciente`, `SolicitudEmergencia`, `ServicioAsistencial`, `Factura`, `PQRS`, `NovedadOperativa`.
- **Entidad del MER (`04-modelo-entidad-relacion.svg`):** Exclusivamente entre las **13 entidades relacionales**: `ROL`, `USUARIO`, `AUDITORIA`, `PERSONAL`, `PACIENTE`, `PQRS`, `AMBULANCIA`, `SOLICITUD_EMERGENCIA`, `SERVICIO`, `PERSONAL_SERVICIO`, `HISTORIAL_ESTADOS_SERVICIO`, `FACTURA`, `NOVEDAD`. *(Las variables clínicas de cierre residen en `SERVICIO`; los submódulos administrativos auxiliares se trazan conceptualmente hacia las entidades troncales `AUDITORIA`, `AMBULANCIA`, `FACTURA` o `USUARIO`).*
- **Pantalla (`05-prototipo-mockups.md`):** Pantallas críticas `P-01 (CU-03)`, `P-02 (CU-04)`, `P-03 (CU-05)` y `N/A (Caso de soporte)` para flujos fuera del prototipo inicial de 3 pantallas exigido por `Rubricas_G1.md`.

---

## 2. Matriz de Trazabilidad Integral (Anexo C)

| Requisito | Caso de uso | Diagrama de actividades | Plantilla | Clase de dominio | Entidad del MER | Pantalla |
|---|---|---|---|---|---|---|
| **RF-001** | `CU-01` Autenticar usuario y emitir token JWT | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Usuario` | `USUARIO` | N/A (Caso de soporte) |
| **RF-002** | `CU-01` Autenticar usuario y emitir token JWT | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Usuario` | `USUARIO` | N/A (Caso de soporte) |
| **RF-003** | `CU-01` Autenticar usuario y emitir token JWT | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Usuario` | `USUARIO` | N/A (Caso de soporte) |
| **RF-004** | `CU-01` Autenticar usuario y emitir token JWT | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Usuario` | `USUARIO` | N/A (Caso de soporte) |
| **RF-005** | `CU-01` Autenticar usuario y emitir token JWT | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Rol` | `ROL` | N/A (Caso de soporte) |
| **RF-006** | `CU-01` Autenticar usuario / `CU-06` Auditar | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Rol` | `ROL` | N/A (Caso de soporte) |
| **RF-007** | `CU-01.1` Bloquear cuenta por intentos fallidos | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Usuario` | `USUARIO` | N/A (Caso de soporte) |
| **RF-008** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-009** | `CU-07` Monitorear flota y estados en tiempo real | `DA-01 (CU-03 / CU-02)` | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | `P-01 (CU-03)` |
| **RF-010** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-011** | `CU-09` Validar habilitación REPS y vencimientos | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `Ambulancia` | `AMBULANCIA` | `P-01 (CU-03)` |
| **RF-012** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-013** | `CU-08` Gestionar / `CU-09` Validar REPS | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `TAB (Básica)` / `TAM (Medicalizada)` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-014** | `CU-03` Asignar ambulancia (con `CU-01`) | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `PersonalSalud` | `PERSONAL` | `P-01 (CU-03)` |
| **RF-015** | `CU-03` Asignar ambulancia / `CU-07` Monitorear | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `PersonalSalud` | `PERSONAL` | `P-01 (CU-03)` |
| **RF-016** | `CU-03` Asignar ambulancia automáticamente | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `PersonalSalud` | `PERSONAL` | `P-01 (CU-03)` |
| **RF-017** | `CU-05` Realizar cierre formal de servicio | `DA-02 (CU-05 / CU-11 / CU-06)` | Anexo A · CU-05 (02-plantillas) | `PersonalSalud` | `PERSONAL_SERVICIO` | `P-03 (CU-05)` |
| **RF-018** | `CU-02` Radicar solicitud de emergencia | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `Paciente` | `PACIENTE` | `P-01 (CU-03)` |
| **RF-019** | `CU-02` Radicar solicitud de emergencia | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `Paciente` | `PACIENTE` | `P-01 (CU-03)` |
| **RF-020** | `CU-02` Radicar solicitud de emergencia | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Paciente` | `PACIENTE` | N/A (Caso de soporte) |
| **RF-021** | `CU-02` Radicar solicitud de emergencia | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `SolicitudEmergencia` | `SOLICITUD_EMERGENCIA` | `P-01 (CU-03)` |
| **RF-022** | `CU-03` Asignar ambulancia automáticamente | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `ServicioAsistencial` | `SERVICIO` | `P-01 (CU-03)` |
| **RF-023** | `CU-04` Asignar ambulancia con justificación manual | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-04 (02-plantillas) | `ServicioAsistencial` | `SERVICIO` | `P-02 (CU-04)` |
| **RF-024** | `CU-05` Realizar cierre formal de servicio | `DA-02 (CU-05 / CU-11 / CU-06)` | Anexo A · CU-05 (02-plantillas) | `ServicioAsistencial` | `HISTORIAL_ESTADOS_SERVICIO` | `P-03 (CU-05)` |
| **RF-025** | `CU-05` Realizar cierre formal de servicio | `DA-02 (CU-05 / CU-11 / CU-06)` | Anexo A · CU-05 (02-plantillas) | `ServicioAsistencial` | `SERVICIO` | `P-03 (CU-05)` |
| **RF-026** | `CU-05` Cierre / `CU-06` Auditar evento | `DA-02 (CU-05 / CU-11 / CU-06)` | Anexo A · CU-05 (02-plantillas) | `ServicioAsistencial` | `HISTORIAL_ESTADOS_SERVICIO` | `P-03 (CU-05)` |
| **RF-027** | `CU-05` Realizar cierre formal de servicio | `DA-02 (CU-05 / CU-11 / CU-06)` | Catálogo Base (G1-P1/05) | `ServicioAsistencial` | `SERVICIO` | N/A (Caso de soporte) |
| **RF-028** | `CU-07` Monitorear flota y estados en tiempo real | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `Ambulancia` (`TAB (Básica)` / `TAM (Medicalizada)`) | `AMBULANCIA` | `P-01 (CU-03)` |
| **RF-029** | `CU-07` Monitorear flota y estados en tiempo real | `DA-01 (CU-03 / CU-02)` | Anexo A · CU-03 (02-plantillas) | `ServicioAsistencial` | `SERVICIO` | `P-01 (CU-03)` |
| **RF-030** | `CU-11` Generar factura inmutable de servicio | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Factura` | `FACTURA` | N/A (Caso de soporte) |
| **RF-031** | `CU-11` Generar factura (incluido en `CU-05`) | `DA-02 (CU-05 / CU-11 / CU-06)` | Anexo A · CU-05 (02-plantillas) | `Factura` | `FACTURA` | `P-03 (CU-05)` |
| **RF-032** | `CU-11` Generar factura inmutable de servicio | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Factura` | `FACTURA` | N/A (Caso de soporte) |
| **RF-033** | `CU-11` Generar factura inmutable de servicio | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Factura` | `FACTURA` | N/A (Caso de soporte) |
| **RF-034** | `CU-11` Generar factura inmutable de servicio | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Factura` | `FACTURA` | N/A (Caso de soporte) |
| **RF-035** | `CU-11` Generar factura inmutable de servicio | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Factura` | `FACTURA` | N/A (Caso de soporte) |
| **RF-036** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `RegistroAuditoria` | `AUDITORIA` | N/A (Caso de soporte) |
| **RF-037** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `RegistroAuditoria` | `AUDITORIA` | N/A (Caso de soporte) |
| **RF-038** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Usuario` | `USUARIO` | N/A (Caso de soporte) |
| **RF-039** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `RegistroAuditoria` | `AUDITORIA` | N/A (Caso de soporte) |
| **RF-040** | `CU-10` Radicar y consultar solicitudes PQRS | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `PQRS` | `PQRS` | N/A (Caso de soporte) |
| **RF-041** | `CU-10` Radicar y consultar solicitudes PQRS | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `PQRS` | `PQRS` | N/A (Caso de soporte) |
| **RF-042** | `CU-10` Radicar y consultar solicitudes PQRS | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `PQRS` | `PQRS` | N/A (Caso de soporte) |
| **RF-043** | `CU-10` Radicar y consultar solicitudes PQRS | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `PQRS` | `PQRS` | N/A (Caso de soporte) |
| **RF-044** | `CU-10` Radicar y consultar solicitudes PQRS | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `PQRS` | `PQRS` | N/A (Caso de soporte) |
| **RF-045** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-046** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-047** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-048** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-049** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `RegistroAuditoria` | `AUDITORIA` | N/A (Caso de soporte) |
| **RF-050** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Ambulancia` | `AMBULANCIA` | N/A (Caso de soporte) |
| **RF-051** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `RegistroAuditoria` | `AUDITORIA` | N/A (Caso de soporte) |
| **RF-052** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `RegistroAuditoria` | `AUDITORIA` | N/A (Caso de soporte) |
| **RF-053** | `CU-08` Gestionar / `CU-01` Autenticar (RBAC) | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `Rol` | `ROL` | N/A (Caso de soporte) |
| **RF-054** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `RegistroAuditoria` | `AUDITORIA` | N/A (Caso de soporte) |
| **RF-055** | `CU-06` Auditar evento transaccional inmutable | `DA-02 (CU-05 / CU-11 / CU-06)` | Anexo A · CU-05 (02-plantillas) | `RegistroAuditoria` | `AUDITORIA` | `P-02 (CU-04)` / `P-03 (CU-05)` |
| **RF-056** | `CU-06` Auditar evento transaccional inmutable | `DA-02 (CU-05 / CU-11 / CU-06)` | Anexo A · CU-05 (02-plantillas) | `RegistroAuditoria` | `AUDITORIA` | `P-03 (CU-05)` |
| **RF-057** | `CU-06` Auditar evento transaccional inmutable | N/A (Soporte operativo — G1-P1) | Anexo A · CU-04 (02-plantillas) | `RegistroAuditoria` | `AUDITORIA` | `P-02 (CU-04)` |
| **RF-058** | `CU-06` Auditar evento transaccional inmutable | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `RegistroAuditoria` | `AUDITORIA` | N/A (Caso de soporte) |
| **RF-059** | `CU-07` Monitorear / `CU-05` Cerrar servicio | `DA-01 (CU-03 / CU-02)` | Catálogo Base (G1-P1/05) | `NovedadOperativa` | `NOVEDAD` | `P-01 (CU-03)` |
| **RF-060** | `CU-05` Realizar cierre formal de servicio | `DA-02 (CU-05 / CU-11 / CU-06)` | Anexo A · CU-05 (02-plantillas) | `NovedadOperativa` | `NOVEDAD` | `P-03 (CU-05)` |
| **RF-061** | `CU-07` Monitorear flota y estados en tiempo real | `DA-01 (CU-03 / CU-02)` | Catálogo Base (G1-P1/05) | `NovedadOperativa` | `NOVEDAD` | `P-01 (CU-03)` |
| **RF-062** | `CU-05` Realizar cierre formal de servicio | `DA-02 (CU-05 / CU-11 / CU-06)` | Catálogo Base (G1-P1/05) | `NovedadOperativa` | `NOVEDAD` | N/A (Caso de soporte) |
| **RF-063** | `CU-08` Gestionar inventario de ambulancias | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `NovedadOperativa` | `NOVEDAD` | N/A (Caso de soporte) |
| **RF-064** | `CU-07` Monitorear / `CU-11` Facturar | N/A (Soporte operativo — G1-P1) | Catálogo Base (G1-P1/05) | `ServicioAsistencial` / `Factura` | `SERVICIO` | N/A (Caso de soporte) |
| **RF-065** | `CU-07` Monitorear flota y estados en tiempo real | `DA-01 (CU-03 / CU-02)` | Catálogo Base (G1-P1/05) | `ServicioAsistencial` | `SERVICIO` | `P-01 (CU-03)` |

---

## 3. Resumen Estadístico de Cobertura

- **Total Requisitos Funcionales analizados (SRS oficial):** 65 (`RF-001` a `RF-065`).
- **Requisitos trazados al catálogo de Casos de Uso (`CU-01` a `CU-11`):** 65 / 65 (100 %).
- **Requisitos trazados a Clases Conceptuales del Modelo de Dominio (13 clases):** 65 / 65 (100 %).
- **Requisitos trazados a Entidades del MER Relacional (13 entidades):** 65 / 65 (100 %).
- **Requisitos críticos cubiertos en Diagramas de Actividades (`DA-01` y `DA-02`), Plantillas Anexo A y Mockups (`P-01` a `P-03`):** 23 / 23 requisitos de flujo crítico operacional (100 %), con especificación complementaria en `G1-P1/05` para los requisitos administrativos de soporte.
- **Resultado:** **Conformidad Plena (100 %)**, superando el umbral mínimo del 90 % fijado por la Rúbrica SENA (Criterio C8).
