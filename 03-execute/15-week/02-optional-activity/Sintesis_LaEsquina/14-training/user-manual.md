# Manual de usuario

> Estado: 🟢 Estable
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0"

## Contexto

Manual básico dirigido a los dos perfiles principales del sistema: Cajero y Administrador, construido a partir de los flujos definidos en los casos de uso del SRS.

## Contenido

### Para el Cajero — Registrar una venta
1. Inicia sesión con tu usuario y contraseña.
2. Busca el producto por nombre o código.
3. Agrega el producto a la venta. Repite hasta agregar todos los productos.
4. Revisa el total calculado automáticamente.
5. Confirma el pago.
6. El sistema descuenta el inventario y genera el recibo automáticamente.

> Si buscas un producto que no existe en el catálogo, el sistema te mostrará un error y no lo agregará a la venta.

### Para el Administrador — Revisar y ajustar inventario
1. Inicia sesión con tu usuario de administrador.
2. Ingresa al módulo de inventario.
3. Revisa el listado de productos y su stock actual; los productos con stock bajo estarán señalados.
4. Selecciona el producto que quieras ajustar e ingresa la nueva cantidad.
5. Guarda el cambio.

### Para el Administrador — Ver reportes de ventas
1. Ingresa al módulo de reportes.
2. Selecciona el periodo (día, semana o mes).
3. Consulta el total de ventas, número de transacciones y productos más vendidos.
4. Exporta el reporte si lo necesitas.

### Para el Administrador — Gestionar productos
1. Ingresa al catálogo de productos.
2. Elige si quieres agregar, editar o eliminar un producto.
3. Completa el formulario: nombre, precio, categoría, stock actual, stock mínimo y proveedor.
4. Guarda los cambios.

> No podrás eliminar un producto que ya tenga ventas registradas; el sistema lo bloqueará para no perder el historial.

## Referencias
- SRS v1.0, sección 6 (casos de uso CU-001 a CU-004).
