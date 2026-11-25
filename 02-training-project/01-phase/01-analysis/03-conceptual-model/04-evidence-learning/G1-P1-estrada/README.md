# README · Entrega de Guía 1 · Producto 1: Plan de Análisis y Casos de Uso

Ruta reglamentaria de entrega en el fork:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-estrada/`  
Fecha límite de entrega oficial: **Sábado 28 de noviembre de 2026 a las 6:00 a. m.**  
Criterios de evaluación aplicados: `Rubricas_G1.md` (C1, C2, C3, C4 y C5).  

---

## 1. Datos de la Entrega

* **Producto:** Producto 1 (G1-P1) — Plan de análisis y casos de uso.
* **Usuario de GitHub del autor:** `MAET211` (Nombre corto de carpeta: `estrada`).
* **Caso de estudio:** Sistema Gestor de Ambulancias (SGA) — Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado.
* **Trabajo en equipo del año:** Sí. Equipo formativo SGA: *Nicolás Aldana Doria, Juan Miguel Muñoz Castañeda, Miguel Ángel Estrada Torrentes y Juan José Horta Méndez*.

---

## 2. Qué Reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
| :--- | :--- | :---: |
| **Especificación de Requisitos de Software (SRS inicial)** | `03-execute/11-week/02-optional-activity/` y `03-execute/09-week/` | En equipo (Equipo SGA) |
| **Talleres iniciales de casos de uso y diagramación** | `03-execute/15-week/02-optional-activity/taller-2/` | En equipo |
| **Bocetos iniciales de interfaces y toma de servicios** | `03-execute/17-week/02-optional-activity/` | En equipo |
| **Marco normativo prehospitalario y de salud** | `03-execute/14-week/02-optional-activity/` | En equipo / Individual |

---

## 3. Qué Ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
| :-: | :--- | :--- | :--- |
| **1** | **Catálogo de Requisitos Funcionales y Reglas de Negocio** | Se depuraron y estructuraron unívocamente los 65 Requisitos Funcionales (RF-001 al RF-065) y 18 Reglas de Negocio (RN-001 al RN-018) bajo el marco legal de la **Resolución 3100 de 2019** y el **REPS**, eliminando ambigüedades e incorporando la discriminación obligatoria entre unidades TAB y TAM. *Mejora Criterio C3.* | *[Commit #1 · Estructuración Base G1-P1](https://github.com/MAET211/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-estrada)* |
| **2** | **Diagrama de Casos de Uso UML Formal** | Se rediseñó desde cero el modelo gráfico en Draw.io (`03-diagrama-casos-de-uso.drawio` y `.svg`), agrupando CRUDs según la regla 1 de arbitraje («Gestionar ambulancias»), fijando la frontera del sistema formal, y corrigiendo la dirección estricta de las dependencias `<<include>>` (base $\rightarrow$ incluido) y `<<extend>>` (extensión $\rightarrow$ base) con **cero cruces de conectores**. *Mejora Criterio C4.* | *[Commit #1 · Estructuración Base G1-P1](https://github.com/MAET211/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-estrada)* |
| **3** | **Selección Metodológica y Plan de Análisis** | Se elaboró de forma individual la caracterización de la solución evaluando los 4 aspectos estructurales y se compararon 4 metodologías (RUP, XP, RAD, Scrum), justificando la adopción de **Scrum** y estructurando un cronograma de 8 actividades de análisis priorizadas con responsables, fechas y entregables verificables. *Mejora Criterios C1 y C2.* | *[Commit #1 · Estructuración Base G1-P1](https://github.com/MAET211/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-estrada)* |

---

## 4. Qué Construí Nuevo

1. **Matriz de Trazabilidad Bidireccional (`04-matriz-requisito-caso-uso.md`):** Mapeo exhaustivo con **100% de cobertura** sobre los 65 Requisitos Funcionales del SGA, garantizando que no existan requisitos huérfanos ni casos de uso injustificados.
2. **Fuente Editable e Imagen Vectorial Draw.io (`03-diagrama-casos-de-uso.drawio` y `.svg`):** Diagrama UML nativo con enrutamiento ortogonal que erradica por completo el antipatrón de *diagrama espagueti*.
3. **Plantillas Extendidas de Casos de Uso Críticos (`05-especificacion-casos-de-uso.md`):** Especificación tabular formal (Anexo A) para despacho automático (`CU-03`), despacho manual (`CU-04`) y cierre formal con liquidación inmutable (`CU-05`).
4. **Plan de Actividades de Análisis Priorizadas (`02-plan-actividades-analisis.md`):** Desglose de 8 actividades con responsables técnicos específicos coherentes con los roles del proyecto formativo.

---

## 5. Artefactos Entregados

- [x] **Caracterización de la solución y comparación de metodologías:** [01-caracterizacion-y-metodologia.md](01-caracterizacion-y-metodologia.md)
- [x] **Plan de actividades, cronograma y entregables:** [02-plan-actividades-analisis.md](02-plan-actividades-analisis.md)
- [x] **Diagrama de casos de uso (fuente editable Draw.io):** [03-diagrama-casos-de-uso.drawio](03-diagrama-casos-de-uso.drawio)
- [x] **Diagrama de casos de uso (imagen vectorial SVG):** [03-diagrama-casos-de-uso.svg](03-diagrama-casos-de-uso.svg)
- [x] **Matriz requisito → caso de uso:** [04-matriz-requisito-caso-uso.md](04-matriz-requisito-caso-uso.md)
- [x] **Plantillas extendidas de casos de uso (Anexo A):** [05-especificacion-casos-de-uso.md](05-especificacion-casos-de-uso.md)
- [x] **README oficial de entrega:** [README.md](README.md)

---

## 6. Declaración de Autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma:** `MAET211` (Miguel Ángel Estrada Torrentes) · Fecha: 25 de noviembre de 2026.

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| **Antigravity AI Assistant** | Asistencia técnica para formatear la estructura XML de Draw.io, generar el renderizado vectorial SVG sin cruces y estructurar el Markdown bajo la plantilla reglamentaria. | Verifiqué y aseguré la pertinencia de los 65 Requisitos Funcionales de mi proyecto formativo SGA, la alineación estricta con la Resolución 3100 de 2019 y el REPS, la asignación real de los integrantes de mi equipo y la eliminación de detalles técnicos de base de datos en las plantillas conceptuales. |

---

## 8. Autocontrol antes del Push

- [x] Hice commits propios en al menos 2 días distintos (Día 1: Miércoles 25 de noviembre / Día 2: Jueves 26 o Viernes 27 de noviembre de 2026).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta `G1-P1-estrada` está publicada.
