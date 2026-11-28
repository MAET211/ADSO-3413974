# Lista de Chequeo para Validación de la Documentación de Análisis
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592374 (Criterio C6) — Elabora listas de chequeo para validación de la documentación de análisis y las aplica  
**Formato Oficial:** Anexo B (`Rubricas_G1.md` y `Plantilla_README_Entrega_G1.md`)  
**Aprendiz Evaluador:** `MAET211` (Carpeta: `G1-P2-estrada`)  
**Proyecto:** Sistema Gestor de Ambulancias (SGA) · Ficha 3413974  
**Fechas de Aplicación:** 25 de noviembre de 2026 (Evaluación inicial) y 27 de noviembre de 2026 (Re-verificación final)  

---

## 1. Metodología de Validación

Para garantizar el cumplimiento de los estándares de calidad del SENA y las normas de arbitraje de la Guía 1 (Sección 7), se estructuró una lista de verificación con **16 criterios objetivos y verificables** (evaluados mediante respuesta dicotómica: Sí / No). Se formularon específicamente **4 criterios de cobertura y trazabilidad integral** para asegurar que ningún requisito del negocio quede huérfano.

Las desviaciones detectadas durante las rondas de auditoría fueron registradas como hallazgos en el *Registro de Ajustes* (`07-registro-de-ajustes.md`) para su inmediata subsanación técnica y segunda verificación exitosa.

---

## 2. Matriz de Verificación Diligenciada (Anexo B)

| # | Criterio verificable (responde sí o no) | Artefacto | ¿Cumple? | Evidencia (enlace o cita) | Hallazgo / Estado |
|---|---|---|:---:|---|---|
| **1** | **[Cobertura]** ¿El 100 % de los requisitos funcionales del SRS (`RF-001` al `RF-065`) están mapeados en al menos un caso de uso sin omisiones? | Matriz Requisito-CU | **Sí** | [`04-matriz-requisito-caso-uso.md#L76-L142`](../G1-P1-estrada/04-matriz-requisito-caso-uso.md#L76-L142) (`65/65` RFs cubiertos en `CU-01` a `CU-11`) | Cumplimiento total. Corregida referencia exacta de líneas e IDs reales del SRS. |
| **2** | **[Trazabilidad]** ¿Todos los conceptos de negocio utilizados en las plantillas de casos de uso existen como clases en el modelo de dominio? | Plantillas y Modelo de Dominio | **Sí** | `02-plantillas-casos-de-uso.md` vs `03-modelo-dominio.svg` (`Paciente`, `Ambulancia`, `ServicioAsistencial`, `SolicitudEmergencia`, `PersonalSalud`, `Factura`, `RegistroAuditoria`) | Homologado integralmente con las 13 clases del dominio conceptual. |
| **3** | **[Trazabilidad]** ¿Cada rama de decisión alterna o de excepción del diagrama de actividades aparece descrita en la plantilla del mismo caso de uso? | Actividades y Plantillas | **Sí** | `01-diagramas-actividades.svg` (`[Sin unidades o REPS vencido]` y `[Datos incompletos (Bloqueo RN-005)]`) vs `02-plantillas-casos-de-uso.md` (Flujo Alterno `6a`, Excepciones `6b`/`5a`) | Coherencia 1:1 entre flujos gráficos (`DA-01`, `DA-02`), concurrencia Fork/Join y plantillas Anexo A. |
| **4** | **[Cobertura]** ¿Al menos el 90 % de los requisitos funcionales están trazados hasta clase de dominio y entidad del MER en la matriz Anexo C? | Matriz de Trazabilidad | **Sí** | [`09-matriz-trazabilidad-anexo-c.md`](./09-matriz-trazabilidad-anexo-c.md) (`65/65` RFs trazados = `100 %` sin clases ni entidades fantasma) | Supera el umbral del 90 % y unifica nomenclatura entre P1 y P2. |
| **5** | ¿Los diagramas de casos de uso ubican la frontera del sistema con los actores estrictamente por fuera de ella y sin cruces visuales? | Casos de Uso | **Sí** | [`03-diagrama-casos-de-uso.svg`](../G1-P1-estrada/03-diagrama-casos-de-uso.svg) (Contenedor frontera SGA y 5 actores externos; auditoría automática: `0` cruces) | Cumple Regla de Arbitraje 6 y legibilidad ortogonal sin cruces. |
| **6** | ¿Las relaciones `<<include>>` se reservan para flujos obligatorios y apuntan del caso base al caso incluido? | Casos de Uso | **Sí** | `03-diagrama-casos-de-uso.svg` (`CU-02 <<include>> CU-03`, `CU-05 <<include>> CU-11` y `CU-06`, `CU-08 <<include>> CU-09`) | Dirección validada: caso base $\rightarrow$ caso incluido, respaldada por tabla de justificación en P1. |
| **7** | ¿Las relaciones `<<extend>>` se emplean exclusivamente para extensiones opcionales/condicionales y apuntan del caso que extiende hacia el caso base? | Casos de Uso | **Sí** | `03-diagrama-casos-de-uso.svg` (`CU-04 <<extend>> CU-03` y `CU-01.1 <<extend>> CU-01`) | Flecha validada: caso extensor $\rightarrow$ caso base (Regla de Arbitraje 2). |
| **8** | ¿Las operaciones CRUD están agrupadas por objetivo de negocio y no fragmentadas en casos de uso técnicos individuales? | Casos de Uso | **Sí** | `04-matriz-requisito-caso-uso.md` (`CU-08 · Gestionar inventario de ambulancias` y `CU-01 · Autenticar usuario`) | Cumple Regla de Arbitraje 1: consolidación por objetivo de negocio sin CRUDs técnicos aislados. |
| **9** | ¿Las precondiciones en las plantillas detallan únicamente estados previos verificados antes de iniciar el caso y no comprobaciones intermedias? | Plantillas de CU | **Sí** | `02-plantillas-casos-de-uso.md` (sesión activa, flota registrada o servicio en traslado previo al cierre) | Cumple Regla de Arbitraje 3. Validaciones REPS/RN-005 movidas a flujos alternos/excepciones. |
| **10** | ¿Las plantillas de casos de uso extendidas están completamente libres de detalles de implementación (sin SQL, sin tablas físicas, sin endpoints)? | Plantillas de CU | **Sí** | `02-plantillas-casos-de-uso.md` (Redacción centrada en intención de actor y respuesta del sistema) | Cumple Regla de Arbitraje 10 sin jerga técnica de implementación. |
| **11** | ¿El modelo de dominio cuenta con al menos 8 clases conceptuales con multiplicidades en ambos extremos y sin métodos definidos? | Modelo de Dominio | **Sí** | `03-modelo-dominio.svg` y `.drawio` (**13 clases conceptuales**: `Rol`, `Usuario`, `RegistroAuditoria`, `Paciente`, `SolicitudEmergencia`, `ServicioAsistencial`, `Ambulancia`, `TAB`, `TAM`, `PersonalSalud`, `Factura`, `PQRS`, `NovedadOperativa`) | Concepto puro sin métodos, FKs ni tipos SQL (`Booleano (Si/No)`), con `0` cruces de conectores. |
| **12** | ¿El modelo de dominio incluye al menos una generalización o clase de asociación justificada en el negocio? | Modelo de Dominio | **Sí** | `03-modelo-dominio.svg` (Generalización `Ambulancia` $\rightarrow$ `TAB (Básica)` y `TAM (Medicalizada)`) | Herencia validada conforme al REPS Resolución 3100, con despeje geométrico limpio. |
| **13** | ¿El MER declara su notación formal y contiene al menos 6 entidades con sus identificadores de clave primaria (`<<PK>>`) rotulados? | Modelo ER | **Sí** | `04-modelo-entidad-relacion.svg` y `.drawio` (**13 entidades relacionales** con `<<PK>>` y notación Crow's Foot declarada) | Incluye `ROL`, `USUARIO`, `AUDITORIA`, `PERSONAL`, `PACIENTE`, `PQRS`, `AMBULANCIA`, `SOLICITUD_EMERGENCIA`, `SERVICIO`, `PERSONAL_SERVICIO`, `HISTORIAL_ESTADOS_SERVICIO`, `FACTURA`, `NOVEDAD`; `0` cruces. |
| **14** | ¿El MER resuelve toda relación de muchos a muchos (N:M) mediante una entidad asociativa que contenga atributos propios de negocio? | Modelo ER | **Sí** | `04-modelo-entidad-relacion.svg` (`PERSONAL_SERVICIO` entre `PERSONAL` y `SERVICIO`, con `rol_operativo`, `hora_asignacion`, `hora_liberacion`) | Cumple Regla de Arbitraje 5 y norma de modelado relacional. |
| **15** | ¿El MER modela al menos una entidad débil o relación recursiva identificando la dependencia existencial? | Modelo ER | **Sí** | `04-modelo-entidad-relacion.svg` y `.drawio` (`HISTORIAL_ESTADOS_SERVICIO` débil respecto a `SERVICIO`, con PK compuesta `<<PK, FK>> servicio_id` + `<<PK>> numero_secuencia`) | Dependencia existencial estricta y clave compuesta verificadas. |
| **16** | ¿Todas las pantallas del prototipo inicial están formalmente rotuladas con el caso de uso que atienden, sin pantallas huérfanas y anonimizadas? | Prototipo Mockups | **Sí** | [`05-prototipo-mockups.md`](./05-prototipo-mockups.md) (`P-01` $\rightarrow$ `CU-03`, `P-02` $\rightarrow$ `CU-04`, `P-03` $\rightarrow$ `CU-05` con cierre `RN-005` y factura `CU-11`) | 3 pantallas críticas rotuladas 1:1, sin datos personales ni reglas ajenas al SRS. |

---

## 3. Conclusiones de la Evaluación

- **Total de criterios evaluados:** 16 criterios (incluyendo 4 de cobertura y trazabilidad).
- **Criterios que cumplen tras re-verificación:** **16 / 16 (100 %)**.
- **Auditoría estructural y geométrica automatizada:** 0 errores XML, 0 cruces interiores en líneas y 0 colisiones con entidades/actores en las 4 parejas `.svg`/`.drawio`.
- **Dictamen:** La documentación y los modelos de análisis cumplen al **100 %** con los criterios de la Rúbrica G1-P2 y las 10 Reglas de Arbitraje Oficiales del SENA.
