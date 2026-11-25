# Entrega de Evidencia · Guía 1 · Producto 2 (G1-P2)
**Modelo de Análisis y Verificación Conceptual**

Ruta en el repositorio:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/`

Fecha límite de entrega: **Sábado 28 de noviembre de 2026 a las 6:00 a. m.**  
Normativa y criterios de evaluación: `Rubricas_G1.md` (Sección 5 y Sección 7)

---

## 1. Datos de la Entrega

- **Producto:** P2 - Modelo de análisis y verificación conceptual
- **Usuario de GitHub del autor:** `estrada` (Miguel Ángel Estrada Torrentes)
- **Caso de estudio:** Sistema Gestor de Ambulancias (SGA) / Sistema de Gestión Integral de Movilidad Asistencial y Traslado
- **Trabajo en equipo del año:** Sí · Equipo SGA (Autores base: Nicolas Aldana Doria, Juan Miguel Muñoz Castañeda, Miguel Ángel Estrada Torrentes, Juan José Horta Méndez)

---

## 2. Qué Reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Requisitos de Software (SRS Secciones 4, 5 y 6) | `02-training-project/01-phase/01-analysis/03-conceptual-model/03-execute/` | En equipo |
| Diccionario de Datos y Entidades Operativas | `02-training-project/01-phase/01-analysis/03-conceptual-model/03-execute/` | En equipo |
| Reglas de Negocio de Triage y Despacho (RN-001 a RN-009) | `02-training-project/01-phase/01-analysis/03-conceptual-model/03-execute/` | En equipo |

---

## 3. Qué Ajusté

| # | Artefacto | Qué cambié y por qué | Criterio de `Rubricas_G1.md` que mejora |
|---|---|---|---|
| 1 | `03-modelo-dominio.svg` y `.drawio` | **Eliminación de claves foráneas físicas y tipos SQL en clases conceptuales**. Se suprimieron atributos de persistencia física en `ServicioAsistencial` reemplazándolos por asociaciones y multiplicidades puras (`1..1`, `0..*`) bajo la Regla de Arbitraje 5. | **C3 (RAP 592373)** · Modelo de dominio puro sin métodos ni claves foráneas. |
| 2 | `04-modelo-entidad-relacion.svg` y `.drawio` | **Resolución formal de relación N:M con entidad asociativa con atributos propios**. Se transformó la relación directa entre `SERVICIO_ASISTENCIAL` y `PERSONAL_MEDICO` mediante la entidad intermedia `PERSONAL_SERVICIO` que registra `rol_operativo`, `hora_asignacion` y `hora_liberacion`. | **C4 (RAP 592373)** · MER relacional con N:M resuelta y entidad débil dependiente. |
| 3 | `01-diagramas-actividades.svg` y `.drawio` | **Formalización exhaustiva de guardas entre corchetes y concurrencia fork/join**. Se eliminaron etiquetas ambiguas en rombos de decisión, implementando guardas completas como `[Ambulancia libre con ETA < 15 min]` y `[Sin unidades libres en zona]`, junto con sincronización paralela de notificaciones telemáticas. | **C1 (RAP 592373)** · Diagramas de actividades con calles, decisiones completas y bifurcación/unión. |

---

## 4. Qué Construí Nuevo

Para dar cumplimiento exhaustivo a los requerimientos de la Guía 1 - Producto 2, se construyó desde cero de forma individual:
1. **Diagramas de Actividades con Calles y Concurrencia (`01-diagramas-actividades.drawio` y `.svg`):** Modelado formal con particiones por actor (Despachador, Sistema SGA, Tripulación, IPS), inicio, fin, decisiones exhaustivas y barras de concurrencia para los casos críticos CU-03 y CU-05.
2. **Plantillas Extendidas de Casos de Uso (`02-plantillas-casos-de-uso.md`):** Especificación tabular completa bajo Anexo A de CU-03, CU-04 y CU-05, con flujos de 6+ pasos, variantes alternas, excepciones y reglas de negocio, sin tecnicismos de implementación.
3. **Modelo Conceptual de Dominio (`03-modelo-dominio.drawio` y `.svg`):** Arquitectura conceptual de 10 clases de negocio, generalización `Ambulancia` $\rightarrow$ `TAB`/`TAM` y cero acoplamiento con BD.
4. **Modelo Entidad-Relación Relacional (`04-modelo-entidad-relacion.drawio` y `.svg`):** Diseño de 10 entidades bajo notación Crow's Foot (Pata de Gallo), resolución N:M y modelado de entidad débil `HISTORIAL_ESTADOS_SERVICIO`.
5. **Prototipo Inicial de Interfaz (`05-prototipo-mockups.md`):** 3 pantallas de interfaz rotuladas (P-01, P-02, P-03) con diccionario de campos, reglas de validación y control de errores.
6. **Lista de Chequeo de Validación (`06-lista-chequeo-validacion.md`):** Instrumento de 16 criterios dicotómicos con 4 de cobertura/trazabilidad, citas precisas y evidencias.
7. **Registro de Ajustes Formativo (`07-registro-de-ajustes.md`):** Documentación formal de 5 hallazgos técnicos con estado *Antes* y *Después*, justificación y segunda verificación.
8. **Informe Técnico de Análisis (`08-informe-analisis.md`):** Síntesis técnica de requisitos funcionales y no funcionales (ISO 25010), catálogo de modelos y dictamen de calidad (Anexo E).
9. **Matriz de Trazabilidad Integral (`09-matriz-trazabilidad-anexo-c.md`):** Mapeo cruzado de 65/65 requisitos funcionales hacia casos de uso, actividades, plantillas, dominio, MER y prototipo (100 % de cobertura, Anexo C).

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
- [x] Registro de ajustes y segunda verificación (5 hallazgos, Anexo D): [07-registro-de-ajustes.md](./07-registro-de-ajustes.md)
- [x] Informe de análisis técnico (Anexo E): [08-informe-analisis.md](./08-informe-analisis.md)
- [x] Matriz de trazabilidad requisito $\rightarrow$ artefactos (Anexo C): [09-matriz-trazabilidad-anexo-c.md](./09-matriz-trazabilidad-anexo-c.md)

---

## 6. Declaración de Autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma:** `estrada` (Miguel Ángel Estrada Torrentes) · 25 de noviembre de 2026

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Asistente IA (Antigravity Senior Auditor) | Estructuración modular de plantillas Markdown, generación de esquemas SVG limpios con trazado ortogonal y verificación de consistencia cruzada entre modelos. | Revisión manual de todas las relaciones de cardinalidad, validación de coherencia con las reglas de negocio del SRS (RN-001 a RN-009), verificación de no inclusión de métodos en el dominio conceptual y comprobación de las 16 evidencias de la lista de chequeo. |

---

## 8. Autocontrol Antes del Push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega (Día 1: Miércoles 25 de noviembre; Día 2: Jueves 26 o Viernes 27 de noviembre).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Cada artefacto obligatorio existe en la carpeta y supera los mínimos exigidos por la rúbrica.
- [x] Hice `push` y comprobé en GitHub que la carpeta `G1-P2-estrada` está publicada.
