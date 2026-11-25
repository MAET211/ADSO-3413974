# 01 · Caracterización de la Solución y Comparación de Metodologías
## Proyecto Formativo: Sistema Gestor de Ambulancias (SGA)
### Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz:** Miguel Ángel Estrada Torrentes (GitHub: `MAET211` · Carpeta: `G1-P1-estrada`)  
**Fase del Proyecto:** 01 - Análisis | **Competencia:** 220501093 | **RAP:** 592375 (Criterio C1)  

---

## 1. Caracterización de la Solución de Software

Para dar estricto cumplimiento al **Criterio C1 de la Rúbrica G1 (RAP 592375)**, se analiza y caracteriza la solución técnica del **Sistema de Gestión de Ambulancias (SGA)** evaluando los cuatro (4) aspectos estructurales del software a construir:

| Aspecto Estructural | Característica Específica en el Sistema SGA | Justificación Técnica e Impacto en el Ciclo de Vida |
| :--- | :--- | :--- |
| **1. Tipo de Proyecto** | **Aplicación Web Distribuida y de Misión Crítica Operativa.**<br>Sistema de coordinación prehospitalaria con arquitectura Cliente-Servidor desacoplada (Frontend SPA responsivo, Backend API REST y canal WebSockets para eventos de flota en tiempo real). | En la atención de emergencias médicas cada segundo cuenta. El software exige tiempos de procesamiento ultrarrápidos ($\le 2$ segundos en asignación de unidades) y alta disponibilidad operativa ($97\%$ 24/7). Debe operar en navegadores de escritorio (estaciones de despacho del coordinador) y tabletas táctiles (tripulación en campo), sin requerir instalaciones pesadas ni dependencias de tiendas móviles. |
| **2. Tamaño del Equipo** | **Equipo multidisciplinario de cuatro (4) aprendices desarrolladores.**<br>• Miguel Ángel Estrada Torrentes (Scrum Master / Analista de Requisitos)<br>• Nicolás Esteban Aldana Doria (Backend Developer)<br>• Juan Miguel Muñoz Castañeda (Frontend Developer)<br>• Juan José Horta Méndez (Fullstack Developer) | Un equipo pequeño de 4 desarrolladores requiere una metodología liviana con roles definidos, sin burocracia documental paralizante, permitiendo asignación modular paralela (ej. capa de persistencia y lógica de despacho separadas de la interfaz de usuario) y comunicación técnica diaria fluida. |
| **3. Estabilidad de Requisitos** | **Alta y Estricta (Regulada por el Marco Sanitario de Colombia).**<br>El núcleo funcional y las reglas operativas están blindados por el marco legal de salud: **Resolución 3100 de 2019** (modificada por Res. 544 de 2023 / transición Res. 1732 de 2026), **REPS** y la **Ley 1581 de 2012** (Habeas Data). | Las reglas de negocio no son volátiles ni improvisadas: la diferenciación técnica entre unidades de Transporte Asistencial Básico (**TAB**) y Medicalizado (**TAM**), los requisitos de dotación médica, los tiempos de retención documental y la custodia de datos de pacientes son obligatorios por ley. Los requisitos de los módulos de soporte (PQRS, visitantes, inventario) admiten refinamiento iterativo. |
| **4. Disponibilidad del Cliente / Stakeholders** | **Continua y Regulada (Simulación y Validación con Expertos del Sector).**<br>Interacción con coordinadores de despacho de emergencias, personal paramédico y directivos de instituciones prestadoras de salud. | La interacción con actores reales o simulados del sector salud permite revisiones periódicas y validaciones funcionales cada dos semanas, evaluando prototipos de pantallas de despacho, tiempos de respuesta y flujos de cierre formal de servicios asistenciales. |

---

## 2. Comparación de Metodologías de Desarrollo de Software

En concordancia con el Criterio C1, se comparan cuatro (4) metodologías reconocidas de la ingeniería de software a partir de los criterios derivados directamente de las características del proyecto SGA:

| Criterio de Comparación | RUP (Rational Unified Process) | XP (Extreme Programming) | RAD (Rapid Application Development) | SCRUM (Marco Ágil Seleccionado) |
| :--- | :--- | :--- | :--- | :--- |
| **Enfoque de Proceso** | Pesado, altamente formal, guiado por casos de uso y arquitectura en fases rígidas (Inicio, Elaboración, Construcción, Transición). | Ágil extremo, centrado en programación en parejas (*Pair Programming*), pruebas TDD constantes y entregas continuas de código. | Centrado en prototipado rápido, generación asistida de código y talleres JAD con usuarios intensivos. | Ágil, iterativo e incremental, organizado en Sprints de 1 a 2 semanas con entregables de valor medibles y ceremonias claras. |
| **Adecuación al Tamaño del Equipo (4 personas)** | **Inadecuado:** Requiere una sobrecarga excesiva de documentación y comités de control que ralentizan a un equipo de 4 personas. | **Parcialmente viable:** La programación en parejas constante reduce la capacidad de paralelización en un equipo pequeño con frentes backend y frontend. | **Viable con reservas:** Bueno para prototipar UI, pero débil para modelar la rigurosidad de bases de datos relacionales y auditoría. | **Óptimo:** Permite una división equilibrada de responsabilidades técnicas con sincronizaciones diarias cortas (*Daily Scrum*). |
| **Respuesta ante la Estabilidad de Requisitos Sanitarios** | **Rígida:** Asume congelamiento temprano de requisitos, pero su rigidez documental penaliza la velocidad de ajuste del software formativo. | **Demasiado permeable:** Abraza el cambio diario continuo, lo que puede inducir desvíos respecto a los requerimientos cerrados del REPS. | **Rápida pero superficial:** Privilegia la velocidad de entrega visual descuidando la trazabilidad de seguridad y normatividad legal. | **Equilibrada:** El *Sprint Backlog* se mantiene inmutable durante cada ciclo de 2 semanas, protegiendo las reglas del REPS y permitiendo priorizar módulos de soporte. |
| **Alineación con la Disponibilidad del Cliente** | El cliente interviene formalmente solo en las líneas base de fase y actas de aceptación. | Exige un cliente o usuario experto sentado a tiempo completo con el equipo (*On-site Customer*), lo cual es inviable en el SENA. | Demanda disponibilidad intensiva del cliente en sesiones JAD continuas para validar prototipos. | **Ideal:** Permite sesiones quincenales estructuradas de revisión (*Sprint Review*), mostrando módulos funcionales terminados a los instructores y usuarios simulados. |

---

## 3. Selección y Justificación Metodológica

### Metodología Seleccionada: **SCRUM (Marco de Trabajo Ágil Adaptado al SGA)**

#### Justificación Técnica y Operativa:
1. **Ciclos Iterativos e Incrementales (Sprints de 2 semanas):** Permite descomponer la complejidad de los 65 Requisitos Funcionales del SGA en incrementos de software funcionales y testeables. El Sprint 1 aborda el núcleo crítico de seguridad, despacho y monitoreo; mientras que los Sprints posteriores integran facturación, novedades, proveedores y PQRS.
2. **Definición de Terminado (*Definition of Done - DoD*) con Criterio Normativo:** Un incremento de software en el SGA no se considera terminado simplemente si el código compila, sino cuando valida estrictamente la regla de negocio del sector salud (ej. validación del tipo de unidad TAB vs TAM bajo la Resolución 3100 de 2019 e inmutabilidad de la bitácora de auditoría por 5 años).
3. **Distribución Óptima de Capacidades:** El marco Scrum permite a Miguel Ángel Estrada ejercer el rol de *Scrum Master* garantizando la disciplina ágil y la eliminación de impedimentos, mientras el equipo de desarrollo (Aldana en Backend/DB, Muñoz en Frontend y Horta en Integración) trabaja de forma sincronizada y desacoplada.
4. **Inspección y Adaptación Continua:** Mediante las reuniones de *Sprint Review* y *Sprint Retrospective*, el equipo valida con el instructor técnico los modelos conceptuales, casos de uso y diagramas antes de pasar a la fase de construcción física, asegurando el 100% de cumplimiento de los criterios de calidad.
