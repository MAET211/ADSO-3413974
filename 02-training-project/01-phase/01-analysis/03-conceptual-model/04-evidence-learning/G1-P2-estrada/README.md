# Entrega de Evidencia · Guía 1 · Producto 2 (G1-P2)
**Modelo de Análisis y Verificación Conceptual**

Ruta en el repositorio:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/`

Fecha límite de entrega: **Sábado 28 de noviembre de 2026 a las 6:00 a. m.**  
Normativa y criterios de evaluación: `Rubricas_G1.md` (Sección 5 y Sección 7)

---

## 1. Datos de la Entrega

- **Producto:** P2 - Modelo de análisis y verificación conceptual
- **Usuario de GitHub del autor:** `MAET211` (Carpeta asignada: `G1-P2-estrada`)
- **Caso de estudio:** Sistema Gestor de Ambulancias (SGA) — Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado
- **Trabajo en equipo del año:** Sí · Nombre del equipo: **Equipo SGA** (sin datos personales de terceros conforme a la Sección 1 de la plantilla)

---

## 2. Qué Reutilicé

| Artefacto | Ruta original en mi fork / Origen | ¿Lo hice solo o en equipo? |
|---|---|---|
| Instrumentos base de recolección del SGA | `03-execute/08-week/02-optional-activity/Complete-SGA-Instruments/Instrumentos_SGA_Completos (1) (1).docx` | En equipo (`Equipo SGA`) |
| Normativa sanitaria y lineamientos del proyecto SGA | `03-execute/14-week/02-optional-activity/Normativa_Proyecto_SGA_Completa.docx` y `SGA_Presentacion.pptx` | En equipo (`Equipo SGA`) |
| Referencias iniciales de interfaz normativa SGA | `03-execute/14-week/02-optional-activity/SGA_Normativa_Mockup.docx` | En equipo (`Equipo SGA`) |
| Requisitos, entidades base y reglas de negocio del SGA (`RF-001`..`RF-065`, `RN-001`..`RN-018`) | SRS oficial de `Equipo SGA` (Secciones 4, 5 y 6) | En equipo (`Equipo SGA`) |

---

## 3. Qué Ajusté

| # | Artefacto | Qué cambié y por qué | Criterio de `Rubricas_G1.md` que mejora | Enlace al commit / estado |
|---|---|---|---|---|
| 1 | `03-modelo-dominio.svg` y `.drawio` | Eliminación de claves foráneas físicas y tipos SQL en clases conceptuales; uso exclusivo de asociaciones y multiplicidades puras bajo Regla de Arbitraje 5. | **C3 (RAP 592373)** · Dominio conceptual puro. | [`45dd3b4`](https://github.com/MAET211/ADSO-3413974/commit/45dd3b4) |
| 2 | `04-modelo-entidad-relacion.svg` y `.drawio` | Resolución formal N:M entre `SERVICIO` y `PERSONAL` mediante la entidad asociativa `PERSONAL_SERVICIO` con `rol_operativo`, `hora_asignacion` y `hora_liberacion`. | **C4 (RAP 592373)** · MER con N:M resuelta y entidad débil. | [`45dd3b4`](https://github.com/MAET211/ADSO-3413974/commit/45dd3b4) |
| 3 | `01-diagramas-actividades.svg` y `.drawio` | Formalización de guardas completas entre corchetes y bloque paralelo *Fork/Join* para acciones concurrentes en cierre de servicio (`DA-02`). | **C1 (RAP 592373)** · Actividades con calles, guardas y concurrencia. | [`45dd3b4`](https://github.com/MAET211/ADSO-3413974/commit/45dd3b4) |
| 4 | `03-modelo-dominio.svg` y `.drawio` | Sustitución de `+ inmutable: boolean` por `+ inmutable: Booleano (Si/No)` y multiplicidades nativas (`edgeLabel`) en Draw.io. | **C3 (RAP 592373)** · Desacoplamiento de código. | [`11f5126`](https://github.com/MAET211/ADSO-3413974/commit/11f5126) |
| 5 | `04-modelo-entidad-relacion.svg` y `.drawio` | Formalización de clave primaria compuesta identificadora `(servicio_id, numero_secuencia)` en entidad débil `HISTORIAL_ESTADOS_SERVICIO`. | **C4 (RAP 592373)** · Entidad débil estricta. | [`11f5126`](https://github.com/MAET211/ADSO-3413974/commit/11f5126) |
| 6 | Todos los diagramas `.drawio` y `.svg` + `09-matriz-trazabilidad-anexo-c.md` | Rediseño geométrico integral a **0 cruces y 0 colisiones** (incluido *Fork/Join* contenido en carril 3 de `DA-02` y despeje de herencia en `Ambulancia`), ampliación a **13 clases y 13 entidades** (`Rol`, `Usuario`, `AUDITORIA`, `NOVEDAD`, campos `RN-005` en `SERVICIO`) y alineación total de Anexo C sobre los 12 `CU` y 65 `RF` reales. | **C1, C3, C4 y C8** · Trazabilidad integral sin entidades fantasma ni cruces visuales. | Commit Día 3 (`27 nov · G1-P2`) |
| 7 | `05-prototipo-mockups.md`, `08-informe-analisis.md`, `06-lista-chequeo`, `07-registro` y `02-plantillas` | Sincronización de `P-03` con cierre REPS (`RN-005`) y factura inmutable (`CU-11`/`RN-014`), actualización a los 15 módulos y 29 RNFs del SRS, anonimización total de nombres/operador, y corrección de citas y rutas reales de `03-execute/`. | **C2, C5, C6, C7 y Privacidad** · Coherencia documental absoluta con SRS y rúbrica. | Commit Día 3 (`27 nov · G1-P2`) |

---

## 4. Qué Construí Nuevo

Para dar cumplimiento a la Guía 1 - Producto 2, se construyó y verificó de forma individual:
1. **Diagramas de Actividades con Calles y Concurrencia (`01-diagramas-actividades.drawio` y `.svg`):** Flujos `DA-01` (`CU-03 / CU-02`) y `DA-02` (`CU-05 / CU-11 / CU-06`) con particiones por actor, guardas entre corchetes, concurrencia *Fork/Join* con 3 acciones paralelas y 0 cruces geométricos.
2. **Plantillas Extendidas de Casos de Uso Críticos (`02-plantillas-casos-de-uso.md`):** Especificación tabular Anexo A de `CU-03`, `CU-04` y `CU-05` redactada sin jerga física y enlazada 1:1 con actividades y mockups.
3. **Modelo Conceptual de Dominio (`03-modelo-dominio.drawio` y `.svg`):** Arquitectura conceptual pura de **13 clases de negocio** (`Rol`, `Usuario`, `RegistroAuditoria`, `Ambulancia` $\rightarrow$ `TAB`/`TAM`, `PersonalSalud`, `Paciente`, `SolicitudEmergencia`, `ServicioAsistencial`, `Factura`, `PQRS`, `NovedadOperativa`) sin métodos ni claves foráneas.
4. **Modelo Entidad-Relación Relacional (`04-modelo-entidad-relacion.drawio` y `.svg`):** Diseño de **13 entidades** bajo notación Crow's Foot (`ROL`, `USUARIO`, `AUDITORIA`, `PERSONAL`, `PACIENTE`, `PQRS`, `AMBULANCIA`, `SOLICITUD_EMERGENCIA`, `SERVICIO`, `PERSONAL_SERVICIO`, `HISTORIAL_ESTADOS_SERVICIO`, `FACTURA`, `NOVEDAD`) con resolución N:M y entidad débil identificadora.
5. **Prototipo Inicial de Interfaz (`05-prototipo-mockups.md`):** 3 pantallas rotuladas (`P-01` a `P-03`) alineadas con `RN-005` y `RN-014`, diccionarios de control y datos anonimizados.
6. **Lista de Chequeo de Validación (`06-lista-chequeo-validacion.md`):** Instrumento de 16 criterios (4 de cobertura/trazabilidad) con citas exactas y resultados auditados.
7. **Registro de Ajustes Formativo (`07-registro-de-ajustes.md`):** Documentación de **12 hallazgos** (*Antes*, *Después*, enlace a commits y segunda verificación).
8. **Informe Técnico de Análisis (`08-informe-analisis.md`):** Síntesis de los **65 RF (15 módulos)** y **29 RNF (ISO/IEC 25010)** del SRS, catálogo de modelos y dictamen de calidad (Anexo E).
9. **Matriz de Trazabilidad Integral (`09-matriz-trazabilidad-anexo-c.md`):** Trazabilidad de 65/65 requisitos (`100 %`) entre SRS, los 12 casos de uso reales, actividades, plantillas, 13 clases de dominio, 13 entidades del MER y mockups (Anexo C).

---

## 5. Artefactos Entregados (Enlaces Relativos)

- [x] Diagramas de actividades (fuente editable): [01-diagramas-actividades.drawio](./01-diagramas-actividades.drawio)
- [x] Diagramas de actividades (imagen vectorial): [01-diagramas-actividades.svg](./01-diagramas-actividades.svg)
- [x] Plantillas extendidas de casos de uso (Anexo A): [02-plantillas-casos-de-uso.md](./02-plantillas-casos-de-uso.md)
- [x] Modelo de dominio (fuente editable): [03-modelo-dominio.drawio](./03-modelo-dominio.drawio)
- [x] Modelo de dominio (imagen vectorial): [03-modelo-dominio.svg](./03-modelo-dominio.svg)
- [x] Modelo entidad-relación (fuente editable): [04-modelo-entidad-relacion.drawio](./04-modelo-entidad-relacion.drawio)
- [x] Modelo entidad-relación (imagen vectorial): [04-modelo-entidad-relacion.svg](./04-modelo-entidad-relacion.svg)
- [x] Prototipo inicial de software (3 pantallas rotuladas): [05-prototipo-mockups.md](./05-prototipo-mockups.md)
- [x] Lista de chequeo diligenciada (16 criterios, Anexo B): [06-lista-chequeo-validacion.md](./06-lista-chequeo-validacion.md)
- [x] Registro de ajustes y segunda verificación (12 hallazgos, Anexo D): [07-registro-de-ajustes.md](./07-registro-de-ajustes.md)
- [x] Informe de análisis técnico (Anexo E): [08-informe-analisis.md](./08-informe-analisis.md)
- [x] Matriz de trazabilidad requisito $\rightarrow$ artefactos (Anexo C): [09-matriz-trazabilidad-anexo-c.md](./09-matriz-trazabilidad-anexo-c.md)

---

## 6. Declaración de Autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma:** `MAET211` · Fecha: 27 de noviembre de 2026

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Asistente IA (`Antigravity`) | Depuración topológica XML/SVG para cero cruces geométricos, restructuración de plantillas Markdown y verificación programática de integridad referencial. | Revisión integral contra el SRS SGA (`RF-001`..`RF-065`, `RN-001`..`RN-018`), homologación de las 13 clases de dominio y 13 entidades del MER, anonimización completa, verificación de enlaces y comprobación de las 16 evidencias de la lista de chequeo. |

---

## 8. Autocontrol Antes del Push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía y la entrega (Día 1: 25 nov [`45dd3b4`]; Día 2: 26 nov [`11f5126`]; Día 3: 27 nov ajustes finales).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Cada artefacto obligatorio existe en la carpeta y supera los mínimos exigidos por la rúbrica.
- [x] Verifiqué que los 4 diagramas dobles (`.svg` y `.drawio`) registran `0` errores XML, `0` cruces y `0` colisiones antes de publicar.
