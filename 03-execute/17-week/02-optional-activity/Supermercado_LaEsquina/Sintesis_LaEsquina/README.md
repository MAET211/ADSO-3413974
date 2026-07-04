# Documentación del Proyecto — Sistema de Gestión Supermercado "La Esquina"

Este repositorio organiza, en 16 secciones temáticas, la documentación técnica y funcional del proyecto **Sistema de Gestión para Supermercado de Barrio "La Esquina"**, desarrollado en el marco del programa Análisis y Desarrollo de Software (ADSO) del SENA.

El contenido de este repositorio parte de la Especificación de Requerimientos de Software (SRS v1.0) elaborada previamente, y ha sido redistribuido y ampliado siguiendo un esquema de gobierno documental por carpetas, de modo que cada aspecto del proyecto (contexto, dominio, requisitos, arquitectura, datos, UML, operación, capacitación, etc.) tenga un lugar propio y trazable.

## Estructura

| Sección | Descripción | Estado |
|---|---|---|
| [00-governance](./00-governance/) | Reglas y estado general de la documentación | 🟢 |
| [01-context](./01-context/) | Contexto institucional, alcance y glosario | 🟢 |
| [02-domain](./02-domain/) | Modelo de dominio y reglas de negocio | 🟢 |
| [03-product](./03-product/) | Visión del producto | 🟢 |
| [04-requirements](./04-requirements/) | Requisitos funcionales, no funcionales e historias de usuario | 🟢 |
| [05-architecture](./05-architecture/) | Arquitectura general del sistema | 🟢 |
| [06-data](./06-data/) | Modelo de datos | 🟢 |
| [07-api](./07-api/) | Contratos de API | 🔴 |
| [08-uml](./08-uml/) | Diagramas UML (casos de uso y clases) | 🟢 |
| [09-microservices](./09-microservices/) | Catálogo de microservicios | ⚫ |
| [10-devops](./10-devops/) | Entorno de desarrollo local | 🟢 |
| [11-quality](./11-quality/) | Estrategia de calidad y pruebas | 🟡 |
| [12-ux-ui](./12-ux-ui/) | Lineamientos de usabilidad e interfaz | 🟢 |
| [13-operations](./13-operations/) | Disponibilidad, backups y operación | 🟢 |
| [14-training](./14-training/) | Manual de usuario | 🟢 |
| [15-project-control](./15-project-control/) | Alcance futuro y preguntas abiertas | 🟢 |
| [99-archive](./99-archive/) | Documentos históricos o deprecados | 🟢 |

## Estado de íconos

- 🔴 Pendiente — no hay información suficiente en el SRS para desarrollar la sección.
- 🟡 En progreso — información parcial o inferida a partir del contexto.
- 🟢 Estable — información completa y respaldada directamente por el SRS.
- ⚫ No aplica — la sección no corresponde a la naturaleza del proyecto (ver justificación en la carpeta).

## Documento fuente

Todo el contenido de este repositorio deriva de: **SRS v1.0 — Sistema de Gestión para Supermercado de Barrio "La Esquina"** (Programa ADSO, SENA, 2025).
