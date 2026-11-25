# Matriz de Trazabilidad Requisito → Artefactos de Análisis
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592373 (Criterio C8) — Matriz de trazabilidad con 90 % o más de los requisitos funcionales trazados  
**Formato Oficial:** Anexo C (`Rubricas_G1.md` y `Plantilla_README_Entrega_G1.md`)  
**Aprendiz Autor:** Miguel Ángel Estrada Torrentes (`estrada`)  
**Ficha:** 3413974 · ADSO · Centro de la Industria, la Empresa y los Servicios (CIES)  
**Tasa de Cobertura Alcanzada:** 100 % (65 de 65 Requisitos Funcionales trazados)  

---

## 1. Convenciones y Alcance de Trazabilidad

- **Requisito:** Identificador del requisito funcional según el SRS del Sistema Gestor de Ambulancias (RF-01 a RF-65).
- **Caso de uso:** Caso de uso que implementa el objetivo del requisito.
- **Diagrama de actividades:** Referencia al diagrama de flujo de actividades (`DA-CU03`, `DA-CU05` o `DA-General`).
- **Plantilla:** Identificador de la plantilla extendida de caso de uso (`PL-CU03`, `PL-CU04`, `PL-CU05` o `PL-Estándar`).
- **Clase de dominio:** Clase abstracta de negocio en el Modelo de Dominio (`03-modelo-dominio.svg`).
- **Entidad del MER:** Tabla/entidad lógica en el Modelo Entidad-Relación (`04-modelo-entidad-relacion.svg`).
- **Pantalla:** Prototipo de interfaz de usuario (`P-01`, `P-02`, `P-03` para casos críticos; `P-Admin` o `P-Móvil` para soporte).

---

## 2. Matriz de Trazabilidad Integral (Anexo C)

| Requisito | Caso de uso | Diagrama de actividades | Plantilla | Clase de dominio | Entidad del MER | Pantalla |
|---|---|---|---|---|---|---|
| **RF-01** | CU-06 Autenticar usuario y verificar rol | DA-General | PL-Estándar | Usuario | USUARIO | P-Admin |
| **RF-02** | CU-06 Autenticar usuario y verificar rol | DA-General | PL-Estándar | Rol | ROL | P-Admin |
| **RF-03** | CU-06 Autenticar usuario y verificar rol | DA-General | PL-Estándar | RegistroAuditoria | HISTORIAL_ESTADOS_SERVICIO | P-Admin |
| **RF-04** | CU-01 Registrar solicitud de emergencia | DA-CU03 | PL-Estándar | SolicitudEmergencia | SOLICITUD_EMERGENCIA | P-01 |
| **RF-05** | CU-01 Registrar solicitud de emergencia | DA-CU03 | PL-Estándar | Paciente | PACIENTE | P-01 |
| **RF-06** | CU-02 Categorizar severidad de triage | DA-CU03 | PL-Estándar | SolicitudEmergencia | SOLICITUD_EMERGENCIA | P-01 |
| **RF-07** | CU-01 Registrar solicitud de emergencia | DA-CU03 | PL-Estándar | SolicitudEmergencia | SOLICITUD_EMERGENCIA | P-01 |
| **RF-08** | CU-01 Registrar solicitud de emergencia | DA-CU03 | PL-Estándar | Paciente | PACIENTE | P-01 |
| **RF-09** | CU-02 Categorizar severidad de triage | DA-CU03 | PL-Estándar | SolicitudEmergencia | SOLICITUD_EMERGENCIA | P-01 |
| **RF-10** | CU-03 Despachar ambulancia automáticamente | DA-CU03 | PL-CU03 | ServicioAsistencial | SERVICIO_ASISTENCIAL | P-01 |
| **RF-11** | CU-03 Despachar ambulancia automáticamente | DA-CU03 | PL-CU03 | Ambulancia (TAB / TAM) | AMBULANCIA | P-01 |
| **RF-12** | CU-03 Despachar ambulancia automáticamente | DA-CU03 | PL-CU03 | PersonalSalud | PERSONAL_SERVICIO | P-01 |
| **RF-13** | CU-03 Despachar ambulancia automáticamente | DA-CU03 | PL-CU03 | Ambulancia | AMBULANCIA | P-01 |
| **RF-14** | CU-04 Reasignar ambulancia manualmente | DA-CU03 | PL-CU04 | ServicioAsistencial | SERVICIO_ASISTENCIAL | P-02 |
| **RF-15** | CU-04 Reasignar ambulancia manualmente | DA-CU03 | PL-CU04 | RegistroAuditoria | HISTORIAL_ESTADOS_SERVICIO | P-02 |
| **RF-16** | CU-05 Cerrar servicio asistencial y liquidar | DA-CU05 | PL-CU05 | ServicioAsistencial | SERVICIO_ASISTENCIAL | P-03 |
| **RF-17** | CU-07 Monitorear telemetría y GPS | DA-CU03 | PL-Estándar | Ambulancia | AMBULANCIA | P-01 |
| **RF-18** | CU-07 Monitorear telemetría y GPS | DA-CU03 | PL-Estándar | Ambulancia | AMBULANCIA | P-01 |
| **RF-19** | CU-07 Monitorear telemetría y GPS | DA-CU03 | PL-Estándar | ServicioAsistencial | SERVICIO_ASISTENCIAL | P-01 |
| **RF-20** | CU-07 Monitorear telemetría y GPS | DA-CU03 | PL-Estándar | NovedadOperativa | HISTORIAL_ESTADOS_SERVICIO | P-01 |
| **RF-21** | CU-05 Cerrar servicio asistencial y liquidar | DA-CU05 | PL-CU05 | ServicioAsistencial | VALORACION_CLINICA | P-03 |
| **RF-22** | CU-08 Diligenciar historia clínica prehospitalaria | DA-CU05 | PL-CU05 | Paciente | VALORACION_CLINICA | P-03 |
| **RF-23** | CU-08 Diligenciar historia clínica prehospitalaria | DA-CU05 | PL-CU05 | PersonalSalud | VALORACION_CLINICA | P-03 |
| **RF-24** | CU-08 Diligenciar historia clínica prehospitalaria | DA-CU05 | PL-CU05 | ServicioAsistencial | VALORACION_CLINICA | P-03 |
| **RF-25** | CU-08 Diligenciar historia clínica prehospitalaria | DA-CU05 | PL-CU05 | ServicioAsistencial | VALORACION_CLINICA | P-03 |
| **RF-26** | CU-08 Diligenciar historia clínica prehospitalaria | DA-CU05 | PL-CU05 | ServicioAsistencial | VALORACION_CLINICA | P-03 |
| **RF-27** | CU-05 Cerrar servicio asistencial y liquidar | DA-CU05 | PL-CU05 | ServicioAsistencial | SERVICIO_ASISTENCIAL | P-03 |
| **RF-28** | CU-05 Cerrar servicio asistencial y liquidar | DA-CU05 | PL-CU05 | PersonalSalud | PERSONAL_SERVICIO | P-03 |
| **RF-29** | CU-09 Gestionar tarifas y convenios EPS | DA-General | PL-Estándar | Factura | FACTURACION | P-Admin |
| **RF-30** | CU-05 Cerrar servicio asistencial y liquidar | DA-CU05 | PL-CU05 | Factura | FACTURACION | P-03 |
| **RF-31** | CU-05 Cerrar servicio asistencial y liquidar | DA-CU05 | PL-CU05 | Factura | FACTURACION | P-03 |
| **RF-32** | CU-10 Generar factura electrónica de salud | DA-General | PL-Estándar | Factura | FACTURACION | P-Admin |
| **RF-33** | CU-10 Generar factura electrónica de salud | DA-General | PL-Estándar | Factura | FACTURACION | P-Admin |
| **RF-34** | CU-10 Generar factura electrónica de salud | DA-General | PL-Estándar | Factura | FACTURACION | P-Admin |
| **RF-35** | CU-11 Registrar recaudo de copago en sitio | DA-CU05 | PL-CU05 | Factura | FACTURACION | P-03 |
| **RF-36** | CU-11 Registrar recaudo de copago en sitio | DA-CU05 | PL-CU05 | Factura | FACTURACION | P-03 |
| **RF-37** | CU-12 Conciliar pagos de aseguradoras SOAT | DA-General | PL-Estándar | Factura | FACTURACION | P-Admin |
| **RF-38** | CU-12 Conciliar pagos de aseguradoras SOAT | DA-General | PL-Estándar | Factura | FACTURACION | P-Admin |
| **RF-39** | CU-13 Registrar hoja de vida de ambulancia | DA-General | PL-Estándar | Ambulancia | AMBULANCIA | P-Admin |
| **RF-40** | CU-13 Registrar hoja de vida de ambulancia | DA-General | PL-Estándar | Ambulancia (TAB / TAM) | AMBULANCIA | P-Admin |
| **RF-41** | CU-14 Controlar vencimiento de documentos SOAT/TM | DA-General | PL-Estándar | Ambulancia | AMBULANCIA | P-Admin |
| **RF-42** | CU-14 Controlar vencimiento de documentos SOAT/TM | DA-General | PL-Estándar | Ambulancia | AMBULANCIA | P-Admin |
| **RF-43** | CU-15 Programar mantenimiento preventivo flota | DA-General | PL-Estándar | Ambulancia | AMBULANCIA | P-Admin |
| **RF-44** | CU-03 Despachar ambulancia automáticamente | DA-CU03 | PL-CU03 | Ambulancia | AMBULANCIA | P-01 |
| **RF-45** | CU-16 Gestionar personal asistencial y ReTHUS | DA-General | PL-Estándar | PersonalSalud | PERSONAL_MEDICO | P-Admin |
| **RF-46** | CU-16 Gestionar personal asistencial y ReTHUS | DA-General | PL-Estándar | PersonalSalud | PERSONAL_MEDICO | P-Admin |
| **RF-47** | CU-17 Programar turnos y guardias operativas | DA-General | PL-Estándar | PersonalSalud | PERSONAL_SERVICIO | P-Admin |
| **RF-48** | CU-17 Programar turnos y guardias operativas | DA-General | PL-Estándar | PersonalSalud | PERSONAL_SERVICIO | P-Admin |
| **RF-49** | CU-18 Auditar transiciones de estado de servicio | DA-CU03 | PL-CU04 | RegistroAuditoria | HISTORIAL_ESTADOS_SERVICIO | P-02 |
| **RF-50** | CU-18 Auditar transiciones de estado de servicio | DA-CU05 | PL-CU05 | RegistroAuditoria | HISTORIAL_ESTADOS_SERVICIO | P-03 |
| **RF-51** | CU-19 Consultar pistas de auditoría forense | DA-General | PL-Estándar | RegistroAuditoria | HISTORIAL_ESTADOS_SERVICIO | P-Admin |
| **RF-52** | CU-19 Consultar pistas de auditoría forense | DA-General | PL-Estándar | RegistroAuditoria | HISTORIAL_ESTADOS_SERVICIO | P-Admin |
| **RF-53** | CU-20 Registrar novedad operativa de servicio | DA-CU03 | PL-CU04 | NovedadOperativa | HISTORIAL_ESTADOS_SERVICIO | P-02 |
| **RF-54** | CU-20 Registrar novedad operativa de servicio | DA-CU03 | PL-CU04 | NovedadOperativa | HISTORIAL_ESTADOS_SERVICIO | P-02 |
| **RF-55** | CU-21 Radicar PQRS de usuario o entidad | DA-General | PL-Estándar | PQRS | PQRS | P-Admin |
| **RF-56** | CU-21 Radicar PQRS de usuario o entidad | DA-General | PL-Estándar | PQRS | PQRS | P-Admin |
| **RF-57** | CU-22 Tramitar y responder PQRS institucional | DA-General | PL-Estándar | PQRS | PQRS | P-Admin |
| **RF-58** | CU-22 Tramitar y responder PQRS institucional | DA-General | PL-Estándar | PQRS | PQRS | P-Admin |
| **RF-59** | CU-23 Generar indicador de tiempos de respuesta | DA-CU03 | PL-CU03 | ServicioAsistencial | SERVICIO_ASISTENCIAL | P-01 |
| **RF-60** | CU-23 Generar indicador de tiempos de respuesta | DA-CU05 | PL-CU05 | ServicioAsistencial | SERVICIO_ASISTENCIAL | P-03 |
| **RF-61** | CU-24 Reportar incidentes a central CRUE Huila | DA-CU03 | PL-CU03 | SolicitudEmergencia | SOLICITUD_EMERGENCIA | P-01 |
| **RF-62** | CU-24 Reportar incidentes a central CRUE Huila | DA-CU03 | PL-CU03 | ServicioAsistencial | SERVICIO_ASISTENCIAL | P-01 |
| **RF-63** | CU-25 Gestionar inventario de insumos médicos | DA-CU05 | PL-CU05 | Ambulancia (TAB / TAM) | AMBULANCIA | P-03 |
| **RF-64** | CU-25 Gestionar inventario de insumos médicos | DA-CU05 | PL-CU05 | Ambulancia | AMBULANCIA | P-03 |
| **RF-65** | CU-06 Autenticar usuario y verificar rol | DA-General | PL-Estándar | Usuario | USUARIO | P-Admin |

---

## 3. Resumen Estadístico de Cobertura

- **Total Requisitos Funcionales analizados:** 65
- **Requisitos con caso de uso asignado:** 65 (100 %)
- **Requisitos trazados a clase de dominio conceptual:** 65 (100 %)
- **Requisitos trazados a entidad del MER relacional:** 65 (100 %)
- **Requisitos trazados a interfaz gráfica / prototipo:** 65 (100 %)
- **Resultado:** **Conformidad Plena (100 %)**, superando el estándar mínimo del 90 % exigido por la Rúbrica SENA (Criterio C8).
