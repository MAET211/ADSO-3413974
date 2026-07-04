# Requerimientos no funcionales

> Estado: 🟢 Estable
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0"

## Contexto

Los requerimientos no funcionales describen cómo debe comportarse el sistema, más allá de sus funciones.

## Contenido

| ID | Nombre | Descripción | Prioridad | Fuente |
|---|---|---|---|---|
| RNF-001 | Rendimiento | El sistema debe responder cualquier consulta o acción en menos de 2 segundos con hasta 3 usuarios activos al mismo tiempo | Alta | Análisis de contexto |
| RNF-002 | Seguridad | El acceso requiere usuario y contraseña. La sesión expira después de 30 minutos de inactividad. Se lleva registro de operaciones importantes | Alta | Análisis de contexto |
| RNF-003 | Usabilidad | La interfaz debe estar en español, sin tecnicismos. Un cajero sin experiencia debe poder registrar una venta en menos de 5 pasos tras una breve capacitación | Alta | Observación directa |
| RNF-004 | Disponibilidad | El sistema debe funcionar correctamente en horario comercial (6am - 10pm) sin caídas. Puede ser local o en servidor básico | Media | Entrevista Don Carlos |
| RNF-005 | Compatibilidad | Debe funcionar desde cualquier navegador web moderno (Chrome, Firefox, Edge) en computador de escritorio o portátil | Media | Análisis de contexto |

## Referencias
- SRS v1.0, sección 5.
