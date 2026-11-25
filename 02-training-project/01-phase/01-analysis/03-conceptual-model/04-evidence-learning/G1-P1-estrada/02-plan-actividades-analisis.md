# 02 · Plan de Actividades de Análisis de Software
## Proyecto Formativo: Sistema Gestor de Ambulancias (SGA)
### Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz:** Miguel Ángel Estrada Torrentes (GitHub: `MAET211` · Carpeta: `G1-P1-estrada`)  
**Fase del Proyecto:** 01 - Análisis | **Competencia:** 220501093 | **RAP:** 592375 (Criterio C2)  

---

## 1. Cronograma y Plan de Actividades de la Fase de Análisis

Para dar estricto cumplimiento al **Criterio C2 de la Rúbrica G1 (RAP 592375)**, se definen **ocho (8) actividades de análisis técnico priorizadas**, coherentes con el marco de trabajo **Scrum** y adaptadas a las exigencias de misión crítica del Sistema Gestor de Ambulancias:

| # | Actividad de Análisis | Prioridad | Responsable Principal | Fecha Inicio | Fecha Fin | Entregable Concreto y Verificable |
| :---: | :--- | :---: | :--- | :---: | :---: | :--- |
| **ACT-01** | **Levantamiento del Marco Normativo y Requisitos Sanitarios**<br>Revisión técnica de la Resolución 3100 de 2019 (Res. 544/2023), Registro Especial de Prestadores de Salud (REPS) y Ley Estatutaria 1581 de 2012 para transporte asistencial TAB y TAM. | Alta (P1) | Miguel Ángel Estrada Torrentes (Scrum Master) | 21/11/2026 | 22/11/2026 | Matriz de trazabilidad legal y marco normativo aplicado a los módulos del SGA. |
| **ACT-02** | **Consolidación de la Especificación de Requisitos (SRS SGA v2.0)**<br>Estructuración formal de 65 Requisitos Funcionales (RF-001 al RF-065), 29 Requisitos No Funcionales bajo ISO/IEC 25010 y 18 Reglas de Negocio (RN-001 al RN-018). | Alta (P1) | Miguel Ángel Estrada / Nicolás Aldana Doria | 21/11/2026 | 23/11/2026 | Documento de Especificación de Requisitos de Software (SRS) bajo estándar IEEE 830. |
| **ACT-03** | **Modelado de Casos de Uso del Negocio y Frontera del Sistema**<br>Identificación de actores primarios/secundarios y modelado de casos de uso nucleares con relaciones `<<include>>` y `<<extend>>` sin cruces de líneas. | Alta (P1) | Miguel Ángel Estrada Torrentes | 22/11/2026 | 24/11/2026 | Diagrama de Casos de Uso UML formal en Draw.io: fuente editable (`.drawio`) y renderizado vectorial (`.svg`). |
| **ACT-04** | **Construcción de la Matriz de Trazabilidad Requisito → Caso de Uso**<br>Mapeo bidireccional entre los 65 requisitos funcionales del SRS y los casos de uso modelados para garantizar 100% de cobertura y cero requisitos huérfanos. | Alta (P1) | Miguel Ángel Estrada Torrentes | 23/11/2026 | 24/11/2026 | Matriz tabular de cobertura funcional con distinción de requisitos funcionales y no funcionales y justificación de relaciones. |
| **ACT-05** | **Diseño de Flujos UX/UI y Wireframes para Despacho Prehospitalario**<br>Bocetado de las pantallas críticas de operación: panel de control con WebSockets, triage prehospitalario y cierre clínico de servicio. | Media (P2) | Juan Miguel Muñoz Castañeda | 23/11/2026 | 25/11/2026 | Prototipo inicial de pantallas clave responsivas rotuladas con su identificador de Caso de Uso correspondiente. |
| **ACT-06** | **Modelado Conceptual de Datos y Dominio del Negocio**<br>Definición del modelo conceptual puro (sin métodos ni tipos de implementación) y Modelo Entidad-Relación (MER) con 23 entidades y resolución de relaciones N:M (`personal_servicio`). | Alta (P1) | Nicolás Esteban Aldana / Juan José Horta | 24/11/2026 | 26/11/2026 | Diagrama Entidad-Relación (DER/MER) con cardinalidades y Diccionario de Datos técnico estructurado. |
| **ACT-07** | **Especificación de Plantillas Extendidas de Casos de Uso Críticos**<br>Documentación detallada paso a paso de los flujos principales (mínimo 6 pasos), variantes alternas y excepciones de despacho, asignación y cierre formal. | Media (P2) | Miguel Ángel Estrada Torrentes | 25/11/2026 | 26/11/2026 | Plantillas extendidas de casos de uso (Anexo A) con precondiciones, disparador, flujos alternos y reglas de negocio. |
| **ACT-08** | **Auditoría Técnica, Lista de Chequeo y Verificación de Entregas**<br>Aplicación de lista de chequeo de 15 criterios de calidad, verificación de cero cruces de líneas, registro de ajustes sustantivos y preparación de commits en días distintos. | Alta (P1) | Equipo Completo (Líder Auditor: Miguel Ángel Estrada) | 26/11/2026 | 27/11/2026 | Lista de chequeo diligenciada, registro de ajustes documentados con enlaces a commits y README oficial verificado. |

---

## 2. Justificación de Coherencia con el Marco Ágil Scrum

1. **Planificación y Refinamiento Temprano en el Sprint 1:** Las actividades **ACT-01 a ACT-04** se ejecutaron de forma intensiva en el inicio del ciclo para clarificar las dependencias normativas de la Resolución 3100 de 2019 y blindar el *Product Backlog* antes de iniciar el diseño arquitectónico o de interfaces.
2. **Entregables Concretos, Desacoplados y Trazables:** Cada actividad genera un artefacto verificable independiente que sirve de insumo directo a la siguiente (por ejemplo: el SRS de la ACT-02 alimenta directamente el diagrama de casos de uso de la ACT-03, y este a su vez fundamenta la matriz de trazabilidad de la ACT-04).
3. **Distribución Técnica y No Burocrática de Roles:** El plan refleja una asignación equilibrada acorde a las fortalezas de los integrantes del equipo declarados en el proyecto formativo:
   * **Miguel Ángel Estrada (Scrum Master):** Liderazgo metodológico, arquitectura conceptual de casos de uso, matrices de trazabilidad y auditoría de calidad.
   * **Nicolás Aldana y Juan José Horta:** Modelado de entidades relacionales, persistencia y reglas de integridad de datos.
   * **Juan Miguel Muñoz:** Ergonomía visual, diseño de interfaces responsivas y flujos de usuario orientados a la reducción de carga cognitiva en situaciones de emergencia.
4. **Inspección Continua y Mitigación de Riesgos:** La inclusión de la actividad **ACT-08** como un hito formal de cierre asegura que ningún artefacto se entregue con defectos de notación, asegurando la estrategia de commits en al menos 2 días calendario distintos (evitando el tope de 70) y preparando al aprendiz para defender las decisiones técnicas en la sustentación oral presencial del sábado.
