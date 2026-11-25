# Lista de Chequeo para Validación de la Documentación de Análisis
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592374 (Criterio C6) — Elabora listas de chequeo para validación de la documentación de análisis y las aplica  
**Formato Oficial:** Anexo B (`Rubricas_G1.md` y `Plantilla_README_Entrega_G1.md`)  
**Aprendiz Evaluador:** Miguel Ángel Estrada Torrentes (`estrada`)  
**Proyecto:** Sistema Gestor de Ambulancias (SGA) · Ficha 3413974  
**Fecha de Aplicación:** 25 de noviembre de 2026  

---

## 1. Metodología de Validación

Para garantizar el cumplimiento de los estándares de calidad del SENA y las normas de arbitraje de la Guía 1 (Sección 7), se estructuró una lista de verificación con **16 criterios objetivos y verificables** (evaluados mediante respuesta dicotómica: Sí / No). Se formularon específicamente **4 criterios de cobertura y trazabilidad integral** para asegurar que ningún requisito del negocio quede huérfano.

Las desviaciones detectadas durante la primera ronda de auditoría fueron clasificadas como hallazgos y transferidas al *Registro de Ajustes* (`07-registro-de-ajustes.md`) para su inmediata subsanación técnica y posterior re-verificación.

---

## 2. Matriz de Verificación Diligenciada (Anexo B)

| # | Criterio verificable (responde sí o no) | Artefacto | ¿Cumple? | Evidencia (enlace o cita) | Hallazgo / Estado |
|---|---|---|:---:|---|---|
| **1** | **[Cobertura]** ¿El 100 % de los requisitos funcionales del SRS (RF-01 al RF-65) están mapeados en al menos un caso de uso sin omisiones? | Matriz Requisito-CU | **Sí** | `04-matriz-requisito-caso-uso.md#L45-L160` (65/65 RFs cubiertos) | Cumplimiento total. Verificado con matriz de trazabilidad cruzada. |
| **2** | **[Trazabilidad]** ¿Todos los conceptos de negocio utilizados en las plantillas de casos de uso existen como clases en el modelo de dominio? | Plantillas y Modelo de Dominio | **Sí** | `02-plantillas-casos-de-uso.md` vs `03-modelo-dominio.svg` (`Paciente`, `Ambulancia`, `ServicioAsistencial`, etc.) | Inicialmente existía inconsistencia en la denominación de `Ambulancia` vs `UnidadMovil`; fue homologado. |
| **3** | **[Trazabilidad]** ¿Cada rama de decisión alterna o de excepción del diagrama de actividades aparece descrita en la plantilla del mismo caso de uso? | Actividades y Plantillas | **Sí** | `01-diagramas-actividades.svg` (ramas `[Sin unidades]` y `[Falla mecánica]`) vs `02-plantillas-casos-de-uso.md#L68` y `#L140` | Coherencia 1:1 estricta entre flujos gráficos y textuales. |
| **4** | **[Cobertura]** ¿Al menos el 90 % de los requisitos funcionales están trazados hasta clase de dominio y entidad del MER en la matriz Anexo C? | Matriz de Trazabilidad | **Sí** | `09-matriz-trazabilidad-anexo-c.md` (65/65 RFs trazados = 100 %) | Supera ampliamente el umbral del 90 % exigido por la rúbrica. |
| **5** | ¿Los diagramas de casos de uso ubican la frontera del sistema con los actores estrictamente por fuera de ella? | Casos de Uso | **Sí** | `03-diagrama-casos-de-uso.svg#L22` (Contenedor frontera y actores externos) | Cumple regla de arbitraje estándar UML. |
| **6** | ¿Las relaciones `<<include>>` se reservan para flujos obligatorios y apuntan del caso base al caso incluido? | Casos de Uso | **Sí** | `03-diagrama-casos-de-uso.svg` (CU-03 `<<include>>` CU-06 Autenticar Usuario) | Dirección de flecha validada: caso base $\rightarrow$ incluido. |
| **7** | ¿Las relaciones `<<extend>>` se emplean exclusivamente para extensiones opcionales/condicionales y apuntan del caso que extiende hacia el caso base? | Casos de Uso | **Sí** | `03-diagrama-casos-de-uso.svg` (CU-04 Reasignar `<<extend>>` CU-03 Despacho) | Flecha validada: caso que extiende $\rightarrow$ caso base. |
| **8** | ¿Las operaciones CRUD están agrupadas por objetivo de negocio y no fragmentadas en casos de uso técnicos individuales? | Casos de Uso | **Sí** | `01-caracterizacion-y-metodologia.md` y `04-matriz-requisito-caso-uso.md` | Cumple Regla de Arbitraje 1: no se dispersó en Crear/Editar/Eliminar. |
| **9** | ¿Las precondiciones en las plantillas detallan únicamente estados previos verificados antes de iniciar el caso y no comprobaciones intermedias? | Plantillas de CU | **Sí** | `02-plantillas-casos-de-uso.md` (Precondición: Usuario con sesión autenticada y turno activo) | Cumple Regla de Arbitraje 3. Las validaciones de saldo/stock son flujos alternos. |
| **10** | ¿Las plantillas de casos de uso extendidas están completamente libres de detalles de implementación (sin SQL, sin tablas físicas, sin endpoints)? | Plantillas de CU | **Sí** | `02-plantillas-casos-de-uso.md` (Redacción puramente conceptual de intención de usuario y sistema) | Sin mención de MySQL, Spring, REST o sentencias de BD. |
| **11** | ¿El modelo de dominio cuenta con al menos 8 clases conceptuales con multiplicidades en ambos extremos y sin métodos definidos? | Modelo de Dominio | **Sí** | `03-modelo-dominio.svg` (10 clases: `Paciente`, `SolicitudEmergencia`, `ServicioAsistencial`, `Ambulancia`, etc.) | Totalmente conceptual, sin tipos SQL ni operaciones/métodos. |
| **12** | ¿El modelo de dominio incluye al menos una generalización o clase de asociación justificada en el negocio? | Modelo de Dominio | **Sí** | `03-modelo-dominio.svg` (Generalización `Ambulancia` $\rightarrow$ `TAB` y `TAM`) | Herencia validada conforme al REPS Resolución 3100 de 2019. |
| **13** | ¿El MER declara su notación formal y contiene al menos 6 entidades con sus identificadores de clave primaria (`<<PK>>`) rotulados? | Modelo ER | **Sí** | `04-modelo-entidad-relacion.svg` y `.drawio` (10 entidades con PK y notación Crow's Foot) | Notación declarada: Pata de Gallo (Crow's Foot). |
| **14** | ¿El MER resuelve toda relación de muchos a muchos (N:M) mediante una entidad asociativa que contenga atributos propios de negocio? | Modelo ER | **Sí** | `04-modelo-entidad-relacion.svg` (`PERSONAL_SERVICIO` con `rol_operativo`, `hora_asignacion`, `hora_liberacion`) | Cumple Regla de Arbitraje 5. |
| **15** | ¿El MER modela al menos una entidad débil o relación recursiva identificando la dependencia existencial? | Modelo ER | **Sí** | `04-modelo-entidad-relacion.svg` (`HISTORIAL_ESTADOS_SERVICIO` débil respecto a `SERVICIO_ASISTENCIAL`) | Dependencia existencial y clave foránea identificadora verificada. |
| **16** | ¿Todas las pantallas del prototipo inicial están formalmente rotuladas con el caso de uso que atienden, sin pantallas huérfanas? | Prototipo Mockups | **Sí** | `05-prototipo-mockups.md` (P-01 rotulada con CU-03, P-02 con CU-04, P-03 con CU-05) | 3 pantallas críticas rotuladas y vinculadas 1:1 a sus casos de uso. |

---

## 3. Conclusiones de la Evaluación

- **Total de criterios evaluados:** 16 criterios.
- **Criterios que cumplen:** 16 / 16 (100 %).
- **Criterios de cobertura y trazabilidad:** 4 criterios específicos (Criterios 1, 2, 3 y 4), todos satisfechos.
- **Dictamen:** Los modelos conceptuales y artefactos de análisis cumplen con el 100 % de los estándares exigidos por la Rúbrica G1-P2 y las 10 Reglas de Arbitraje Oficiales del SENA.
