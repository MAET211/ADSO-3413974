# README · Entrega de Guía 1 · Producto 1: Plan de Análisis y Casos de Uso

Ruta reglamentaria de entrega en el fork:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-estrada/`  
Fecha límite de entrega oficial: **Sábado 28 de noviembre de 2026 a las 6:00 a. m.**  
Criterios de evaluación aplicados: `Rubricas_G1.md` (C1, C2, C3, C4 y C5).  

---

## 1. Datos de la Entrega

* **Producto:** Producto 1 (G1-P1) — Plan de análisis y casos de uso.
* **Usuario de GitHub del autor:** `MAET211` (Carpeta asignada: `G1-P1-estrada`).
* **Caso de estudio:** Sistema Gestor de Ambulancias (SGA) — Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado.
* **Trabajo en equipo del año:** Sí. Nombre del equipo: **Equipo SGA** (sin datos personales de terceros conforme a la Sección 1 de la plantilla).

---

## 2. Qué Reutilicé

| Artefacto | Ruta original en mi fork / Origen | ¿Lo hice solo o en equipo? |
| :--- | :--- | :---: |
| **Instrumentos de recolección y bases del proyecto SGA** | `03-execute/08-week/02-optional-activity/Complete-SGA-Instruments/Instrumentos_SGA_Completos (1) (1).docx` | En equipo (`Equipo SGA`) |
| **Normativa sanitaria y estructura prehospitalaria del SGA** | `03-execute/14-week/02-optional-activity/Normativa_Proyecto_SGA_Completa.docx` y `SGA_Presentacion.pptx` | En equipo (`Equipo SGA`) |
| **Lineamientos iniciales de interfaz y mockups SGA** | `03-execute/14-week/02-optional-activity/SGA_Normativa_Mockup.docx` | En equipo (`Equipo SGA`) |
| **Documento SRS completo del SGA (`RF-001`..`RF-065`, `RN-001`..`RN-018`)** | Consolidado del proyecto formativo `Equipo SGA` (Secciones 4, 5 y 6) | En equipo (`Equipo SGA`) |

---

## 3. Qué Ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit / estado |
| :-: | :--- | :--- | :--- |
| **1** | **Catálogo de Requisitos Funcionales y Reglas de Negocio (`04-matriz-requisito-caso-uso.md`)** | Se consolidaron los **65 Requisitos Funcionales (`RF-001` a `RF-065`)**, **29 RNF (`RNF-001` a `RNF-029`)** y **18 Reglas de Negocio (`RN-001` a `RN-018`)** bajo la Resolución 3100 y normativa REPS, discriminando unidades `TAB` y `TAM`. *Mejora Criterio C3.* | [`8a45c04`](https://github.com/MAET211/ADSO-3413974/commit/8a45c04) y [`30f1024`](https://github.com/MAET211/ADSO-3413974/commit/30f1024) |
| **2** | **Diagrama de Casos de Uso UML (`03-diagrama-casos-de-uso.drawio` y `.svg`)** | Agrupación de CRUDs por objetivo de negocio (`CU-08`), incorporación de `CU-01.1`, ajuste estricto de las 6 relaciones `<<include>>` / `<<extend>>` con tabla de justificación en 1 línea, y **rediseño topológico ortogonal con 0 cruces de líneas y 0 colisiones con óvalos/actores**. *Mejora Criterio C4.* | [`8a45c04`](https://github.com/MAET211/ADSO-3413974/commit/8a45c04), [`30f1024`](https://github.com/MAET211/ADSO-3413974/commit/30f1024) y ajuste Día 3 (27 nov) |
| **3** | **Selección Metodológica, Plan y Especificación de Casos Complementarios** | Caracterización y justificación de **Scrum**, cronograma de 8 actividades priorizadas (`02-plan-actividades-analisis.md`), y reorientación de `05-especificacion-casos-de-uso.md` hacia los 9 casos complementarios (`CU-01`..`CU-11`) para eliminar duplicación con Anexo A de G1-P2. *Mejora Criterios C1 y C2.* | [`8a45c04`](https://github.com/MAET211/ADSO-3413974/commit/8a45c04) y ajuste Día 3 (27 nov) |

---

## 4. Qué Construí Nuevo

1. **Matriz de Trazabilidad Requisito $\rightarrow$ Caso de Uso (`04-matriz-requisito-caso-uso.md`):** Cobertura del **100 % (65/65 Requisitos Funcionales)** mapeados hacia los 12 casos de uso reales (`CU-01`, `CU-01.1`, `CU-02` a `CU-11`).
2. **Diagrama de Casos de Uso Editable y Vectorial (`03-diagrama-casos-de-uso.drawio` y `.svg`):** Frontera formal del sistema, 5 actores externos (`Coordinador Operativo`, `Paramédico`, `Administrador`, `Ciudadano`, `Sistema SGA`) y enrutamiento limpio verificado automáticamente (`0 cruces`).
3. **Especificación de Casos Complementarios (`05-especificacion-casos-de-uso.md`):** Síntesis operativa de `CU-01`, `CU-01.1`, `CU-02` y `CU-06` a `CU-11` sin duplicar las plantillas extendidas Anexo A de `CU-03`, `CU-04` y `CU-05` ubicadas en [`../G1-P2-estrada/02-plantillas-casos-de-uso.md`](../G1-P2-estrada/02-plantillas-casos-de-uso.md).
4. **Plan de Actividades y Metodología (`01-caracterizacion-y-metodologia.md` y `02-plan-actividades-analisis.md`):** Evaluación estructural, selección argumentada de metodología y plan de 8 actividades de análisis.

---

## 5. Artefactos Entregados

- [x] **Caracterización de la solución y comparación de metodologías:** [01-caracterizacion-y-metodologia.md](01-caracterizacion-y-metodologia.md)
- [x] **Plan de actividades, cronograma y entregables:** [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md)
- [x] **Diagrama de casos de uso (fuente editable Draw.io):** [03-diagrama-casos-de-uso.drawio](03-diagrama-casos-de-uso.drawio)
- [x] **Diagrama de casos de uso (imagen vectorial SVG):** [03-diagrama-casos-de-uso.svg](03-diagrama-casos-de-uso.svg)
- [x] **Matriz requisito → caso de uso (65/65 RFs):** [04-matriz-requisito-caso-uso.md](04-matriz-requisito-caso-uso.md)
- [x] **Especificación de casos de uso complementarios:** [05-especificacion-casos-de-uso.md](05-especificacion-casos-de-uso.md)
- [x] **README oficial de entrega:** [README.md](README.md)

---

## 6. Declaración de Autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma:** `MAET211` · Fecha: 27 de noviembre de 2026.

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| **Antigravity AI Assistant** | Asistencia para reestructurar conectores XML en Draw.io y renderizar SVG con cero cruces, estructurar Markdown según plantilla y verificar trazabilidad cruzada. | Verifiqué la correspondencia de los 65 Requisitos Funcionales del SRS SGA, las rutas reales existentes en `03-execute/`, la separación documental entre G1-P1 y G1-P2, la anonimización de datos personales y los 0 cruces geométricos del diagrama. |

---

## 8. Autocontrol antes del Push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía y la entrega (Día 1: 25 de noviembre [`8a45c04`]; Día 2: 26 de noviembre [`30f1024`]; Día 3: 27 de noviembre).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta `G1-P1-estrada` está publicada y actualizada.
