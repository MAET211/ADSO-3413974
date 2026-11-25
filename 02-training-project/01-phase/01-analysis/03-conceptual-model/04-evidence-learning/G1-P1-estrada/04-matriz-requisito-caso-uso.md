# 04 · Especificación de Casos de Uso y Matriz de Trazabilidad
## Proyecto Formativo: Sistema Gestor de Ambulancias (SGA)
### Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz:** Miguel Ángel Estrada Torrentes (GitHub: `MAET211` · Carpeta: `G1-P1-estrada`)  
**Fase del Proyecto:** 01 - Análisis | **Competencia:** 220501093 | **RAP:** 592373 (Criterios C3 y C4)  

---

## 1. Identificación de Actores del Sistema

Para dar cumplimiento a los estándares UML y la **Sección 7 (Regla 6) de las Rúbricas de Calificación**, los actores se modelan formalmente en el exterior de la frontera del sistema SGA:

### 1.1. Actores Primarios (Iniciadores de Casos de Uso)
1. **Administrador del Sistema (Actor Primario - Operativo/Seguridad):** Profesional o técnico encargado de la configuración global de la plataforma, parametrización de sedes, gestión del personal, control del catálogo de ambulancias, contratos de proveedores y auditoría general.
2. **Coordinador Operativo (Actor Primario - Despacho y Triage):** Tecnólogo en salud o despachador prehospitalario responsable de la recepción de llamadas de emergencia, valoración y clasificación de prioridad clínica (triage), despacho manual/supervisado de unidades y monitoreo dinámico de la flota.
3. **Paramédico / Médico Tripulante (Actor Primario - Asistencial en Campo):** Profesional de salud o técnico en atención prehospitalaria (en unidades TAB o TAM); recibe el servicio asignado, actualiza el estado operativo durante el trayecto, diligencia la valoración clínica inicial y ejecuta el cierre formal de la atención.
4. **Usuario / Ciudadano (Actor Primario - Externo):** Persona solicitante o usuario del servicio de salud que radica peticiones, quejas, reclamos, sugerencias o denuncias (PQRS) y consulta el estado de su trámite mediante el código de radicado único sin requerir inicio de sesión.

### 1.2. Actores Secundarios y Procesos Automáticos
5. **Sistema Automático SGA / Demonio Background (Actor de Sistema / Ejecutor de Reglas):** Proceso demonio en segundo plano (Cron jobs y servicios de servidor) que ejecuta tareas autónomas: motor de asignación automática de ambulancias en $\le 2$ segundos, verificación continua de vencimiento de documentos y contratos, expiración de tokens JWT y bloqueo automático de cuentas tras 5 intentos fallidos consecutivos.

---

## 2. Catálogo de Casos de Uso (Notación Verbo + Objeto)

En estricta observancia de la **Sección 7 (Regla 1: Agrupación de CRUDs)** de la rúbrica oficial, las operaciones técnicas CRUD (Crear, Leer, Actualizar, Eliminar) se consolidan dentro de objetivos de negocio unificados:

* **CU-01: Autenticar usuario y emitir token JWT:** Valida las credenciales de acceso del usuario y genera un token JWT con tiempo de expiración configurable (máximo 8 horas) para regular el acceso por roles (RBAC).
* **CU-01.1: Bloquear cuenta por intentos fallidos:** Acción de seguridad automática que suspende el acceso al usuario durante 30 minutos tras acumular 5 fallos consecutivos de autenticación (Regla RN-009).
* **CU-02: Radicar solicitud de emergencia:** Registra la llamada de auxilio capturando hora, ubicación, datos del solicitante y la prioridad clínica (Triage: Rojo, Naranja, Amarillo, Verde).
* **CU-03: Asignar ambulancia automáticamente (TAB / TAM):** Algoritmo del sistema que evalúa en $\le 2$ segundos las unidades libres, tipo requerido por prioridad clínica (TAB vs TAM) y cercanía geográfica, despachando la unidad óptima.
* **CU-04: Asignar ambulancia con justificación manual:** Permite al coordinador operativo seleccionar manualmente una ambulancia diferente a la sugerida por el algoritmo, exigiendo el registro obligatorio del motivo técnico (Regla RN-007).
* **CU-05: Realizar cierre formal de servicio:** Culmina formalmente la atención asistencial exigiendo resultado, estado final del paciente y centro hospitalario de destino conforme a la Resolución 3100 de 2019.
* **CU-06: Auditar evento transaccional inmutable:** Registro automático y no alterable de cada acción crítica en el log del sistema, con retención garantizada por mínimo 5 años.
* **CU-07: Monitorear flota y estados en tiempo real:** Visualización continua en tablero dinámico (vía WebSockets) del estado y disponibilidad de las unidades TAB y TAM.
* **CU-08: Gestionar inventario de ambulancias:** Administración centralizada de la flota vehicular (altas, bajas lógicas, mantenimientos preventivos y hojas de vida).
* **CU-09: Validar habilitación REPS y vencimientos:** Control automatizado de la vigencia de SOAT, revisión técnico-mecánica y habilitación REPS, bloqueando unidades no aptas (Regla RN-003).
* **CU-10: Radicar y consultar solicitudes PQRS:** Permite a los ciudadanos radicar quejas o solicitudes con código único y consultar su estado en tiempo real.
* **CU-11: Generar factura inmutable de servicio:** Emisión automática e inalterable del comprobante de liquidación del servicio una vez finalizada la atención (Regla RN-014).

---

## 3. Justificación de Relaciones «include» y «extend» (Regla de Arbitraje Sección 7)

Cumpliendo con la **Sección 7 (Regla 2)** de la rúbrica oficial, se justifica en una sola línea técnica cada relación modelada:

| Caso de Uso Origen | Relación UML | Caso de Uso Destino | Justificación Técnica de la Relación (1 Línea Obligatoria) |
| :--- | :---: | :--- | :--- |
| **CU-01 (Autenticar Usuario)** | `<<extend>>` | **CU-01.1 (Bloquear Cuenta)** | Extensión condicional que solo se dispara cuando el usuario supera el umbral de 5 intentos fallidos (RN-009). |
| **CU-02 (Radicar Solicitud)** | `<<include>>` | **CU-03 (Asignar Automática)** | Toda radicación de emergencia dispara obligatoriamente el motor de asignación en menos de 2 segundos (RF-022). |
| **CU-04 (Asignar Manual)** | `<<extend>>` | **CU-03 (Asignar Automática)** | Extensión opcional que solo se ejecuta cuando el coordinador decide anular la sugerencia automática por contingencia vial (RN-007). |
| **CU-05 (Cerrar Servicio)** | `<<include>>` | **CU-11 (Generar Factura)** | El cierre formal del servicio asistencial exige obligatoriamente la emisión de la factura inmutable del servicio (RF-031). |
| **CU-05 (Cerrar Servicio)** | `<<include>>` | **CU-06 (Auditar Evento)** | Toda finalización asistencial requiere por normativa sanitaria el registro inalterable en la bitácora de auditoría (RF-055). |
| **CU-08 (Gestionar Ambulancias)**| `<<include>>` | **CU-09 (Validar REPS)** | Toda consulta o asignación de ambulancias requiere la verificación previa obligatoria de documentos y habilitación REPS (RN-003). |

---

## 4. Distinción entre Requisitos Funcionales y No Funcionales

Para dar estricto cumplimiento al **Criterio C3 de la Rúbrica G1**:
* **Requisitos Funcionales (RF):** Describen las funciones, servicios y comportamientos directos que el SGA ejecuta para los usuarios (ej. radicar emergencia, asignar ambulancia TAB/TAM, calcular mora, emitir factura). Se detallan del **RF-001 al RF-065** en la matriz inferior.
* **Requisitos No Funcionales (RNF):** Atributos de calidad, rendimiento y restricciones técnicas bajo **ISO/IEC 25010** que determinan cómo debe comportarse el software:
  * *Seguridad:* RNF-001 (Hash bcrypt/Argon2), RNF-002 (Cifrado HTTPS SSL/TLS), RNF-004 (Cifrado en reposo para datos de salud Ley 1581).
  * *Rendimiento:* RNF-008 (Respuesta $\le 3$ s), RNF-009 (Asignación automática $\le 2$ s), RNF-010 (Capacidad de 20+ usuarios concurrentes).
  * *Disponibilidad:* RNF-013 (Uptime mínimo del 97% 24/7 para servicios de misión crítica).
  * *Usabilidad:* RNF-016 (Registro y despacho en máximo 4 pasos desde la recepción).

---

## 5. Matriz de Cobertura Requisito Funcional → Caso de Uso

La siguiente matriz cubre el **100% de los 65 Requisitos Funcionales** del documento SRS oficial (superando ampliamente el 90% exigido por la rúbrica):

| Requisito Funcional (SRS) | Caso de Uso que lo Atiende | Tipo de Cobertura | Módulo del SGA |
| :--- | :--- | :---: | :--- |
| **RF-001** (Registro y CRUD de usuarios con auditoría) | CU-01 (Autenticar) / CU-06 (Auditar) | Directa (100%) | Autenticación |
| **RF-002** (Autenticación con emisión de JWT) | CU-01: Autenticar usuario y emitir JWT | Directa (100%) | Autenticación |
| **RF-003** (Cierre de sesión automático por inactividad) | CU-01: Autenticar usuario y emitir JWT | Directa (100%) | Autenticación |
| **RF-004** (Recuperación de contraseña segura) | CU-01: Autenticar usuario y emitir JWT | Directa (100%) | Autenticación |
| **RF-005** (Control de acceso RBAC por perfiles) | CU-01: Autenticar usuario y emitir JWT | Directa (100%) | Autenticación |
| **RF-006** (Asignación y modificación de roles con auditoría) | CU-01 (Autenticar) / CU-06 (Auditar) | Directa (100%) | Autenticación |
| **RF-007** (Bloqueo automático tras 5 intentos fallidos) | CU-01.1: Bloquear cuenta por intentos | Directa (100%) | Autenticación |
| **RF-008** (Registro integral de ambulancias TAB/TAM y REPS) | CU-08: Gestionar inventario de ambulancias | Directa (100%) | Ambulancias |
| **RF-009** (Actualización de estados en tiempo real) | CU-07: Monitorear flota WebSockets | Directa (100%) | Ambulancias |
| **RF-010** (Consulta de inventario con filtros por tipo/sede) | CU-08: Gestionar inventario de ambulancias | Directa (100%) | Ambulancias |
| **RF-011** (Control de vencimiento SOAT/Tecnomecánica/REPS)| CU-09: Validar habilitación REPS | Directa (100%) | Ambulancias |
| **RF-012** (Historial de mantenimientos preventivos y costos)| CU-08: Gestionar inventario de ambulancias | Directa (100%) | Ambulancias |
| **RF-013** (Inventario de dotación médica Res. 3100 de 2019) | CU-08 (Gestionar) / CU-09 (Validar) | Directa (100%) | Ambulancias |
| **RF-014** (Registro de personal médico con tarjeta profesional)| CU-01 (RBAC) / CU-03 (Despacho) | Directa (100%) | Personal |
| **RF-015** (Control de disponibilidad de personal en tiempo real)| CU-03 (Despacho) / CU-07 (Monitoreo) | Directa (100%) | Personal |
| **RF-016** (Control de vencimiento de certificaciones médicas) | CU-03: Asignar ambulancia automática | Directa (100%) | Personal |
| **RF-017** (Historial de servicios de personal y horas laborales)| CU-05: Realizar cierre formal | Directa (100%) | Personal |
| **RF-018** (Registro seguro de pacientes bajo Ley 1581/2012) | CU-02: Radicar solicitud de emergencia | Directa (100%) | Pacientes |
| **RF-019** (Registro de estado clínico inicial del paciente) | CU-02: Radicar solicitud de emergencia | Directa (100%) | Pacientes |
| **RF-020** (Consulta de historial asistencial del paciente) | CU-02: Radicar solicitud de emergencia | Directa (100%) | Pacientes |
| **RF-021** (Captura de llamada de auxilio y triage clínico) | CU-02: Radicar solicitud de emergencia | Directa (100%) | Emergencias |
| **RF-022** (Asignación automática de ambulancia en $\le 2$ s) | CU-03: Asignar ambulancia automática | Directa (100%) | Emergencias |
| **RF-023** (Asignación manual con justificación obligatoria) | CU-04: Asignar con justificación manual | Directa (100%) | Emergencias |
| **RF-024** (Gestión de máquina de estados del servicio) | CU-05: Realizar cierre formal | Directa (100%) | Emergencias |
| **RF-025** (Validación obligatoria de variables clínicas al cerrar)| CU-05: Realizar cierre formal | Directa (100%) | Emergencias |
| **RF-026** (Cancelación justificada solo en Solicitado/Asignado)| CU-05 (Cierre) / CU-06 (Auditoría) | Directa (100%) | Emergencias |
| **RF-027** (Consulta y exportación del historial de servicios) | CU-05: Realizar cierre formal | Directa (100%) | Emergencias |
| **RF-028** (Panel central WebSockets con diferenciación TAB/TAM)| CU-07: Monitorear flota WebSockets | Directa (100%) | Monitoreo |
| **RF-029** (Indicadores clave de flota y alertas críticas) | CU-07: Monitorear flota WebSockets | Directa (100%) | Monitoreo |
| **RF-030** (Registro de ingresos y egresos de proveedores) | CU-11: Generar factura inmutable | Directa (100%) | Financiero |
| **RF-031** (Emisión automatizada de facturas inmutables) | CU-11: Generar factura inmutable | Directa (100%) | Financiero |
| **RF-032** (Gestión de cartera y cálculo automático de mora) | CU-11: Generar factura inmutable | Directa (100%) | Financiero |
| **RF-033** (Reportes financieros y alertas de cobranza) | CU-11: Generar factura inmutable | Directa (100%) | Financiero |
| **RF-034** (Generación de recibos de pago en PDF inmutables) | CU-11: Generar factura inmutable | Directa (100%) | Financiero |
| **RF-035** (Consulta de estado de cuenta para entidades) | CU-11: Generar factura inmutable | Directa (100%) | Financiero |
| **RF-036** (Registro de acceso físico de visitantes y vehículos)| CU-08: Gestión administrativa | Directa (100%) | Visitantes |
| **RF-037** (Validación de identidad y alertas por sobreestadía)| CU-08: Gestión administrativa | Directa (100%) | Visitantes |
| **RF-038** (Pre-autorizaciones de visita por usuarios internos)| CU-08: Gestión administrativa | Directa (100%) | Visitantes |
| **RF-039** (Historial y estadísticas de afluencia de visitas)| CU-08: Gestión administrativa | Directa (100%) | Visitantes |
| **RF-040** (Radicación estructurada de PQRS con radicado único)| CU-10: Radicar y consultar PQRS | Directa (100%) | PQRS |
| **RF-041** (Asignación obligatoria de responsable en $\le 24$ h)| CU-10: Radicar y consultar PQRS | Directa (100%) | PQRS |
| **RF-042** (Consulta pública de PQRS sin inicio de sesión) | CU-10: Radicar y consultar PQRS | Directa (100%) | PQRS |
| **RF-043** (Respuesta formal con soportes y alerta de plazo) | CU-10: Radicar y consultar PQRS | Directa (100%) | PQRS |
| **RF-044** (Historial inmutable y reportes de satisfacción PQRS)| CU-10: Radicar y consultar PQRS | Directa (100%) | PQRS |
| **RF-045** (Registro de propietarios y vinculación de unidades)| CU-08: Gestionar inventario de ambulancias | Directa (100%) | Unidades |
| **RF-046** (Control de estado contractual e historial de cambios)| CU-08: Gestionar inventario de ambulancias | Directa (100%) | Unidades |
| **RF-047** (Registro de proveedores y contratos con alertas) | CU-08: Gestión de proveedores | Directa (100%) | Proveedores |
| **RF-048** (Bloqueo de vinculación a contratos vencidos) | CU-08: Gestión de proveedores | Directa (100%) | Proveedores |
| **RF-049** (Evaluación de desempeño de proveedores) | CU-08: Gestión de proveedores | Directa (100%) | Proveedores |
| **RF-050** (Carga de documentos con validación MIME y hash) | CU-08: Repositorio documental | Directa (100%) | Documental |
| **RF-051** (Versionamiento automático y control de duplicados)| CU-08: Repositorio documental | Directa (100%) | Documental |
| **RF-052** (Búsqueda y visualización integrada de archivos) | CU-08: Repositorio documental | Directa (100%) | Documental |
| **RF-053** (Descarga documental controlada por RBAC) | CU-08 (Documental) / CU-01 (RBAC) | Directa (100%) | Documental |
| **RF-054** (Estructura jerárquica de carpetas documentales) | CU-08: Repositorio documental | Directa (100%) | Documental |
| **RF-055** (Registro automático de eventos CRUD y logins) | CU-06: Auditar evento transaccional | Directa (100%) | Auditoría |
| **RF-056** (Inmutabilidad técnica del log por mínimo 5 años)| CU-06: Auditar evento transaccional | Directa (100%) | Auditoría |
| **RF-057** (Consulta de bitácora con valores antiguos y nuevos)| CU-06: Auditar evento transaccional | Directa (100%) | Auditoría |
| **RF-058** (Detección de patrones anómalos de seguridad) | CU-06: Auditar evento transaccional | Directa (100%) | Auditoría |
| **RF-059** (Registro de incidentes operativos y fallas técnicas)| CU-07 (Monitoreo) / CU-05 (Servicio) | Directa (100%) | Novedades |
| **RF-060** (Flujo de vida de novedades: Pendiente a Cerrado)| CU-05: Realizar cierre formal | Directa (100%) | Novedades |
| **RF-061** (Alertas por superación de tiempos de resolución) | CU-07: Monitorear flota WebSockets | Directa (100%) | Novedades |
| **RF-062** (Adjuntos multimedia y comentarios en hilo) | CU-05: Realizar cierre formal | Directa (100%) | Novedades |
| **RF-063** (Reportes de incidentes por ambulancia) | CU-08: Gestionar inventario de ambulancias | Directa (100%) | Novedades |
| **RF-064** (Generación parametrizada de reportes en PDF/Excel)| CU-07 (Monitoreo) / CU-11 (Factura) | Directa (100%) | Reportes |
| **RF-065** (Visualización interactiva de KPIs prehospitalarios)| CU-07: Monitorear flota WebSockets | Directa (100%) | Reportes |
