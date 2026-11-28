# Prototipo Inicial (Mockups) · Sistema Gestor de Ambulancias (SGA)
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592374 (Criterio C5) — Realiza prototipo inicial del software de acuerdo con los casos de uso identificados  
**Aprendiz:** `MAET211` (Carpeta: `G1-P2-estrada`)  
**Ficha:** 3413974 · ADSO · Centro de la Industria, la Empresa y los Servicios (CIES)  
**Fecha:** Noviembre 2026  

---

## 1. Introducción y Criterios de Diseño

El presente documento presenta el prototipo inicial de interfaz gráfica de usuario para el **Sistema Gestor de Ambulancias (SGA)**, cubriendo los tres casos de uso críticos priorizados en el análisis conceptual y coherentes con el documento SRS (`RF-001` a `RF-065`, `RN-001` a `RN-018`):
1. **Pantalla P-01 (`CU-03`, incluye `CU-02` y enlace a `CU-07`):** Tablero de Triage, Monitoreo y Despacho Automatizado.
2. **Pantalla P-02 (`CU-04`, extiende a `CU-03`):** Ventana Modal de Justificación de Despacho Manual (`RN-007`).
3. **Pantalla P-03 (`CU-05`, incluye `CU-11` y `CU-06`):** Formulario de Cierre Formal de Servicio y Facturación Inmutable (`RN-005`, `RN-014`).

Todas las pantallas se encuentran explícitamente rotuladas con su caso de uso asociado, libres de pantallas huérfanas, y utilizan identificadores de rol anonimizados en cumplimiento de la política de privacidad de repositorios públicos.

---

## 2. Pantalla P-01: Tablero de Triage, Monitoreo y Despacho Automatizado (CU-03)
- **Caso de uso asociado:** `CU-03 · Asignar ambulancia automáticamente (TAB / TAM)` (incluye `CU-02 · Radicar solicitud de emergencia` y se articula con `CU-07 · Monitorear flota`)
- **Actor:** Coordinador Operativo (Central SGA)
- **Requisitos cubiertos:** `RF-009`, `RF-011`, `RF-014`, `RF-015`, `RF-016`, `RF-018`, `RF-021`, `RF-022`, `RF-028`, `RF-029`, `RNF-009` ($\le 2\text{ s}$), `RNF-016` ($\le 4\text{ pasos}$)
- **Reglas de negocio:** `RN-001` (Disponibilidad), `RN-002` (Correspondencia Triage vs TAB/TAM), `RN-003` (Vigencia REPS/SOAT/Tecnomecánica), `RN-004` (Habilitación de personal)
- **Objetivo:** Recibir la llamada de emergencia, clasificar la prioridad clínica (Rojo, Naranja, Amarillo, Verde) y confirmar la unidad TAB o TAM óptima asignada algorítmicamente en $\le 2\text{ segundos}$.

### 2.1 Representación Visual de la Interfaz

```text
+--------------------------------------------------------------------------------------------------------------------------+
| [SGA] SISTEMA GESTOR DE AMBULANCIAS | CENTRAL OPERATIVA SGA               | Operador: Operador Central SGA | [24/7] [10:42]|
+--------------------------------------------------------------------------------------------------------------------------+
| BANDEJA DE SOLICITUDES ACTIVAS (CU-02 · TRIAGE) | MONITOREO GEORREFERENCIADO DE FLOTA EN TIEMPO REAL (CU-07)             |
|-------------------------------------------------|------------------------------------------------------------------------|
| [!] SOL-2026-0892 | Triage: ROJO (Critico)      |  Filtros: [X] Disponible  [X] TAM (Rojo/Naranja)  [X] TAB (Amar/Verde) |
|   Direccion: Calle 8 # 5-20 (Zona Centro)       |  Alertas: [0] REPS vencidos en zona | Motor RNF-009: OK (< 2.0 s)     |
|   Sintomatologia: Politraumatismo severo        |  --------------------------------------------------------------------  |
|   Paciente: [Paciente Anonimizado #892]         |                                                                        |
|   Unidad requerida (RN-002): TAM (Medicalizada) |      [ MOVIL-104 (TAM) ] *Disponible | REPS Vigente | SOAT OK          |
|   [ Ver Detalle ]   [ Evaluar Despacho ]        |             \  Distancia: 1.8 km | ETA estimado: 4.2 min             |
|-------------------------------------------------|              v                                                         |
| [!] SOL-2026-0893 | Triage: AMARILLO (Moderado) |            [ SOL-2026-0892 ] Calle 8 # 5-20 (Triage Rojo)            |
|   Direccion: Cra 15 # 22-10 (Zona Norte)        |                                                                        |
|   Sintomatologia: Dolor toracico estable        |      [ MOVIL-101 (TAB) ] *En Servicio | Traslado hacia IPS Destino      |
|   Unidad requerida (RN-002): TAB (Basica)       |      [ MOVIL-102 (TAB) ] *Disponible  | Base Norte | REPS Vigente      |
|   [ Ver Detalle ]   [ Evaluar Despacho ]        |      [ MOVIL-105 (TAM) ] *Bloqueada (RN-003: SOAT Vencido)             |
|-------------------------------------------------+------------------------------------------------------------------------+
| PANEL DE DECISIÓN DEL MOTOR DE DESPACHO AUTOMÁTICO (CU-03)                                                               |
|--------------------------------------------------------------------------------------------------------------------------|
| Solicitud Activa: SOL-2026-0892 | Triage: ROJO -> Exige Unidad TAM | Tiempo de calculo algoritmo: 0.64 s (Cumple RNF-009)|
| Unidad sugerida por el sistema: MOVIL-104 (TAM) | Placa: SGA-104 | Habilitacion REPS: #REPS-3100-04 (Vigente)            |
| Validaciones superadas:                                                                                                  |
|  [OK] RN-001: Estado de unidad = Disponible              [OK] RN-003: SOAT, Tecnomecanica y REPS al dia                  |
|  [OK] RN-002: Complejidad TAM acorde con Triage Rojo     [OK] RN-004: Tripulacion habilitada (Turno < limite continuo)   |
|  Tripulacion asignada: [Medico Turno ReTHUS] + [Paramedico Lider] + [Conductor Asignado]                                 |
|                                                                                                                          |
|  [ CONFIRMAR DESPACHO AUTOMÁTICO (CU-03) ]        [ ASIGNACIÓN MANUAL CON JUSTIFICACIÓN (CU-04 -> Abre Modal P-02) ]     |
+--------------------------------------------------------------------------------------------------------------------------+
```

### 2.2 Diccionario de Datos y Controles de Pantalla P-01
| Control / Campo | Tipo | Origen / Entidad MER | Regla de Validación / Comportamiento |
|---|---|---|---|
| Bandeja de Solicitudes (`SOLICITUD_EMERGENCIA`) | Lista priorizada | `SOLICITUD_EMERGENCIA` | Orden descendente por severidad de `prioridad_triage` (`Rojo` > `Naranja` > `Amarillo` > `Verde`) y `fecha_hora_solicitud` |
| Tipo de Unidad Requerida (`RN-002`) | Badge automático | `AMBULANCIA.tipo` | `Rojo`/`Naranja` $\rightarrow$ `TAM`; `Amarillo`/`Verde` $\rightarrow$ `TAB` |
| Bloqueo Documental (`RN-003`) | Estado visual en mapa | `AMBULANCIA.vigencia_soat_tecno` | Las unidades con SOAT, tecnomecánica o habilitación REPS vencidos aparecen bloqueadas y quedan excluidas del algoritmo (`M-105`) |
| Filtro de Tripulación (`RN-004`) | Indicador de aptitud | `PERSONAL` y `PERSONAL_SERVICIO` | Verifica `estado_disponibilidad = Disponible`, `vigencia_certificacion` vigente y límite de `horas_turno_continuas` |
| Botón «Confirmar Despacho Automático» | Acción primaria (`CU-03`) | `SERVICIO` y `HISTORIAL_ESTADOS_SERVICIO` | Crea/actualiza el registro en `SERVICIO` a estado `Asignado`, bloquea el móvil, notifica a la tripulación y registra el primer hito en `HISTORIAL_ESTADOS_SERVICIO` |
| Botón «Asignación Manual» | Disparador (`CU-04`) | Flujo extensión `CU-04` | Abre la ventana modal **P-02** exigiendo justificación escrita obligatoria (`RN-007`) |

---

## 3. Pantalla P-02: Ventana Modal de Justificación de Despacho Manual (CU-04)
- **Caso de uso asociado:** `CU-04 · Asignar ambulancia con justificación manual` (extiende a `CU-03`)
- **Actor:** Coordinador Operativo
- **Requisitos cubiertos:** `RF-023`, `RF-024`, `RF-055`, `RF-056`, `RF-057`, `RNF-007`, `RNF-028`
- **Reglas de negocio:** `RN-001`, `RN-002` (advertencia si el tipo no corresponde al triage), `RN-003`, `RN-007` (justificación obligatoria), `RN-010` (auditoría inmutable)
- **Objetivo:** Permitir anular la sugerencia automática ante contingencias operativas (vía cerrada, falla mecánica, saturación de zona), exigiendo justificación formal y registrando el cambio de forma inmutable en auditoría.

### 3.1 Representación Visual de la Interfaz

```text
+---------------------------------------------------------------------------------------------------+
|  MODAL: ASIGNACIÓN MANUAL CON JUSTIFICACIÓN OBLIGATORIA (CU-04 · Extiende a CU-03)            [X] |
+---------------------------------------------------------------------------------------------------+
|  AVISO NORMATIVO DE AUDITORÍA (RN-007 / RN-010):                                                  |
|  Toda anulacion del despacho automatico queda registrada en HISTORIAL_ESTADOS_SERVICIO y en       |
|  AUDITORIA (retencion minima 5 anos) con usuario responsable, hora exacta y motivo tecnico.       |
|---------------------------------------------------------------------------------------------------|
|  Solicitud activa: SOL-2026-0892 | Triage: ROJO (Critico) | Calle 8 # 5-20                        |
|  Unidad sugerida por algoritmo: MOVIL-104 (TAM) - Distancia: 1.8 km                               |
|                                                                                                   |
|  SELECCIÓN MANUAL DE UNIDAD RECEPTORA (Filtro RN-001 / RN-003 activos):                           |
|  Ambulancia habilitada: [ MOVIL-106 (TAM) - Disponible | REPS Vigente | Base Sur (ETA: 6.5 m) |v] |
|  Tripulacion disponible: [Medico Reemplazo ReTHUS] + [TPH Tripulante] + [Conductor Reemplazo]     |
|  [!] Validacion RN-002: Tipo TAM coincide con Triage Rojo (Si eligiera TAB, mostrara alerta).     |
|                                                                                                   |
|  MOTIVO DE ASIGNACIÓN MANUAL (Obligatorio - RN-007):                                              |
|  Causal operativa: [ Bloqueo o cierre vial en ruta de unidad sugerida                        |v]  |
|  Justificacion tecnica detallada (sin excepcion):                                                 |
|  +---------------------------------------------------------------------------------------------+  |
|  | Se reporta cierre preventivo por accidente sobre la Carrera 7 en ruta de MOVIL-104. Se      |  |
|  | reasigna manualmente a MOVIL-106 por corredor sur despejado para garantizar atencion vital.  |  |
|  +---------------------------------------------------------------------------------------------+  |
|  Estado de validacion: [OK] Campo diligenciado (163 caracteres). Boton de guardado habilitado.    |
|                                                                                                   |
|  [ CANCELAR Y VOLVER A CU-03 ]              [ CONFIRMAR DESPACHO MANUAL Y AUDITAR (CU-04/CU-06) ] |
+---------------------------------------------------------------------------------------------------+
```

### 3.2 Diccionario de Datos y Validaciones de Pantalla P-02
| Control / Campo | Tipo | Origen / Entidad MER | Regla de Validación (`RN-002`, `RN-007`) |
|---|---|---|---|
| Selector de Ambulancia Habilitada | Lista desplegable (`Select`) | `AMBULANCIA` | Solo lista unidades en `estado_operativo = Disponible` con SOAT, tecnomecánica y REPS vigentes (`RN-001`, `RN-003`). |
| Alerta Clínica de Complejidad | Banner dinámico | Validación `RN-002` | Si el coordinador escoge una unidad `TAB` para un paciente en `Rojo` o `Naranja`, muestra advertencia clínica exigiendo confirmación expresa (`RF-023`, `RN-002`). |
| Justificación Obligatoria | Área de texto (`Textarea`) | `SERVICIO.motivo_asignacion_manual` y `HISTORIAL_ESTADOS_SERVICIO.motivo_justificacion` | **Obligatorio (`RN-007`)**: Si el campo está vacío o en blanco, el botón de confirmación permanece bloqueado y se muestra alerta visual en rojo (`RNF-018`). |
| Confirmar Despacho Manual | Botón primario | `CU-04` + `CU-06` | Marca `asignacion_manual = TRUE` en `SERVICIO`, actualiza estado e inserta registro inmutable en `AUDITORIA` (`RN-010`). |

---

## 4. Pantalla P-03: Formulario de Cierre Formal de Servicio y Facturación Inmutable (CU-05)
- **Caso de uso asociado:** `CU-05 · Realizar cierre formal de servicio` (incluye `CU-11 · Generar factura inmutable` y `CU-06 · Auditar evento transaccional`)
- **Actor:** Paramédico / Médico Tripulante (en unidad en campo) y Sistema SGA (validador/liquidador)
- **Requisitos cubiertos:** `RF-017`, `RF-019`, `RF-024`, `RF-025`, `RF-031`, `RF-055`, `RF-056`, `RNF-007`, `RNF-028`
- **Reglas de negocio:** `RN-005` (campos obligatorios de cierre Res. 3100/2019), `RN-006` (no cancelación en etapa de traslado/atención), `RN-010` (auditoría 5 años), `RN-014` (factura inmutable)
- **Objetivo:** Formalizar el cierre asistencial exigiendo todas las variables clínicas y hospitalarias obligatorias (`RN-005`), disparando de forma concurrente la liberación de la unidad, la emisión de la factura inmutable (`CU-11`) y el registro en auditoría (`CU-06`).

### 4.1 Representación Visual de la Interfaz

```text
+---------------------------------------------------------------------------------------------------+
| [SGA] CIERRE FORMAL DE SERVICIO Y FACTURACIÓN INMUTABLE (CU-05 / CU-11 / CU-06) | ID: SRV-0492    |
+---------------------------------------------------------------------------------------------------+
| 1. INFORMACIÓN OPERATIVA Y CRONOLOGÍA DEL SERVICIO (SERVICIO)                                     |
|---------------------------------------------------------------------------------------------------|
| Solicitud: SOL-2026-0892 | Ambulancia: MOVIL-106 (TAM) | Estado actual: Traslado -> [Finalizado]  |
| Paciente: [Paciente Anonimizado #892] | Documento: CC 00.000.000 | Antecedentes: Ninguno reportado |
| Tiempos: Asignacion [10:43] -> Llegada Sitio [10:50] -> Entrega IPS / Cierre [11:15] (Validado)  |
| Nota RN-006: Opcion "Cancelar Servicio" deshabilitada en estado Traslado (use Modulo Novedades). |
|                                                                                                   |
| 2. VARIABLES OBLIGATORIAS DE CIERRE CLÍNICO — RESOLUCIÓN 3100 / RN-005                            |
|---------------------------------------------------------------------------------------------------|
| Resultado de la atencion (*Obligatorio):     [ Traslado efectivo a institucion de salud       |v] |
| Estado final del paciente (*Obligatorio):    [ Estable                                        |v] |
|   (Opciones: Estable / Critico / Fallecido)                                                       |
| Destino de traslado / IPS Receptora (*):     [ IPS Receptora Habilitada - Nivel III           |v] |
| Responsable de cierre en servicio (*):       [ [Paramedico Lider] — TP ReTHUS Verificada      |v] |
| Profesional receptor en urgencias IPS:       [ [Medico Urgencias IPS Receptora]               ]   |
| Observaciones clinicas de entrega:           [ Paciente estabilizado e ingresado a urgencias. ]   |
|                                                                                                   |
| 3. LIQUIDACIÓN AUTOMÁTICA Y EMISIÓN DE FACTURA INMUTABLE (CU-11 · RF-031 · RN-014)                |
|---------------------------------------------------------------------------------------------------|
| Tarifa base parametrizada (Tipo TAM): $ 320.000 COP | Recargo alta complejidad: $ 0 COP           |
| Valor total a facturar: $ 320.000 COP | Estado inicial factura: Pendiente de pago                 |
| [i] Regla RN-014: Al confirmar el cierre se emitira factura Nro FAC-2026-0492 con caracter        |
|     INMUTABLE (es_inmutable = TRUE). Correcciones futuras solo mediante Nota Credito o Debito.    |
|                                                                                                   |
| 4. EJECUCIÓN CONCURRENTE AL CONFIRMAR (Fork / Join DA-02)                                         |
|---------------------------------------------------------------------------------------------------|
| [X] 1. Liberar unidad MOVIL-106 y tripulacion a estado 'Disponible' (AMBULANCIA / PERSONAL)       |
| [X] 2. Generar factura inmutable FAC-2026-0492 vinculada al servicio (CU-11 -> FACTURA)           |
| [X] 3. Sellar evento transaccional en bitacora (CU-06 -> AUDITORIA e HISTORIAL_ESTADOS_SERVICIO)  |
|                                                                                                   |
|  [ GUARDAR BORRADOR ]                           [ CONFIRMAR CIERRE FORMAL DE SERVICIO (RN-005) ]  |
+---------------------------------------------------------------------------------------------------+
```

### 4.2 Diccionario de Datos y Comportamiento de Pantalla P-03
| Control / Campo | Tipo | Origen / Entidad MER | Regla de Validación (`RN-005`, `RN-014`) |
|---|---|---|---|
| Resultado de la Atención | Lista desplegable (`Enum`) | `SERVICIO.resultado_atencion` | **Obligatorio (`RN-005`)**: Traslado efectivo a IPS, Atención resuelta en sitio o Desistimiento voluntario. |
| Estado Final del Paciente | Lista desplegable (`Enum`) | `SERVICIO.estado_paciente_final` | **Obligatorio (`RN-005`)**: `Estable`, `Crítico` o `Fallecido`. |
| Destino de Traslado (IPS) | Selector / Texto | `SERVICIO.destino_traslado` | **Obligatorio (`RN-005`)** cuando hay traslado; si se atiende en sitio (Flujo alterno `4a`), se deshabilita exigiendo constancia en observaciones. |
| Responsable de Cierre | Selector automático ReTHUS | `SERVICIO.responsable_cierre_id` (`PERSONAL`) | **Obligatorio (`RN-005`)**: Vincula al paramédico o médico tripulante autenticado. |
| Cronología del Servicio | Campos hora validados | `SERVICIO.hora_asignacion / llegada / fin` | Valida coherencia cronológica (`hora_fin > llegada >= asignacion`); de lo contrario bloquea el cierre (`RNF-018`). |
| Bloque Factura Inmutable | Resumen calculado | `FACTURA` (`es_inmutable`, `valor_total`) | Genera automáticamente el comprobante con tarifas parametrizadas `TAB/TAM` al cerrar (`RF-031`, `RN-014`). |
| Botón «Confirmar Cierre Formal» | Acción crítica (`RNF-007`) | `CU-05` + `CU-11` + `CU-06` | Bloquea el envío si falta algún campo obligatorio de `RN-005`; al aprobar, ejecuta en paralelo la liberación del móvil (`AMBULANCIA`), emisión de `FACTURA` y registro en `AUDITORIA`. |

---

## 5. Trazabilidad con Casos de Uso y Entidades del MER

| Pantalla | Caso de Uso Principal y Relaciones | Actores Participantes | Entidades Exactas del MER Relacional (`04-modelo-entidad-relacion.svg`) |
|---|---|---|---|
| **P-01** | `CU-03 · Asignar ambulancia automáticamente` (incluye `CU-02`; conecta a `CU-07`) | Coordinador Operativo, Sistema Automático SGA | `SOLICITUD_EMERGENCIA`, `PACIENTE`, `AMBULANCIA`, `SERVICIO`, `PERSONAL`, `PERSONAL_SERVICIO` |
| **P-02** | `CU-04 · Asignar ambulancia con justificación manual` (extiende a `CU-03`; incluye `CU-06`) | Coordinador Operativo, Sistema Automático SGA | `SERVICIO`, `AMBULANCIA`, `HISTORIAL_ESTADOS_SERVICIO` (Débil), `AUDITORIA` |
| **P-03** | `CU-05 · Realizar cierre formal de servicio` (incluye `CU-11` y `CU-06`) | Paramédico / Tripulante, Sistema Automático SGA | `SERVICIO`, `PACIENTE`, `PERSONAL`, `AMBULANCIA`, `FACTURA`, `HISTORIAL_ESTADOS_SERVICIO`, `AUDITORIA` |
