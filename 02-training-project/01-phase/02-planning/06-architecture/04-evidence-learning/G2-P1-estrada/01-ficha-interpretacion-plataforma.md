# A1 · Ficha de Interpretación del Análisis y Plataforma Tecnológica
**Evidencia:** Guía 2 · Producto 1 (`G2-P1`) — Artefacto A1  
**Competencia:** 220501095 · **RAP:** 593103 (Criterio 1)  
**Aprendiz:** `MAET211` (Carpeta: `G2-P1-estrada`)  
**Ficha:** 3413974 · ADSO · Proyecto Formativo: **Sistema Gestor de Ambulancias (SGA)**  
**Insumo Base:** [Informes y SRS de Guía 1 (`G1-P1` / `G1-P2`)](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-estrada/04-matriz-requisito-caso-uso.md)  

---

## 1. Selección de Requisitos del Análisis (Alcance Prioritario y Contexto Completo)

El proyecto completo del SGA abarca **65 Requisitos Funcionales (`RF-001` a `RF-065`)**, **29 Requisitos No Funcionales (`RNF-001` a `RNF-029`)** y **18 Reglas de Negocio (`RN-001` a `RN-018`)**. Para el diseño de software en esta entrega se priorizan **16 requisitos funcionales críticos** del núcleo operativo (superando el mínimo de 8 RF) y se mantiene cobertura estructural del **100 % del catálogo en la matriz A7**, junto con **8 requisitos no funcionales** de arquitectura, seguridad y desempeño:

### 1.1 Requisitos Funcionales Prioritarios (`RF` Seleccionados)

| ID (SRS) | Descripción Resumida del Requisito | Prioridad | Módulo / Caso de Uso |
|---|---|---|---|
| **RF-002** | Autenticación con correo/contraseña y emisión de token JWT con expiración máxima de 8 horas. | Alta | Autenticación (`CU-01`) |
| **RF-005** | Control de acceso basado en roles (RBAC) restringiendo módulos y acciones según 5 perfiles. | Alta | Autenticación (`CU-01`) |
| **RF-007** | Registro de intentos fallidos y bloqueo automático de cuenta por 30 minutos al superar 5 fallos (`RN-009`). | Alta | Autenticación (`CU-01.1`) |
| **RF-008** | Registro integral de ambulancias `TAB` y `TAM` con placa, número de unidad y habilitación REPS. | Alta | Ambulancias (`CU-08`) |
| **RF-011** | Control de vencimientos de SOAT, tecnomecánica y REPS, bloqueando asignación de móviles vencidos (`RN-003`). | Alta | Ambulancias (`CU-09`) |
| **RF-014** | Registro de personal asistencial con tarjeta profesional, certificaciones vigentes y unidad asignada (`RN-004`). | Alta | Personal (`CU-03`) |
| **RF-018** | Registro confidencial de pacientes bajo Ley 1581/2012, incluyendo contactos familiares y antecedentes. | Alta | Pacientes (`CU-02`) |
| **RF-021** | Radicación de solicitud de emergencia con ubicación, datos de solicitante y triage (`Rojo`, `Naranja`, `Amarillo`, `Verde`). | Alta | Emergencias (`CU-02`) |
| **RF-022** | Asignación automática de ambulancia en $\le 2\text{ segundos}$ evaluando tipo (`TAB/TAM`), disponibilidad y cercanía (`RN-001`, `RN-002`). | Alta | Emergencias (`CU-03`) |
| **RF-023** | Asignación manual por el coordinador exigiendo motivo obligatorio auditado (`RN-007`). | Alta | Emergencias (`CU-04`) |
| **RF-024** | Gestión integral de la máquina de 7 estados del servicio con registro cronológico de transiciones. | Alta | Emergencias (`CU-05`) |
| **RF-025** | Cierre formal del servicio validando resultado, estado final del paciente, destino y responsable (`RN-005`). | Alta | Emergencias (`CU-05`) |
| **RF-028** | Panel de monitoreo en tiempo real con diferenciación visual `TAB`/`TAM` vía WebSockets. | Alta | Monitoreo (`CU-07`) |
| **RF-031** | Generación automática e inmutable de factura al cerrar un servicio (`RN-014`); ajustes solo vía nota crédito/débito. | Alta | Financiero (`CU-11`) |
| **RF-040** | Radicación estructurada de PQRS con código único y asignación de responsable en $\le 24\text{ h}$ (`RN-011`). | Alta | PQRS (`CU-10`) |
| **RF-055** | Registro automático e inalterable en auditoría por mínimo 5 años (`RN-010`) de eventos CRUD y de seguridad. | Alta | Auditoría (`CU-06`) |

### 1.2 Requisitos No Funcionales Prioritarios (`RNF` bajo ISO/IEC 25010)

| ID (SRS) | Dimensión ISO 25010 | Métrica / Restricción Cuantitativa | Normativa Asociada |
|---|---|---|---|
| **RNF-001** | Seguridad | Almacenamiento de contraseñas con **hash + sal única** (`bcrypt` o `Argon2`); prohibido texto plano o cifrado reversible. | ISO/IEC 27001 / Res. 3100 |
| **RNF-002** | Seguridad | 100 % del tráfico cliente-servidor cifrado mediante **HTTPS con SSL/TLS 1.3** (redirección automática HTTP $\rightarrow$ HTTPS). | Seguridad en tránsito |
| **RNF-004** | Seguridad | Protección y cifrado en reposo para datos clínicos y demográficos sensibles de pacientes. | Ley 1581/2012 (Habeas Data) |
| **RNF-008** | Rendimiento | Consultas operativas críticas (flota disponible, asignaciones activas) en $\le 3\text{ segundos}$ bajo carga estándar. | Res. 3100 |
| **RNF-009** | Rendimiento | Ejecución del algoritmo de asignación automática de ambulancia en **$\le 2\text{ segundos}$** desde la radicación. | Oportunidad prehospitalaria |
| **RNF-010** | Eficiencia | Soporte mínimo para **$\ge 20$ usuarios concurrentes** sin degradación de tiempos ni bloqueos. | Capacidad operativa |
| **RNF-013** | Disponibilidad | Operación continua **24/7 con disponibilidad mínima del 97 %** y recuperación controlada ante fallos (`RNF-015`). | Sistemas misión crítica |
| **RNF-028** | Trazabilidad / Respaldo | Trazabilidad completa anterior/posterior (`JSONB`) y respaldo diario automático (`30` copias, `RTO <= 4 h`, `RPO <= 24 h`, `RNF-029`). | REPS Conservación 5 años |

### 1.3 Actores y Restricciones Operativas
- **Actores:** `Administrador` (parámetros, flota, contratos, auditoría), `Coordinador Operativo` (recepción, triage, despacho automático/manual y monitoreo), `Paramédico / Médico Tripulante` (atención en campo `TAB`/`TAM` y cierre REPS), `Usuario / Ciudadano` (radicación y consulta pública PQRS) y `Sistema Automático SGA` (motor de despacho, bloqueos `RN-009`, vencimientos `RN-003`).
- **Restricciones del Caso:** Equipo de 4 aprendices bajo metodología Scrum (`Sprints` de 2 semanas), despliegue inicial en servidor VPS Linux contenedorizado (`Docker`, 8 GB RAM, 4+ vCPU), obligatoriedad normativa colombiana (`Resolución 3100` / `REPS` y `Ley 1581/2012`) y compatibilidad web multidispositivo (`RNF-017`).

---

## 2. Definición y Justificación de la Plataforma Tecnológica

| Decisión Tecnológica | Selección Adoptada | Condiciones Concretas del Caso SGA que la Justifican ($\ge 3$) |
|---|---|---|
| **Lenguaje Orientado a Objetos y Runtime Backend** | **TypeScript 5 sobre Node.js 20 LTS (Express + Socket.IO)** | **1. Tiempo real nativo (`RF-009`, `RF-028`):** El servidor de eventos no bloqueante maneja conexiones `WebSockets` concurrentes ($\ge 20$ usuarios, `RNF-010`) y despacho algorítmico en $\le 2\text{ s}$ (`RNF-009`).<br>**2. Orientación a Objetos tipada:** Soporta interfaces estrictas (`IEstrategiaAsignacion`), modificadores (`private`/`protected`/`public`), herencia (`AmbulanciaTAB`/`TAM`) y polimorfismo para los patrones GoF `Strategy` y `Facade`.<br>**3. Coherencia del equipo y stack web:** Comparte tipado fuerte con la capa frontend web responsiva (`React`/`Vue`), reduciendo errores de contrato JSON en API REST (`SRS Sec. 3.3`). |
| **Tipo y Motor de Base de Datos** | **Base de Datos Relacional — PostgreSQL 18** | **1. Consistencia ACID crítica (`RN-001`):** Las transacciones con bloqueo impiden asignar simultáneamente la misma ambulancia a dos emergencias.<br>**2. Integridad normativa declarativa (`RN-003`, `RN-005`, `RN-014`):** Exige llaves foráneas estrictas (`ON DELETE RESTRICT`), `UNIQUE` en `placa`/`num_habilitacion_reps` y reglas `CHECK` para validar cierre clínico completo.<br>**3. Tipos nativos del SRS (`SRS Sec. 6.2`):** Provee soporte nativo para `UUID`, `JSONB` (instantáneas `valores_anteriores`/`valores_nuevos` de auditoría `RF-057`) e `INET`. |

---

## 3. Lista Completa de Entregables de Diseño

| Carpeta | Código | Artefacto | Archivo Principal |
|---|---|---|---|
| `G2-P1-estrada` | **A1** | Ficha de interpretación y plataforma tecnológica | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) |
| `G2-P1-estrada` | **A2** | Diagrama de clases OOP (editable + SVG + tabla) | [`02-diagrama-clases.md`](./02-diagrama-clases.md) / [`.drawio`](./02-diagrama-clases.drawio) / [`.svg`](./02-diagrama-clases.svg) |
| `G2-P1-estrada` | **A3** | Patrones de diseño GoF aplicados (`Strategy`, `Facade`) | [`03-patrones-de-diseno.md`](./03-patrones-de-diseno.md) |
| `G2-P1-estrada` | **A4** | Arquitectura en capas y decisiones frente a RNF | [`04-arquitectura-sistema.md`](./04-arquitectura-sistema.md) / [`.drawio`](./04-arquitectura-sistema.drawio) / [`.svg`](./04-arquitectura-sistema.svg) |
| `G2-P1-estrada` | **A5** | Vista de componentes e interfaces | [`05-vista-componentes.md`](./05-vista-componentes.md) / [`.drawio`](./05-vista-componentes.drawio) / [`.svg`](./05-vista-componentes.svg) |
| `G2-P1-estrada` | **A6** | Vista de despliegue y protocolos | [`06-vista-despliegue.md`](./06-vista-despliegue.md) / [`.drawio`](./06-vista-despliegue.drawio) / [`.svg`](./06-vista-despliegue.svg) |
| `G2-P1-estrada` | **A7** | Matriz de trazabilidad análisis $\leftrightarrow$ diseño | [`07-matriz-trazabilidad-diseno.md`](./07-matriz-trazabilidad-diseno.md) |
| `G2-P2-estrada` | **B1–B7** | Modelo de datos, normalización 3FN, diccionario, SQL, seguridad y auditoría | [`../G2-P2-estrada/README.md`](../G2-P2-estrada/README.md) |
