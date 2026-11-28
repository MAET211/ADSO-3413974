# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | **P2 (modelo de datos y verificación — RAP 593101 y 593102)** |
| Usuario de GitHub del autor | `MAET211` (Carpeta asignada: `G2-P2-estrada`) |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | **Sistema Gestor de Ambulancias (SGA)** |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/08-informe-analisis.md) y [`04-matriz-requisito-caso-uso.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-estrada/04-matriz-requisito-caso-uso.md) |
| Cuenta de GitHub con la que haces los commits | `MAET211` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el SRS base del SGA (`RF-001`..`RF-065`) fue elaborado por el **Equipo SGA (4 aprendices)**. El ajuste de análisis G1 y toda la modelación de datos, SQL, seguridad y verificación de G2 son individuales de `MAET211`. |
| ¿Qué parte del SRS es tuya? | Diseño de integridad de datos del núcleo operativo y financiero (`RF-001`..`RF-035`, `RF-040`..`RF-065`), reglas `RN-001`..`RN-018` y trazabilidad integral del esquema. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí, los artefactos B1 a B7 de `G2-P2-estrada` son de autoría individual de `MAET211`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. No se compartieron archivos P1/P2 ni se entregó material del instructor (semana 12 ni laboratorio/ejemplo de semana 20) como propio. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| **B1** Modelo conceptual ajustado | [`01-modelo-conceptual-datos.md`](./01-modelo-conceptual-datos.md) / [`.drawio`](./01-modelo-conceptual-datos.drawio) / [`.svg`](./01-modelo-conceptual-datos.svg) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/04-modelo-entidad-relacion.drawio` | Evolucioné las 13 entidades de G1 a **14 entidades + 2 subtipos (`TAB`/`TAM`)**: añadí `SEDE` y `NOTA_CONTABLE`, declaré el atributo multivaluado `{telefonos_contacto}` en `PACIENTE` y justifiqué PostgreSQL 18. |
| **B2** Modelo lógico relacional y transformación | [`02-modelo-logico-relacional.md`](./02-modelo-logico-relacional.md) / [`.drawio`](./02-modelo-logico-relacional.drawio) / [`.svg`](./02-modelo-logico-relacional.svg) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/04-modelo-entidad-relacion.drawio` | Apliqué todas las reglas de transformación generando **16 tablas en 3FN**: extraje `paciente_telefonos` (multivaluado), consolidé `TAB`/`TAM` con discriminador en `ambulancias` y documenté FKs y PK compuesta. |
| **B3** Evidencia de normalización (`0FN -> 3FN`) | [`03-normalizacion-3fn.md`](./03-normalizacion-3fn.md) | **Nuevo** | Normalicé paso a paso 2 tablas propias con DF escritas: `registro_despacho_tripulacion` (llave compuesta 2FN + transitividad 3FN) y `expediente_solicitud_usuario` (1FN multivaluada + transitividad 3FN). |
| **B4** Diccionario de datos | [`04-diccionario-de-datos.md`](./04-diccionario-de-datos.md) | `03-execute/08-week/02-optional-activity/Complete-SGA-Instruments/Instrumentos_SGA_Completos (1) (1).docx` (referencia SRS Sec. 6) | Declaré estándar `snake_case` y documenté el 100 % de las 16 tablas y todas sus columnas coincidiendo al 100 % con `B2` y `B5`. |
| **B5** Script SQL y evidencia de ejecución | [`05-script-creacion-sga.sql`](./05-script-creacion-sga.sql) y [`05-evidencia-ejecucion.log`](./05-evidencia-ejecucion.log) | **Nuevo** | Creé script DDL PostgreSQL 18 para el 100 % de las 16 tablas (`PK`, `21` `FK` con `ON DELETE/UPDATE`, `UNIQUE`, `CHECK` `RN-005`/`RN-007`) y adjunté ejecución real sin errores en `psql 18.6`. |
| **B6** Políticas de seguridad y matriz RBAC | [`06-politicas-seguridad-datos.md`](./06-politicas-seguridad-datos.md) | `03-execute/14-week/02-optional-activity/Normativa_Proyecto_SGA_Completa.docx` (marco legal) | Formulé **9 políticas concretas** (3 por Integridad, Confidencialidad y Disponibilidad), contraseñas `Argon2id/bcrypt` con sal, `TLS 1.3`, respaldo 30 copias y matriz de `5` roles $\times$ `16` tablas. |
| **B7** Lista de chequeo P1/P2 y hallazgos | [`07-lista-chequeo-y-hallazgos.md`](./07-lista-chequeo-y-hallazgos.md) | **Nuevo** (evolución metodológica de `G1-P2/06` y `07`) | Construí y diligencié **24 criterios medibles** con severidad y evidencia sobre P1 y P2, registrando **5 hallazgos técnicos (`H-01`..`H-05`)** corregidos y re-verificados. |

**Qué reutilicé (resumen):** Tomé como línea base el MER de 13 entidades de `G1-P2-estrada`, los módulos y diccionario inicial del SRS SGA en `03-execute/08-week/` y las normativas sanitarias del equipo en `03-execute/14-week/`.

**Qué ajusté para llevarlo al estándar de la rúbrica:** Incorporé `SEDE` para resolver dependencias transitivas en 3FN, separé el atributo multivaluado de teléfonos de pacientes en 1FN, modelé `notas_credito_debito` para garantizar la inmutabilidad real de `facturas` (`RN-014`), e implanté restricciones `CHECK` y acciones `ON DELETE` coherentes en las 16 tablas.

**Qué hice completamente nuevo:** La normalización formal `0FN -> 3FN` de dos tablas con dependencias funcionales (B3), el diccionario exhaustivo unificado (B4), el script SQL DDL PostgreSQL 18 ejecutado y validado en motor real (B5), las 9 políticas CIA + matriz RBAC de 5 roles (B6) y la auditoría cruzada de 24 criterios con 5 hallazgos subsanados sobre P1 y P2 (B7).

## 4. Autoverificación de mínimos

- [x] B1 Modelo conceptual: 14 entidades + 2 subtipos `TAB`/`TAM`, cardinalidades mín/máx, N:M y 1:N, justificación relacional
- [x] B2 Modelo lógico: 16 tablas con PK/FK y cuadro completo de reglas de transformación (incl. multivaluado y generalización)
- [x] B3 Normalización: 2 tablas propias llevadas paso a paso `0FN -> 3FN` con DF escritas (llave compuesta + transitividad)
- [x] B4 Diccionario de datos completo: 100 % de tablas y columnas idénticas al script SQL
- [x] B5 Script SQL ejecutado sin errores en **PostgreSQL 18.6** ([log adjunto](./05-evidencia-ejecucion.log)) y `ON DELETE` en 22 FK, `NOT NULL`, `UNIQUE` y 29 `CHECK` de dominio (`136` restricciones CHECK en catálogo)
- [x] B6 9 políticas de seguridad (3 por principio, con hash + sal en contraseñas, TLS 1.3, Ley 1581 y plan de restauración) + matriz de 5 roles $\times$ 16 tablas
- [x] B7 Lista de chequeo de 24 criterios medibles con severidad, diligenciada sobre P1 y P2 con evidencia y 5 hallazgos resueltos

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| Sábado 28 nov 2026 (antes 6:00 a. m.) | `feat(G2-P2): entregar modelos B1-B2, normalizacion 3FN, diccionario, SQL PostgreSQL 18 ejecutado, seguridad y verificacion B7` (construido el 27 nov y publicado en commit separado para P2). |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| **Antigravity AI Assistant** | Asistencia en generación XML/SVG de modelos ER, estructuración Markdown de B3/B4/B6/B7 y pruebas de ejecución automática contra PostgreSQL 18.6. | Validé manualmente todas las dependencias funcionales de 2FN/3FN, la paridad exacta 1:1 entre columnas del diccionario B4 y DDL B5, la separación estricta de permisos RBAC y cero cruces geométricos en diagramas. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [`08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-estrada/08-informe-analisis.md)
- Carpeta de esta entrega en GitHub: `https://github.com/MAET211/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-estrada`
- Entrega de diseño OOP y arquitectura (G2-P1): [`../G2-P1-estrada/README.md`](../G2-P1-estrada/README.md)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría (`MAET211`), que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.
