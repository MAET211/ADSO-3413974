# Operations

> Estado: 🟢 Estable
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0"

## Contexto

Lineamientos de operación del sistema una vez esté en funcionamiento, derivados de los requerimientos no funcionales y las restricciones del SRS.

## Contenido

### Disponibilidad
El sistema debe funcionar correctamente en horario comercial (6:00 a.m. – 10:00 p.m.) sin caídas (RNF-004). No se exige disponibilidad 24/7 ni infraestructura de alta disponibilidad.

### Copias de seguridad
El sistema trabaja con datos locales. Las copias de seguridad de la base de datos son responsabilidad del administrador del negocio y deben realizarse periódicamente (sección 7, restricciones). No se define en el SRS una frecuencia exacta ni un procedimiento automatizado.

### Capacidad
El sistema es para uso local o en un servidor básico; no está pensado para soportar cientos de usuarios simultáneos (sección 7).

## Referencias
- SRS v1.0, RNF-004 y sección 7.
