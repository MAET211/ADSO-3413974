# Arquitectura general

> Estado: 🟢 Estable
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0"

## Contexto

Descripción de la arquitectura general del sistema, tal como se define en el SRS.

## Contenido

### Estilo arquitectónico
El sistema es una **aplicación web monolítica** construida con el framework Laravel (PHP), siguiendo el patrón MVC propio del framework. No se define arquitectura de microservicios ni de APIs desacopladas; la vista se renderiza en el servidor mediante Blade Templates.

### Stack tecnológico
- **Backend:** Laravel (PHP)
- **Frontend:** Blade Templates + HTML/CSS
- **Base de datos:** MySQL
- **Entorno de desarrollo:** servidor local (XAMPP o Laragon)

### Componentes funcionales principales
- Módulo de ventas (registro, búsqueda de productos, recibo).
- Módulo de inventario (stock, alertas de stock mínimo, ajustes manuales).
- Módulo de catálogo de productos (alta, edición, baja).
- Módulo de proveedores.
- Módulo de reportes (ventas por periodo, cierre de caja).
- Módulo de usuarios y roles (administrador, cajero, supervisor).

### Despliegue
Pensado para uso local o en un servidor básico, sin soporte previsto para cientos de usuarios simultáneos (ver [13-operations](../13-operations/README.md) y [15-project-control/open-questions.md](../15-project-control/open-questions.md)).

## Referencias
- SRS v1.0, secciones 3.1 y 3.3, y sección 7 (restricciones).
