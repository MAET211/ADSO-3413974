# 05 · Especificación Resumida de Casos de Uso Complementarios del Catálogo
## Proyecto Formativo: Sistema Gestor de Ambulancias (SGA)
### Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz:** `MAET211` (Carpeta: `G1-P1-estrada`)  
**Fase del Proyecto:** 01 - Análisis | **Competencia:** 220501093 | **RAP:** 592373 (Criterios C3 y C4)  

---

## 1. Propósito y Delimitación frente al Producto 2 (`G1-P2-estrada`)

Para garantizar la separación clara de entregables establecida en `Rubricas_G1.md` y evitar duplicación documental con el Producto 2:
* Las **tres (3) plantillas extendidas formales (Anexo A)** correspondientes a los casos de uso críticos del negocio (**`CU-03`**, **`CU-04`** y **`CU-05`**) se encuentran desarrolladas de forma completa en el entregable de Producto 2: [`../G1-P2-estrada/02-plantillas-casos-de-uso.md`](../G1-P2-estrada/02-plantillas-casos-de-uso.md).
* El presente documento complementa el catálogo de **`04-matriz-requisito-caso-uso.md`**, detallando el alcance funcional, los actores, las reglas de negocio y la síntesis operativa de los **nueve (9) casos de uso complementarios y de soporte** representados en `03-diagrama-casos-de-uso.svg` (`CU-01`, `CU-01.1`, `CU-02`, `CU-06`, `CU-07`, `CU-08`, `CU-09`, `CU-10` y `CU-11`), sin incluir jerga de implementación física (Regla de Arbitraje 10).

---

## 2. Especificación Funcional de Casos de Uso Complementarios

| ID y Nombre | Actores | Requisitos Cubiertos | Síntesis de Objetivo y Flujo Operativo | Reglas de Negocio |
|---|---|---|---|---|
| **CU-01 · Autenticar usuario y emitir token JWT** | Administrador, Coordinador, Paramédico (Primarios); Sistema SGA (Secundario) | `RF-001` a `RF-006`, `RF-014`, `RF-053` | Valida la identidad del usuario mediante credenciales únicas, verifica la vigencia de su contraseña y le otorga acceso restringido por rol institucional (RBAC). Gestiona el cierre automático tras 15 minutos de inactividad y la recuperación segura por enlace temporal. | `RN-008` (Vigencia de contraseña 90 días), `RN-010` (Auditoría de accesos) |
| **CU-01.1 · Bloquear cuenta por intentos fallidos** *(Extiende a CU-01)* | Sistema SGA (Disparador automático), Administrador | `RF-007` | Extensión de seguridad que se activa al acumular 5 intentos fallidos consecutivos de autenticación. Suspende la cuenta durante 30 minutos y emite una alerta de seguridad al administrador para eventual desbloqueo manual. | `RN-009` (Bloqueo por 5 fallos / 30 min) |
| **CU-02 · Radicar solicitud de emergencia** *(Incluido en CU-03)* | Coordinador Operativo (Primario) | `RF-018` a `RF-021` | Recibe el llamado de auxilio, registra los datos del solicitante y la ubicación del incidente, vincula o crea al paciente protegiendo su confidencialidad, clasifica la prioridad clínica (Triage: Rojo, Naranja, Amarillo, Verde) y da inicio al despacho automático (`CU-03`). | `RN-002` (Nivel de triage clínico) |
| **CU-06 · Auditar evento transaccional inmutable** *(Incluido en CU-05)* | Sistema SGA (Ejecutor automático), Administrador (Consulta) | `RF-001`, `RF-006`, `RF-026`, `RF-055` a `RF-058` | Registra de forma automática e inalterable cada creación, modificación, cambio de estado, asignación manual o evento de seguridad, conservando responsable, marca de tiempo, valores previos y posteriores por un mínimo de 5 años. | `RN-010` (Inmutabilidad y retención 5 años) |
| **CU-07 · Monitorear flota y estados en tiempo real** | Coordinador Operativo, Administrador (Primarios); Paramédico (Actualización); Sistema SGA | `RF-009`, `RF-015`, `RF-028`, `RF-029`, `RF-059`, `RF-061`, `RF-064`, `RF-065` | Despliega en el tablero principal el estado operativo actualizado de ambulancias TAB y TAM, disponibilidad de tripulaciones, servicios activos, novedades críticas e indicadores clave (KPI) con actualización en tiempo real. | `RN-001`, `RN-016` (Registro de novedades), `RN-018` (Reportes solo lectura) |
| **CU-08 · Gestionar inventario de ambulancias** | Administrador (Primario) | `RF-008`, `RF-010`, `RF-012`, `RF-013`, `RF-036` a `RF-039`, `RF-045` a `RF-054`, `RF-063` | Consolida bajo objetivo de negocio (Regla de Arbitraje 1) la administración de flota TAB/TAM, dotación Res. 3100, mantenimientos, propietarios, contratos de proveedores, repositorio documental oficial y control de acceso físico de visitantes a bases. Verifica vigencia antes de habilitar unidades (`CU-09`). | `RN-003`, `RN-012` (Contratos vigentes), `RN-013` (Versionamiento documental), `RN-017` (Visitantes) |
| **CU-09 · Validar habilitación REPS y vencimientos** *(Incluido en CU-08)* | Sistema SGA (Verificador automático), Administrador | `RF-011`, `RF-013` | Revisa continuamente la vigencia de SOAT, revisión técnico-mecánica y registro REPS de cada ambulancia, emitiendo alertas preventivas y bloqueando automáticamente cualquier móvil con documentos vencidos para impedir su despacho. | `RN-003` (Bloqueo por vencimiento documental) |
| **CU-10 · Radicar y consultar solicitudes PQRS** | Usuario / Ciudadano (Primario), Administrador | `RF-040` a `RF-044` | Permite al ciudadano radicar Peticiones, Quejas, Reclamos, Sugerencias o Denuncias asignando código único de seguimiento y plazo legal; habilita la consulta pública sin inicio de sesión y exige asignación de responsable en $\le 24\text{ horas}$. | `RN-011` (Asignación obligatoria $\le 24\text{ h}$) |
| **CU-11 · Generar factura inmutable de servicio** *(Incluido en CU-05)* | Sistema SGA (Ejecutor), Administrador (Consulta/Cartera) | `RF-030` a `RF-035`, `RF-064` | Liquida y emite de forma automática la factura al concluir formalmente un servicio (`CU-05`), integrando tarifas TAB/TAM vigentes con carácter inmutable (ajustes únicamente mediante notas crédito o débito), control de cartera, cálculo automático de mora y emisión de comprobantes. | `RN-014` (Inmutabilidad de factura), `RN-015` (Mora desde día 1 / bloqueo día 30) |

---

## 3. Referencia Cruzada a los Casos de Uso Críticos (Anexo A)

Para la especificación paso a paso de flujo principal, flujos alternos y excepciones de los casos críticos del dominio, consúltese el artefacto dedicado del Producto 2:
* [`CU-03`, `CU-04` y `CU-05` — Plantillas Extendidas Anexo A](../G1-P2-estrada/02-plantillas-casos-de-uso.md)
