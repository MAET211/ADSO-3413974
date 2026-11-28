# Informe Técnico de Análisis Conceptual · Sistema Gestor de Ambulancias (SGA)
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592373 (Criterio C8) — Documenta las actividades de análisis a través de un informe técnico estructurado  
**Formato Oficial:** Anexo E (`Rubricas_G1.md` y `Plantilla_README_Entrega_G1.md`)  
**Aprendiz Autor:** `MAET211` (Carpeta: `G1-P2-estrada`)  
**Ficha:** 3413974 · ADSO · Centro de la Industria, la Empresa y los Servicios (CIES - Regional Huila)  
**Fecha:** 25 al 27 de noviembre de 2026  

---

## 1. Introducción y Propósito del Informe

El presente informe consolida los resultados del análisis y modelado conceptual para el **Sistema Gestor de Ambulancias (SGA)**, orientado a optimizar la atención de emergencias prehospitalarias, la gestión integral de flota de ambulancias (Básicas - `TAB` y Medicalizadas - `TAM`), la asignación automática o justificada de unidades según prioridad clínica (triage), el cumplimiento normativo REPS (Resolución 3100) y el cierre formal de servicios con facturación inmutable y auditoría transaccional.

El documento sintetiza la interpretación oficial de los requisitos del SRS institucional, enlaza todos los modelos gráficos y textuales construidos, expone los indicadores de la lista de chequeo y documenta las mejoras de ingeniería aplicadas a lo largo de tres ciclos de revisión (Días 1, 2 y 3).

---

## 2. Requisitos Interpretados del Sistema

A partir del Documento de Especificación de Requisitos de Software (**SRS Oficial del SGA**, Secciones 4, 5 y 6), se consolidaron e interpretaron dos dimensiones estructurales de requerimientos:

### 2.1 Requisitos Funcionales (`RF-001` a `RF-065`)
Se analizaron y trazaron integralmente **65 Requisitos Funcionales** estructurados en **15 módulos oficiales**:
1. **Autenticación (`RF-001` a `RF-007`):** Registro y CRUD de usuarios con auditoría, autenticación mediante tokens JWT (máximo 8 h), cierre automático tras 15 min de inactividad, recuperación segura de contraseña (enlace 30 min), control RBAC de cinco roles, trazabilidad de cambios de privilegios y bloqueo automático por 30 min tras 5 intentos fallidos (`RN-009`).
2. **Ambulancias (`RF-008` a `RF-013`):** Registro integral de unidades `TAB`/`TAM` con placa y código REPS, actualización de estado en tiempo real vía WebSockets, filtros de inventario, control de vencimientos de SOAT/técnico-mecánica/REPS con bloqueo automático (`RN-003`), historial de mantenimientos y dotación médica Resolución 3100.
3. **Personal (`RF-014` a `RF-017`):** Registro de tripulación con tarjeta profesional y certificaciones, control de disponibilidad en tiempo real, bloqueo automático por certificaciones expiradas (`RN-004`) y control de jornadas continuas y horas laborales.
4. **Pacientes (`RF-018` a `RF-020`):** Registro confidencial de pacientes bajo Ley 1581/2012 y RBAC, estado clínico inicial vinculado al servicio e historial de atenciones.
5. **Emergencias (`RF-021` a `RF-027`):** Captura de solicitud con prioridad clínica (`Verde`, `Amarillo`, `Naranja`, `Rojo`), algoritmo de asignación automática en $\le 2\text{ segundos}$, asignación manual con justificación obligatoria (`RN-007`), máquina completa de 7 estados (`Solicitado` $\rightarrow$ `Finalizado`/`Cancelado`), validación obligatoria de cierre (`RN-005`), cancelación restringida solo a etapas iniciales (`RN-006`) y exportación del historial.
6. **Monitoreo (`RF-028` a `RF-029`):** Panel centralizado en tiempo real por WebSockets diferenciando unidades `TAB`/`TAM` y mostrando KPIs y alertas críticas operativas.
7. **Financiero (`RF-030` a `RF-035`):** Registro de ingresos/egresos con proveedores, generación automática e **inmutable** de facturas al cierre del servicio (`RN-014`, ajustes únicamente vía nota crédito/débito), gestión de cartera con cálculo de mora desde el día 1 vencido y bloqueo desde el día 30 (`RN-015`), alertas de cobranza, recibos PDF y consulta de estado de cuenta.
8. **Visitantes (`RF-036` a `RF-039`):** Control físico de ingreso/egreso de visitantes y vehículos en sedes, pre-autorizaciones internas, alertas de sobreestadía (`RN-017`) y estadísticas de visitas.
9. **PQRS (`RF-040` a `RF-044`):** Radicación estructurada (Petición, Queja, Reclamo, Sugerencia, Denuncia) con radicado único, asignación obligatoria de responsable en $\le 24\text{ horas}$ (`RN-011`), consulta pública sin sesión iniciada, respuestas con soporte y trazabilidad inalterable.
10. **Unidades (`RF-045` a `RF-046`):** Registro de propietarios vinculados contractualmente, control de estados contractuales (activa, suspendida, retirada) e historial de cambios sin pérdida de datos previos.
11. **Proveedores (`RF-047` a `RF-049`):** Registro de proveedores y contratos con alertas de vencimiento a 30, 15 y 5 días, bloqueo de contratos vencidos (`RN-012`) y evaluación de desempeño.
12. **Documental (`RF-050` a `RF-054`):** Repositorio con validación MIME/tamaño, versionamiento automático con detección de duplicados por hash (`RN-013`), previsualización integrada, control RBAC de descargas y organización jerárquica.
13. **Auditoría (`RF-055` a `RF-058`):** Registro automático de eventos CRUD, autenticación, asignaciones y estados; almacenamiento técnicamente inmutable por mínimo 5 años (`RN-010`), consulta con valores anteriores/nuevos y detección de patrones anómalos.
14. **Novedades (`RF-059` a `RF-063`):** Registro tipificado de incidentes y fallas vinculados a servicio, unidad o personal (`RN-016`), ciclo de vida (`Pendiente` $\rightarrow$ `Cerrado`), alertas por superación de SLA, evidencia multimedia en hilo y reportes.
15. **Reportes (`RF-064` a `RF-065`):** Generación parametrizada y programada en PDF/Excel (`RN-018`) e indicadores interactivos de desempeño prehospitalario.

### 2.2 Requisitos No Funcionales (`RNF-001` a `RNF-029`) bajo ISO/IEC 25010
Los **29 Requisitos No Funcionales** del SRS se clasificaron conforme al estándar internacional **ISO/IEC 25010 (SQuaRE)** y normativa colombiana de salud:
- **Seguridad (`RNF-001` a `RNF-007`):** Hash de contraseñas (`bcrypt`/`Argon2`), comunicaciones exclusivas por `HTTPS` con `SSL/TLS`, RBAC estricto, cifrado de datos sensibles en reposo (Ley 1581/2012), renovación de contraseñas cada 90 días (`RN-008`), sanitización contra OWASP Top 10 (SQLi, XSS, CSRF) y confirmación auditada de acciones críticas.
- **Rendimiento (`RNF-008` a `RNF-012`):** Respuesta de consultas críticas $\le 3\text{ segundos}$ (`RNF-008`), ejecución de asignación automática de ambulancia en $\le 2\text{ segundos}$ (`RNF-009`), soporte mínimo para 20 usuarios concurrentes (`RNF-010`), carga de interfaces $\le 5\text{ segundos}$ y priorización de operaciones vitales bajo carga alta.
- **Disponibilidad (`RNF-013` a `RNF-015`):** Operación continua `24/7` con disponibilidad mínima garantizada del **97 %** (`RNF-013`), ventanas de mantenimiento controladas y recuperación ante fallos con monitoreo permanente.
- **Usabilidad (`RNF-016` a `RNF-020`):** Registro y asignación de emergencia en máximo **4 pasos** (`RNF-016`), diseño responsivo multi-navegador sin clientes adicionales, mensajes de error accionables (`RNF-018`) y priorización visual en el tablero principal.
- **Escalabilidad y Compatibilidad (`RNF-021` a `RNF-024`):** Conservación estructurada para mínimo 5 años (REPS), arquitectura contenedorizable (Docker), operación en Windows/macOS/Linux y exportación estándar compatible con Microsoft Office y LibreOffice.
- **Mantenibilidad, Trazabilidad y Respaldo (`RNF-025` a `RNF-029`):** Arquitectura modular desacoplada, documentación técnica bajo estándares de codificación, trazabilidad completa de ciclo de servicio (estado previo/posterior) y respaldos automáticos diarios con retención de al menos 30 copias (`RTO <= 4 h`, `RPO <= 24 h`).

---

## 3. Catálogo de Modelos y Artefactos Construidos

Los modelos conceptuales y especificaciones de análisis se encuentran versionados con fuentes editables XML y renders vectoriales limpios:

1. **Diagrama de Casos de Uso del Sistema (12 Casos de Uso, `G1-P1`):**
   - Imagen vectorial (`0 cruces`): [`03-diagrama-casos-de-uso.svg`](../G1-P1-estrada/03-diagrama-casos-de-uso.svg)
   - Fuente editable Draw.io: [`03-diagrama-casos-de-uso.drawio`](../G1-P1-estrada/03-diagrama-casos-de-uso.drawio)
2. **Diagramas de Actividades con Calles y Concurrencia (`DA-01` y `DA-02`):**
   - Imagen vectorial (`0 cruces`): [`01-diagramas-actividades.svg`](./01-diagramas-actividades.svg)
   - Fuente editable Draw.io: [`01-diagramas-actividades.drawio`](./01-diagramas-actividades.drawio)
3. **Plantillas Extendidas de Casos de Uso Críticos (Anexo A: `CU-03`, `CU-04`, `CU-05`):**
   - Especificación formal en lenguaje de dominio: [`02-plantillas-casos-de-uso.md`](./02-plantillas-casos-de-uso.md)
   - Casos complementarios del catálogo (`G1-P1`): [`05-especificacion-casos-de-uso.md`](../G1-P1-estrada/05-especificacion-casos-de-uso.md)
4. **Modelo Conceptual de Dominio (13 Clases Conceptuales):**
   - Imagen vectorial (`0 cruces`): [`03-modelo-dominio.svg`](./03-modelo-dominio.svg)
   - Fuente editable Draw.io: [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio)
5. **Modelo Entidad-Relación (13 Entidades Relacionales - Notación Crow's Foot):**
   - Imagen vectorial (`0 cruces`): [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg)
   - Fuente editable Draw.io: [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio)
6. **Prototipo Inicial de Interfaz (3 Pantallas Rotuladas: `P-01`, `P-02`, `P-03`):**
   - Mockups sincronizados con el SRS y diccionario de controles: [`05-prototipo-mockups.md`](./05-prototipo-mockups.md)
7. **Instrumentos de Validación, Ajustes y Trazabilidad:**
   - Lista de Chequeo de Análisis (16 criterios, Anexo B): [`06-lista-chequeo-validacion.md`](./06-lista-chequeo-validacion.md)
   - Registro de Ajustes Formal (12 hallazgos, Anexo D): [`07-registro-de-ajustes.md`](./07-registro-de-ajustes.md)
   - Matriz de Trazabilidad Integral (65/65 RFs, Anexo C): [`09-matriz-trazabilidad-anexo-c.md`](./09-matriz-trazabilidad-anexo-c.md)

---

## 4. Resultado de la Verificación Técnica

La auditoría cruzada de los artefactos y la aplicación de la Lista de Chequeo (Anexo B) produjeron los siguientes resultados verificables:
- **Criterios totales auditados:** 16 criterios objetivos dicotómicos (con 4 criterios dedicados de cobertura/trazabilidad).
- **Criterios conformes tras los ajustes:** **16 / 16 (100 %)**.
- **Integridad geométrica de diagramas (`.svg` y `.drawio`):** **0 cruces de líneas** y **0 colisiones de conectores con cajas** en los 4 diagramas dobles (8 archivos verificados automáticamente).
- **Cobertura en Matriz Anexo C (`09-matriz-trazabilidad-anexo-c.md`):** **100 % (65 de 65 requisitos funcionales reales)** trazados íntegramente entre los **12 casos de uso**, las **13 clases de dominio** y las **13 entidades del MER**, superando el mínimo del 90 % exigido por el criterio C8.

---

## 5. Resumen de Ajustes y Mejoras Implementadas (Ciclos Días 1, 2 y 3)

Los **12 hallazgos** documentados formalmente en [`07-registro-de-ajustes.md`](./07-registro-de-ajustes.md) consolidaron la evolución técnica del análisis:
1. **Dirección estricta en `<<extend>>` (`G1-P1`):** Corrección de la orientación de `CU-04` $\rightarrow$ `CU-03`.
2. **Purificación del Modelo de Dominio:** Eliminación de claves foráneas y tipos SQL físicos en las clases conceptuales.
3. **Resolución relacional N:M (`PERSONAL_SERVICIO`):** Incorporación de entidad asociativa con rol y marcas temporales entre `SERVICIO` y `PERSONAL`.
4. **Guardas exhaustivas en Actividades:** Uso de guardas formales entre corchetes en todas las decisiones.
5. **Precondiciones puras en Plantillas:** Traslado de validaciones dinámicas a flujos alternos/excepciones (`Anexo A`).
6. **Semántica de tipos conceptuales:** Reemplazo de `boolean` por `Booleano (Si/No)` en `Factura`.
7. **Clave compuesta identificadora en Entidad Débil:** Adopción estricta de `(servicio_id, numero_secuencia)` en `HISTORIAL_ESTADOS_SERVICIO`.
8. **Etiquetas nativas de multiplicidad:** Uso de `edgeLabel` en Draw.io separando origen y destino.
9. **Rediseño topológico cero cruces (Día 3):** Eliminación total de intersecciones y colisiones en `.drawio` y `.svg` para Casos de Uso, Actividades (enmarque del *Fork/Join* paralelo en carril 3 de `DA-02`), Dominio (`95 px` de despeje en herencia `Ambulancia` $\rightarrow$ `TAB`/`TAM`) y MER (corredores ortogonales limpios).
10. **Paridad semántica de modelos y matriz Anexo C (Día 3):** Ampliación del Modelo de Dominio a **13 clases** (incorporando `Rol` y `Usuario`) y del MER a **13 entidades** (`ROL`, `USUARIO`, `AUDITORIA`, `NOVEDAD`, `FACTURA`, `SERVICIO` con campos `RN-005`), erradicando entidades fantasma y casos inexistentes en `09-matriz-trazabilidad-anexo-c.md`.
11. **Alineación real de Mockups y Anonimización (Día 3):** Reemplazo en `P-03` de reglas ficticias por cierre REPS (`RN-005`) + factura inmutable (`CU-11`/`RN-014`), actualización de los 15 módulos/29 RNFs reales y supresión total de nombres humanos inventados o sufijos personales.
12. **Eliminación de duplicación documental y citas exactas (Día 3):** Especialización de `G1-P1/05` para casos complementarios y corrección de citas de líneas/rutas reales de `03-execute/` en `06-lista-chequeo-validacion.md` y `README.md`.

---

## 6. Dictamen Final

La documentación y los modelos de análisis del **Sistema Gestor de Ambulancias (SGA)** cumplen al **100 %** con las exigencias metodológicas, sintácticas y de trazabilidad de la Rúbrica de Guía 1 (`RAP 592373` y `RAP 592374`), quedando verificados y listos para la fase de Arquitectura y Diseño (Guía 2).
