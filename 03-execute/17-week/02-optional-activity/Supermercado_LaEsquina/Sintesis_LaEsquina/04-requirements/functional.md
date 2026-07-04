# Requerimientos funcionales

> Estado: 🟢 Estable
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0"

## Contexto

Los requerimientos funcionales describen todo lo que el sistema debe ser capaz de hacer.

## Contenido

| ID | Nombre | Descripción | Prioridad | Fuente |
|---|---|---|---|---|
| RF-001 | Registro de venta | El cajero selecciona productos del catálogo y el sistema calcula el total automáticamente y emite un recibo | Alta | Entrevista / Observación |
| RF-002 | Control de inventario | Cada vez que se registra una venta, el sistema descuenta automáticamente las unidades vendidas del inventario | Alta | Entrevista Don Carlos |
| RF-003 | Alerta de stock mínimo | Cuando un producto llega al stock mínimo configurado, el sistema muestra una notificación al administrador | Alta | Observación directa |
| RF-004 | Catálogo de productos | El administrador puede agregar, editar y eliminar productos con: nombre, precio, categoría, stock y proveedor | Alta | Revisión documental |
| RF-005 | Gestión de usuarios | El administrador puede crear y desactivar usuarios, asignando roles (admin / cajero) | Alta | Taller grupal |
| RF-006 | Cierre de caja | Al finalizar el día, el sistema genera un resumen: total vendido, número de transacciones y efectivo recibido | Media | Revisión documental |
| RF-007 | Gestión de proveedores | Se pueden registrar proveedores y asociarlos a los productos correspondientes | Media | Taller grupal |
| RF-008 | Reportes de ventas | El sistema genera reportes por día, semana o mes con filtros por producto o usuario | Media | Encuesta - pregunta 4 |
| RF-009 | Búsqueda de productos | Desde la pantalla de ventas se pueden buscar productos por nombre o código | Alta | Observación directa |
| RF-010 | Ajuste manual de inventario | El administrador puede corregir manualmente el stock de cualquier producto cuando sea necesario | Media | Entrevista Don Carlos |

## Referencias
- SRS v1.0, sección 4.
