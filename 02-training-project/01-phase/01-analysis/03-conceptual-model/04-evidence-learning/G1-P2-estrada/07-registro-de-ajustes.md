# Registro de Ajustes y Mejoras a la Documentación de Análisis
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592374 (Criterio C7) — Realiza mejoras a la documentación de análisis de acuerdo con los resultados de la evaluación  
**Formato Oficial:** Anexo D (`Rubricas_G1.md` y `Plantilla_README_Entrega_G1.md`)  
**Aprendiz Autor:** Miguel Ángel Estrada Torrentes (`estrada`)  
**Proyecto:** Sistema Gestor de Ambulancias (SGA) · Ficha 3413974  
**Fecha de Registro:** 25 de noviembre de 2026  

---

## 1. Justificación y Alcance del Control de Ajustes

Durante el ciclo de análisis del Sistema Gestor de Ambulancias (SGA), se aplicó el instrumento de verificación formal (Lista de Chequeo Anexo B) sobre las versiones preliminares de los modelos. Dicho proceso evidenció 5 discrepancias técnicas sustantivas respecto a la sintaxis UML estándar, los lineamientos relacionales y las 10 Reglas de Arbitraje de la Guía 1.

A continuación, se documenta cada hallazgo identificado, exponiendo el estado inicial defectuoso (*Antes*), la solución de ingeniería adoptada (*Después*), el artefacto intervenido y la evidencia de su segunda verificación exitosa.

---

## 2. Matriz de Registro de Ajustes (Anexo D)

| # | Hallazgo (criterio que no cumplía) | Artefacto | Antes (Estado Inicial Defectuoso) | Después (Ajuste de Ingeniería Implementado) | Enlace al Commit / Referencia | ¿Se verificó de nuevo? |
|---|---|---|---|---|---|:---:|
| **1** | **Dirección errónea en relación `<<extend>>` (Regla Arbitraje 2)**. La relación entre CU-04 y CU-03 apuntaba incorrectamente desde el caso base hacia la extensión. | `03-diagrama-casos-de-uso.drawio` y `.svg` | Flecha con punta abierta saliendo de CU-03 (Despachar ambulancia) hacia CU-04 (Reasignar ambulancia), invirtiendo el sentido semántico estándar de UML. | Se invirtió la orientación de la relación: la flecha de extensión apunta estrictamente desde el caso extensor (`CU-04`) hacia el caso base (`CU-03`), rotulada con `<<extend>>` y especificando el punto de extensión «Falla mecánica o contingencia en ruta». | Commit Día 1 (`G1-P1`) / `03-diagrama-casos-de-uso.svg#L110` | **Sí** (Criterio 7 de lista de chequeo verificado en 100 %) |
| **2** | **Atributos técnicos de clave foránea en Modelo de Dominio (Regla Arbitraje 5 y C3)**. Se habían incluido atributos de base de datos (`ambulancia_id_fk`, `solicitud_id_fk`) dentro de las clases de dominio. | `03-modelo-dominio.drawio` y `.svg` | La clase conceptual `ServicioAsistencial` listaba variables de persistencia relacional física (`solicitud_id: INT`, `ambulancia_id: INT`), violando el nivel conceptual puro. | Se eliminaron todas las claves foráneas y tipos de datos físicos del modelo de dominio. Las relaciones se representan exclusivamente mediante asociaciones semánticas directas con multiplicidades (`1..1`, `0..*`) y nombres de rol legibles. | Commit Día 1 (`G1-P2`) / `03-modelo-dominio.svg#L65` | **Sí** (Criterios 10 y 11 de lista de chequeo verificados en 100 %) |
| **3** | **Relación N:M no resuelta en Modelo Entidad-Relación (Regla Arbitraje 5 y C4)**. El vínculo entre `SERVICIO_ASISTENCIAL` y `PERSONAL_MEDICO` carecía de entidad asociativa con atributos de auditoría. | `04-modelo-entidad-relacion.drawio` y `.svg` | Conexión directa Muchos a Muchos (N:M) entre las dos tablas, sin capacidad de almacenar el rol que desempeñó cada profesional ni la hora exacta de asignación/liberación. | Se diseñó e incorporó la entidad asociativa `PERSONAL_SERVICIO` con clave primaria propia (`id_personal_servicio`), claves foráneas hacia servicio y personal, y atributos propios de negocio: `rol_operativo`, `hora_asignacion`, `hora_liberacion` y `activo_en_tripulacion`. | Commit Día 1 (`G1-P2`) / `04-modelo-entidad-relacion.svg#L130` | **Sí** (Criterio 14 de lista de chequeo verificado en 100 %) |
| **4** | **Decisiones sin guardas completas entre corchetes en Diagramas de Actividades (Criterio C1)**. Existían bifurcaciones de control con etiquetas ambiguas («Sí» / «No») sin cobertura total de salidas. | `01-diagramas-actividades.drawio` y `.svg` | En el diagrama de CU-03, el rombo de comprobación de móvil disponible solo definía una flecha afirmativa, dejando implícito el flujo en caso de saturación de flota. | Se normalizaron todas las decisiones mediante rombos ortogonales y guardas formales entre corchetes: `[Ambulancia libre con ETA < 15 min]` que avanza al despacho, y `[Sin unidades libres en zona]` que bifurca a la notificación al CRUE departamental y encolamiento. | Commit Día 1 (`G1-P2`) / `01-diagramas-actividades.svg#L95` | **Sí** (Criterio 3 de lista de chequeo verificado en 100 %) |
| **5** | **Precondición redactada como validación en tiempo de ejecución (Regla Arbitraje 3 y C2)**. En CU-05 se definía como precondición una regla de cálculo de copago que el sistema ejecuta durante el caso. | `02-plantillas-casos-de-uso.md` | El campo *Precondiciones* indicaba: «El sistema valida que el paciente pertenezca al régimen contributivo y calcula el 15 % de copago». | Se reestructuró la plantilla: las precondiciones se restringieron a los hechos preexistentes comprobables («Servicio asistencial en estado EN_IPS y médico con turno activo en el móvil»). La liquidación del copago se trasladó al Flujo Principal (paso 4) y a los Flujos Alternos (4a y 4b) según RN-005. | Commit Día 1 (`G1-P2`) / `02-plantillas-casos-de-uso.md#L185` | **Sí** (Criterios 9 y 10 de lista de chequeo verificados en 100 %) |

---

## 3. Conclusión del Proceso de Ajustes

La implementación de estos 5 ajustes sustantivos permitió:
1. Eliminar ambigüedades metodológicas en el modelado conceptual y de persistencia.
2. Garantizar que ningún modelo contenga errores que activen penalizaciones automáticas según las directrices de la Rúbrica SENA.
3. Asegurar una trazabilidad limpia y sin saltos desde la captura de requisitos hasta las interfaces gráficas de usuario.
