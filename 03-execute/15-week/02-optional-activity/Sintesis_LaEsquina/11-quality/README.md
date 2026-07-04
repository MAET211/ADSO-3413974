# Quality

> Estado: 🟡 En progreso
> Última actualización: 2026-07-03
> Autor: Equipo ADSO | Equipo: Aprendices ADSO - SENA
> Fuente: Sintetizado a partir del SRS "Sistema de Gestión Supermercado La Esquina v1.0" (no existe una estrategia de pruebas formal en el SRS; se proponen verificaciones mínimas derivadas de los propios requerimientos)

## Contexto

El SRS no define una estrategia de pruebas ni de revisión de código. Sin embargo, cada requerimiento funcional y no funcional puede convertirse en un criterio de verificación mínimo.

## Contenido

### Verificaciones sugeridas por requerimiento (ejemplos)
| Requerimiento | Verificación sugerida |
|---|---|
| RF-001 | Registrar una venta con varios productos y confirmar que el total calculado sea correcto y se emita el recibo. |
| RF-002 | Confirmar que, tras una venta, el stock del producto disminuye exactamente en la cantidad vendida. |
| RF-003 | Configurar un stock mínimo bajo y verificar que la alerta se muestre al administrador. |
| RNF-001 | Medir el tiempo de respuesta de las acciones principales con 3 usuarios simultáneos. |
| RNF-002 | Verificar que la sesión expire tras 30 minutos de inactividad. |

Este listado es un punto de partida; no reemplaza un plan de pruebas formal, que debería desarrollarse en una siguiente etapa del proceso de formación.

## Referencias
- SRS v1.0, secciones 4 y 5.
