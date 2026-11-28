# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | **P1 (artefactos de diseño — RAP 593103)** |
| Usuario de GitHub del autor | `MAET211` (Carpeta asignada: `G2-P1-estrada`) |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | **Sistema Gestor de Ambulancias (SGA)** |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/08-informe-analisis.md) y [`04-matriz-requisito-caso-uso.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-estrada/04-matriz-requisito-caso-uso.md) |
| Cuenta de GitHub con la que haces los commits | `MAET211` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el SRS base del SGA (`RF-001`..`RF-065`) fue elaborado inicialmente por el **Equipo SGA (4 aprendices)**. El análisis depurado y las entregas G1 y G2 son individuales de `MAET211`. |
| ¿Qué parte del SRS es tuya? | Consolidación del núcleo operativo crítico (`RF-001`..`RF-029`, `RF-031`, `RF-040`, `RF-055`) y trazabilidad total de los 65 RF en diseño. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, todos los artefactos de diseño A1 a A7 de `G2-P1-estrada` son de autoría individual de `MAET211`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. No se compartieron archivos de diseño P1/P2 ni se reutilizó material de ejemplo del instructor (semana 12 ni semana 20). |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| **A1** Ficha de interpretación y plataforma | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/08-informe-analisis.md` y `03-execute/14-week/02-optional-activity/Normativa_Proyecto_SGA_Completa.docx` | Seleccioné 16 RF críticos y 8 RNF clave y justifiqué **TypeScript 5 (Node.js)** + **PostgreSQL 18** con 3+ condiciones del SGA. |
| **A2** Diagrama de clases OOP | [`02-diagrama-clases.md`](./02-diagrama-clases.md) / [`.drawio`](./02-diagrama-clases.drawio) / [`.svg`](./02-diagrama-clases.svg) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/03-modelo-dominio.drawio` | Evolucioné las 13 clases conceptuales a **18 elementos OOP** con tipos, visibilidad `+`/`-`/`#`, métodos con parámetros, composición (`*--`), herencia (`AmbulanciaTAB`/`TAM`) e interfaz (`IEstrategiaAsignacion`). |
| **A3** Patrones de diseño GoF | [`03-patrones-de-diseno.md`](./03-patrones-de-diseno.md) | **Nuevo** | Apliqué y justifiqué **Strategy** (`IEstrategiaAsignacion` con 2 implementaciones) y **Facade** (`FachadaEmergenciaSGA`) integrados en A2. |
| **A4** Arquitectura del software | [`04-arquitectura-sistema.md`](./04-arquitectura-sistema.md) / [`.drawio`](./04-arquitectura-sistema.drawio) / [`.svg`](./04-arquitectura-sistema.svg) | `03-execute/14-week/02-optional-activity/SGA_Presentacion.pptx` (referencia general) | Diseñé arquitectura estricta en **4 capas sin saltos**, estilos de comunicación y tabla de decisiones para 5 RNF/estilos con alternativas descartadas. |
| **A5** Vista de componentes | [`05-vista-componentes.md`](./05-vista-componentes.md) / [`.drawio`](./05-vista-componentes.drawio) / [`.svg`](./05-vista-componentes.svg) | **Nuevo** | Modelé **7 componentes** con interfaces provistas/requeridas nombradas, sin acceso directo de UI a base de datos y mapeo a clases/RF. |
| **A6** Vista de despliegue | [`06-vista-despliegue.md`](./06-vista-despliegue.md) / [`.drawio`](./06-vista-despliegue.drawio) / [`.svg`](./06-vista-despliegue.svg) | **Nuevo** | Modelé **4 nodos** (Cliente, Proxy Nginx TLS, VPS Docker App, Datos PostgreSQL + Respaldo) con puertos/protocolos explícitos y decisiones RNF. |
| **A7** Matriz de trazabilidad análisis $\rightarrow$ diseño | [`07-matriz-trazabilidad-diseno.md`](./07-matriz-trazabilidad-diseno.md) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/09-matriz-trazabilidad-anexo-c.md` | Extendí trazabilidad de los **65/65 RF** + RNF hacia las 18 clases, 16 tablas y 7 componentes, con verificación inversa de cero huérfanos. |

**Qué reutilicé (resumen):** Partí del informe de análisis (`G1-P2-estrada/08-informe-analisis.md`), el catálogo de 65 RF y 29 RNF (`G1-P1-estrada/04-matriz-requisito-caso-uso.md`), el modelo de dominio conceptual de 13 clases (`03-modelo-dominio.drawio`) y las referencias normativas propias del equipo en `03-execute/08-week/` y `03-execute/14-week/`.

**Qué ajusté para llevarlo al estándar de la rúbrica:** Transformé el dominio conceptual puro en un diagrama de clases OOP completo (visibilidades, tipos estrictos, métodos con parámetros, composición y polimorfismo sin mezclar áreas de responsabilidad), amplié la trazabilidad de análisis hacia diseño y validé cero cruces visuales en las fuentes editables Draw.io/SVG.

**Qué hice completamente nuevo:** Definí e integré los patrones GoF `Strategy` y `Facade` (A3), la arquitectura en 4 capas con alternativas descartadas (A4), la vista de 7 componentes con interfaces provistas/requeridas (A5) y la topología de despliegue de 4 nodos con protocolos y puertos cifrados (A6).

## 4. Autoverificación de mínimos

- [x] A1 Ficha de interpretación: 16 RF críticos + 8 RNF con ID; plataforma TypeScript + PostgreSQL justificada
- [x] A2 Diagrama de clases: 18 clases/interfaces, tipos, métodos con parámetros, multiplicidades, composición (`ServicioAsistencial *-- HistorialEstado`), herencia (`Ambulancia -> TAB/TAM`) e interfaz con 2 implementaciones (`IEstrategiaAsignacion`)
- [x] A3 2 patrones GoF distintos aplicados en el diagrama (`Strategy` y `Facade`, ambos diferentes de `Singleton`)
- [x] A4 Arquitectura en 4 capas con diagrama y tabla de 5 decisiones RNF + alternativas descartadas
- [x] A5 Vista de componentes: 7 componentes con interfaces provistas y requeridas nombradas
- [x] A6 Vista de despliegue: 4 nodos con artefactos, protocolos y puertos explícitos (`HTTPS 443`, `HTTP/WS 3000`, `TCP 5432 SSL`, `SMTP 587`)
- [x] A7 Matriz de trazabilidad análisis $\rightarrow$ diseño cubriendo 100 % de los RF y verificación inversa sin huérfanos
- [x] Fuente editable (`.drawio`) e imagen vectorial exportada (`.svg`) sin cruces para cada diagrama (A2, A4, A5, A6)

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| Sábado 28 nov 2026 (antes 6:00 a. m.) | `feat(G2-P1): entregar artefactos A1-A7, diagramas UML sin cruces y trazabilidad 100% SGA` (construido el 27 nov tras cierre de G1 y publicado en commit separado para P1). |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| **Antigravity AI Assistant** | Asistencia en redacción técnica estructurada de tablas A1–A7, generación de archivos Draw.io XML y renders SVG ortogonales sin cruces. | Verifiqué correspondencia exacta de los 65 RF y RNF del SRS SGA, separación estricta de responsabilidades entre clases (Regla 5), inexistencia de saltos de capa y cero cruces geométricos en todos los diagramas. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [`08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/08-informe-analisis.md)
- Carpeta de esta entrega en GitHub: `https://github.com/MAET211/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-estrada`
- Entrega complementaria de datos y verificación (G2-P2): [`../G2-P2-estrada/README.md`](../G2-P2-estrada/README.md)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría (`MAET211`), que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.
