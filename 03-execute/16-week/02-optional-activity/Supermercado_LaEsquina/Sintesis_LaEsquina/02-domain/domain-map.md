# Domain Map

> Estado: 🟢 Estable
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0"

## Contexto

Mapa de las entidades principales del dominio del negocio "Supermercado La Esquina" y cómo se relacionan entre sí, con base en los requerimientos funcionales del SRS.

## Contenido

### Entidades identificadas
- **Usuario** (Administrador, Cajero, Supervisor)
- **Producto** (parte del Catálogo)
- **Proveedor**
- **Venta**
- **Detalle de Venta** (productos incluidos en una venta)
- **Inventario / Stock** (asociado a cada producto)

### Relaciones principales

```mermaid
classDiagram
    Usuario "1" -- "0..*" Venta : registra
    Venta "1" -- "1..*" DetalleVenta : contiene
    DetalleVenta "0..*" -- "1" Producto : referencia
    Producto "0..*" -- "1" Proveedor : suministrado por
    Producto "1" -- "1" Inventario : tiene

    class Usuario {
        rol
    }
    class Producto {
        nombre
        precio
        categoria
        stock
        stock_minimo
    }
    class Venta {
        fecha
        total
    }
    class DetalleVenta {
        cantidad
        precio_unitario
    }
    class Proveedor {
        nombre
        contacto
    }
    class Inventario {
        stock_actual
        stock_minimo
    }
```

Cada venta descuenta automáticamente el stock de los productos vendidos (RF-002), y cuando el stock de un producto llega a su mínimo configurado, el sistema notifica al administrador (RF-003).

## Referencias
- SRS v1.0, RF-001 a RF-004, RF-007, RF-010.
