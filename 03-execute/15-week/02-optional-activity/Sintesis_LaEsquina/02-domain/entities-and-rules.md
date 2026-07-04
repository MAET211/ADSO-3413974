# Entities and Rules

> Estado: 🟢 Estable
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0"

## Contexto

Reglas de negocio que gobiernan el comportamiento del sistema, derivadas directamente de los requerimientos funcionales del SRS.

## Contenido

| Regla | Descripción | Origen |
|---|---|---|
| RN-01 | El total de una venta se calcula automáticamente a partir de los productos agregados; no se ingresa manualmente. | RF-001 |
| RN-02 | Cada venta confirmada descuenta automáticamente las unidades vendidas del inventario del producto correspondiente. | RF-002 |
| RN-03 | Cuando el stock de un producto llega al mínimo configurado, el sistema debe notificar al administrador. | RF-003 |
| RN-04 | Un producto no puede eliminarse del catálogo si ya tiene ventas registradas asociadas, para no perder el historial. | Caso de uso CU-004 |
| RN-05 | Solo el administrador puede crear o desactivar usuarios y asignar roles. | RF-005 |
| RN-06 | El cierre de caja diario se calcula a partir de las ventas del día: total vendido, número de transacciones y efectivo recibido. | RF-006 |
| RN-07 | Todo producto debe estar asociado a un proveedor registrado. | RF-007 |
| RN-08 | El administrador puede ajustar manualmente el stock de un producto cuando sea necesario, quedando registrado el cambio. | RF-010 |
| RN-09 | Si un producto buscado no existe en el catálogo durante una venta, el sistema debe mostrar un error y no agregarlo. | CU-001 (flujo alternativo) |

## Referencias
- SRS v1.0, sección 4 (RF-001 a RF-010) y sección 6 (casos de uso).
