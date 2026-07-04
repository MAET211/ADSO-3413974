# Configuración local

> Estado: 🟡 En progreso
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0" (pasos estándar de un proyecto Laravel, inferidos del stack declarado en el SRS)

## Contexto

El SRS especifica el stack tecnológico (Laravel + MySQL + Blade) y un entorno de desarrollo local con XAMPP o Laragon, pero no detalla pasos de instalación. Esta guía los infiere a partir de las prácticas estándar de un proyecto Laravel.

## Contenido

### Requisitos previos
- PHP compatible con la versión de Laravel usada.
- Composer.
- MySQL (incluido en XAMPP o Laragon).
- Servidor local: XAMPP o Laragon.

### Pasos generales
1. Instalar XAMPP o Laragon y levantar el servicio de MySQL.
2. Clonar el repositorio del proyecto.
3. Ejecutar `composer install` para instalar dependencias.
4. Configurar el archivo `.env` con las credenciales de la base de datos local.
5. Ejecutar `php artisan migrate` para crear las tablas (Producto, Proveedor, Venta, DetalleVenta, Usuario, etc.).
6. Ejecutar `php artisan serve` o acceder mediante el servidor local de XAMPP/Laragon.
7. Ingresar con un usuario administrador para configurar el catálogo inicial.

## Referencias
- SRS v1.0, sección 3.3.
