# Informe Técnico de Análisis Conceptual · Sistema Gestor de Ambulancias (SGA)
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592373 (Criterio C8) — Documenta las actividades de análisis a través de un informe técnico estructurado  
**Formato Oficial:** Anexo E (`Rubricas_G1.md` y `Plantilla_README_Entrega_G1.md`)  
**Aprendiz Autor:** `MAET211` (Carpeta: `G1-P2-estrada`)  
**Ficha:** 3413974 · ADSO · Centro de la Industria, la Empresa y los Servicios (CIES - Regional Huila)  
**Fecha:** 25 de noviembre de 2026  

---

## 1. Introducción y Propósito del Informe

El presente informe consolida los resultados del análisis y modelado conceptual para el **Sistema Gestor de Ambulancias (SGA)**, una solución de software integral orientada a optimizar la atención de emergencias prehospitalarias, la gestión georreferenciada de la flota de ambulancias (Básicas - TAB y Medicalizadas - TAM), la asignación algorítmica de unidades móviles según severidad de Triage y la liquidación formal de servicios asistenciales en el municipio de Neiva y el departamento del Huila.

El documento sintetiza la interpretación de los requisitos de software, articula los enlaces a los artefactos y modelos construidos, resume los hallazgos de la verificación formal y expone las mejoras aplicadas para garantizar la máxima rigurosidad técnica y metodológica según los estándares SENA.

---

## 2. Requisitos Interpretados del Sistema

A partir del Documento de Especificación de Requisitos de Software (SRS) del proyecto formativo, se consolidaron e interpretaron dos grandes dimensiones de requerimientos:

### 2.1 Requisitos Funcionales (RF)
Se analizaron y estructuraron **65 Requisitos Funcionales** organizados en 8 módulos operativos:
1. **Gestión de Seguridad, Identidad y Accesos (RF-01 a RF-03):** Control de acceso basado en roles (RBAC: Administrador, Despachador, Médico, Paramédico, Conductor, Auditor), autenticación con JWT y control de sesiones concurrentes.
2. **Recepción y Radicación de Emergencias (RF-04 a RF-09):** Captura de incidentes vía llamada telefónica o botón de pánico, geocodificación automática de direcciones, categorización de Triage (I al V bajo Resolución 5596 de 2015) y asignación de código único de radicado.
3. **Despacho Algorítmico y Reasignación de Flota (RF-10 a RF-15):** Algoritmo de despacho por cercanía geográfica (GPS), tipo de soporte requerido (TAB/TAM) y disponibilidad de tripulación; soporte para reasignación manual justificada con auditoría obligatoria (RN-007).
4. **Seguimiento Telemático y Telemetría en Ruta (RF-16 a RF-20):** Transmisión de coordenadas en tiempo real cada 10 segundos, cálculo dinámico de tiempos estimados de arribo (ETA) y detección de desvíos de ruta.
5. **Historia Clínica Prehospitalaria y Cierre (RF-21 a RF-28):** Registro en escena de signos vitales, escala de Glasgow, procedimientos invasivos, diagnóstico presuntivo CIE-10, selección de IPS receptora y firma digital del médico tratante (RN-005).
6. **Módulo Financiero y Facturación (RF-29 a RF-38):** Liquidación de copagos, facturación electrónica para EPS/SOAT, radicación de cuentas médicas e inmutabilidad contable (RN-008).
7. **Gestión Documental y Normativa REPS (RF-39 a RF-48):** Control de vigencia de SOAT, revisión técnico-mecánica, habilitación de móviles ante la Secretaría de Salud y verificación de tarjeta profesional ReTHUS.
8. **Auditoría, Trazabilidad y PQRS (RF-49 a RF-65):** Registro de pistas de auditoría inmutables por 5 años (RN-009) y gestión integral de peticiones, quejas, reclamos y sugerencias.

### 2.2 Requisitos No Funcionales (RNF) bajo ISO/IEC 25010
Los requerimientos de calidad técnica se clasificaron bajo las 8 características del estándar internacional ISO/IEC 25010:
- **Rendimiento y Eficiencia:** El algoritmo de cálculo de ruta y asignación de ambulancia debe responder en menos de 2.0 segundos para solicitudes de Triage I (RNF-01).
- **Fiabilidad y Disponibilidad:** Disponibilidad operativa del sistema del 99.8 % en horario 24/7/365, con mecanismo de conmutación por error (*failover*) automático (RNF-02).
- **Seguridad:** Cifrado en tránsito (TLS 1.3) y en reposo (AES-256) para todos los datos clínicos y demográficos del paciente (Habeas Data - Ley 1581 de 2012) (RNF-03).
- **Usabilidad:** Interfaz de despacho responsiva y ergonómica que permita despachar una unidad móvil en máximo 4 clics desde la confirmación de la llamada (RNF-04).
- **Mantenibilidad:** Arquitectura modular desacoplada con cobertura de pruebas unitarias superior al 80 % en lógica de despacho y liquidación (RNF-05).

---

## 3. Catálogo de Modelos y Artefactos Construidos

Los modelos del análisis conceptual se encuentran completamente desarrollados y versionados en el repositorio en formatos abiertos y fuentes editables:

1. **Diagrama de Casos de Uso del Sistema:**
   - Vector de alta resolución: [`03-diagrama-casos-de-uso.svg`](../G1-P1-estrada/03-diagrama-casos-de-uso.svg)
   - Fuente editable Draw.io: [`03-diagrama-casos-de-uso.drawio`](../G1-P1-estrada/03-diagrama-casos-de-uso.drawio)
2. **Diagramas de Actividades con Calles y Concurrencia:**
   - Vector de alta resolución: [`01-diagramas-actividades.svg`](./01-diagramas-actividades.svg)
   - Fuente editable Draw.io: [`01-diagramas-actividades.drawio`](./01-diagramas-actividades.drawio)
3. **Plantillas Extendidas de Casos de Uso (Anexo A):**
   - Especificación detallada de CU-03, CU-04 y CU-05: [`02-plantillas-casos-de-uso.md`](./02-plantillas-casos-de-uso.md)
4. **Modelo Conceptual de Dominio:**
   - Vector de alta resolución: [`03-modelo-dominio.svg`](./03-modelo-dominio.svg)
   - Fuente editable Draw.io: [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio)
5. **Modelo Entidad-Relación (MER Relacional - Crow's Foot):**
   - Vector de alta resolución: [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg)
   - Fuente editable Draw.io: [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio)
6. **Prototipo Inicial de Interfaz (Mockups):**
   - Diseños de pantalla P-01, P-02 y P-03 con validaciones: [`05-prototipo-mockups.md`](./05-prototipo-mockups.md)
7. **Instrumentos de Validación y Calidad:**
   - Lista de Chequeo de Análisis (Anexo B): [`06-lista-chequeo-validacion.md`](./06-lista-chequeo-validacion.md)
   - Registro de Ajustes Formal (Anexo D): [`07-registro-de-ajustes.md`](./07-registro-de-ajustes.md)
   - Matriz de Trazabilidad Integral (Anexo C): [`09-matriz-trazabilidad-anexo-c.md`](./09-matriz-trazabilidad-anexo-c.md)

---

## 4. Resultado de la Verificación Técnica

La aplicación de la lista de chequeo sobre los artefactos arrojó los siguientes indicadores cuantitativos:
- **Criterios totales auditados:** 16 criterios objetivos (Reglas de Arbitraje 1 a 10 de Guía 1).
- **Criterios conformes (Cumplimiento):** 16 / 16 (100 %).
- **Criterios no conformes preliminares:** 5 desviaciones detectadas en etapa de borrador.
- **Tasa de cobertura de requisitos en matriz de trazabilidad:** 100 % (65 de 65 requisitos funcionales trazados hasta modelo de dominio y entidad del MER, superando el mínimo del 90 % fijado por el criterio C8).

---

## 5. Resumen de Ajustes y Mejoras Implementadas (Ciclos Día 1 y Día 2)

Las desviaciones detectadas durante la auditoría formativa fueron subsanadas formalmente y registradas en el Anexo D (`07-registro-de-ajustes.md`):
1. **Ajuste en `<<extend>>`:** Corrección de la orientación de flecha en la extensión condicional de CU-04 hacia CU-03, explicitando el punto de extensión de contingencia.
2. **Purificación del Modelo de Dominio:** Supresión de claves foráneas y variables SQL físicas en las clases conceptuales, reemplazándolas por asociaciones semánticas puras y multiplicidades.
3. **Normalización Relacional de Tripulaciones:** Creación de la entidad asociativa `PERSONAL_SERVICIO` para resolver la relación N:M entre servicios y personal asistencial, habilitando el registro de roles y tiempos.
4. **Exhaustividad en Diagramas de Actividades:** Normalización de guardas entre corchetes en todas las ramas de decisión, incorporando el flujo alterno de saturación de flota.
5. **Corrección de Precondiciones:** Eliminación de comprobaciones en tiempo de ejecución del campo precondiciones en las plantillas de casos de uso, trasladándolas a flujos alternos y de excepción.
6. **Eliminación de Tipos de Programación en Dominio:** Sustitución de palabras reservadas de programación (`boolean`) por semántica conceptual de negocio (`Booleano (Si/No)`).
7. **Formalización de Entidad Débil con Clave Compuesta:** Sustitución de clave subrogada artificial por clave primaria compuesta identificadora `(servicio_id, numero_secuencia)` en el MER.
8. **Estandarización de Multiplicidades en Draw.io:** Configuración nativa de etiquetas en extremos de origen y destino (`edgeLabel`), evitando desalineaciones visuales.

---

## 6. Dictamen Final

La documentación y modelos conceptuales del Sistema Gestor de Ambulancias (SGA) alcanzan el **100 % de conformidad** respecto a los criterios de evaluación del programa (RAP 592373 y RAP 592374), consolidando una base técnica sólida, trazable y verificable para avanzar a la fase de Diseño de la Solución (Guía 2).
