# Prototipo Inicial (Mockups) · Sistema Gestor de Ambulancias (SGA)
**Evidencia:** Guía 1 · Producto 2 (G1-P2)  
**Criterio:** RAP 592374 (Criterio C5) — Realiza prototipo inicial del software de acuerdo con los casos de uso identificados  
**Aprendiz:** `MAET211` (Carpeta: `G1-P2-estrada`)  
**Ficha:** 3413974 · ADSO · Centro de la Industria, la Empresa y los Servicios (CIES)  
**Fecha:** Noviembre 2026  

---

## 1. Introducción y Criterios de Diseño

El presente documento contiene el prototipo inicial de interfaz gráfica de usuario para el **Sistema Gestor de Ambulancias (SGA)**, cubriendo los tres casos de uso operativamente críticos identificados en el análisis conceptual:
1. **Pantalla P-01 (CU-03):** Tablero de Control de Despacho y Monitoreo Georreferenciado en Tiempo Real.
2. **Pantalla P-02 (CU-04):** Modal de Reasignación Manual de Ambulancia con Registro de Auditoría (RN-007).
3. **Pantalla P-03 (CU-05):** Formulario Clínico-Financiero de Cierre de Servicio Asistencial y Liquidación de Copago (RN-005).

Cada pantalla se encuentra debidamente rotulada con su caso de uso asociado, eliminando cualquier pantalla huérfana y garantizando la trazabilidad hacia los requisitos funcionales (RF-04, RF-05, RF-06, RF-09, RF-10, RF-11, RF-12, RF-14, RF-15, RF-16, RF-21, RF-44).

---

## 2. Pantalla P-01: Tablero de Despacho y Monitoreo Georreferenciado
- **Caso de uso asociado:** `CU-03 · Despachar ambulancia automáticamente`
- **Actor:** Despachador / Operador de Centro Regulador (CRUE / Central SGA)
- **Requisitos cubiertos:** RF-04, RF-05, RF-06, RF-10, RF-11, RF-12, RF-14
- **Objetivo:** Visualizar en tiempo real los incidentes entrantes clasificados por triage, el mapa con ubicación de móviles disponibles y la asignación algorítmica de la unidad óptima por cercanía y tipo de soporte vital.

### 2.1 Representación Visual de la Interfaz

```
+--------------------------------------------------------------------------------------------------------------------------+
| [SGA] SISTEMA GESTOR DE AMBULANCIAS | CENTRAL REGULADORA NEIVA                 | Operador: estrada | [Turno Activo] [10:42] |
+--------------------------------------------------------------------------------------------------------------------------+
| BANDEJA DE INCIDENTES PENDIENTES (TRIAGE)      | MAPA GEORREFERENCIADO DE FLOTA Y COBERTURA (NEIVA SUR / CENTRO)         |
|------------------------------------------------|-------------------------------------------------------------------------|
| [!] INC-2026-0892 | Triage I (Rojo)            |   [+] Zoom | [-] Reset | Capas: [X] TAB  [X] TAM  [X] Zonas Congestión |
|   Ubicacion: Calle 8 con Cra 5 (Centro)        |   -------------------------------------------------------------------   |
|   Motivo: Politraumatismo colision vehicular   |   (Mapa Interactivo GIS - Visualizacion GPS)                            |
|   Tiempo espera: 01m 24s                       |                                                                         |
|   Tipo unidad requerida: TAM (Medicalizada)    |       [ M-104 (TAM) ]  *Libre - Cra 7 # 12-40                           |
|   [ Despachar Auto ] [ Ver Detalle ]           |              \  (Ruta calculada: 1.8 km - ETA: 4.2 min)                  |
|------------------------------------------------|               v                                                         |
| [!] INC-2026-0893 | Triage II (Amarillo)       |             [ INC-0892 ] Centro (Calle 8 # 5-20)                       |
|   Ubicacion: Cra 15 # 22-10 (Las Granjas)      |                                                                         |
|   Motivo: Dificultad respiratoria aguda        |       [ M-101 (TAB) ]  *Ocupada - En traslado a Hosp. Universitario     |
|   Tiempo espera: 03m 10s                       |       [ M-102 (TAB) ]  *Libre - Base Norte                              |
|   Tipo unidad requerida: TAB (Basica)          |       [ M-105 (TAM) ]  *Mantenimiento preventivo                        |
|   [ Despachar Auto ] [ Ver Detalle ]           |                                                                         |
|------------------------------------------------+-------------------------------------------------------------------------|
| PANEL DE DECISIÓN ALGORÍTMICA DE DESPACHO (CU-03)                                                                        |
|--------------------------------------------------------------------------------------------------------------------------|
| Incidente Seleccionado: INC-2026-0892 | Paciente: NN Masculino ~35 anos | Triage: I (CRITICO)                              |
| Algoritmo de Asignacion: Unidad sugerida -> MOVIL M-104 (TAM)                                                             |
| Criterios evaluados:                                                                                                     |
|  - Tipo de ambulancia: Medicalizada (Cumple requerimiento de soporte avanzado)                                          |
|  - Distancia euclidiana / ruta vial: 1.8 Kilometros | Tiempo estimado de arribo (ETA): 4 minutos 12 segundos                 |
|  - Tripulacion activa: Dr. C. Mendoza (Medico ReTHUS) + Param. R. Silva + Cond. E. Perdomo                              |
|                                                                                                                          |
|  [ ACCIÓN: CONFIRMAR DESPACHO AUTOMÁTICO ]        [ ACCIÓN: FORZAR REASIGNACIÓN MANUAL (CU-04) ]                         |
+--------------------------------------------------------------------------------------------------------------------------+
```

### 2.2 Diccionario de Datos y Controles de Pantalla P-01
| Control / Campo | Tipo | Origen de Datos | Regla de Validación / Comportamiento |
|---|---|---|---|
| Lista de Incidentes | Tabla de selección | `SOLICITUD_EMERGENCIA` | Ordenada descendentemente por severidad de Triage (I > II > III) y tiempo de espera |
| Indicador Triage | Badge de color | `SOLICITUD_EMERGENCIA.nivel_triage` | Rojo (#E53E3E) para Triage I, Amarillo (#DD6B20) para II, Verde (#38A169) para III |
| Mapa GIS | Canvas interactivo | API Mapas + GPS Móviles | Proyecta las coordenadas `(lat, lng)` de incidentes y móviles en tiempo real |
| Botón «Confirmar Despacho Automático» | Botón de acción principal | CU-03 Paso 6 | Ejecuta el cambio de estado a `DESPACHADO`, bloquea el móvil y notifica a la tripulación |
| Botón «Forzar Reasignación Manual» | Botón de acción secundaria | CU-04 Disparador | Abre el modal flotante P-02 exigiendo justificación escrita bajo RN-007 |

---

## 3. Pantalla P-02: Modal de Reasignación Manual con Justificación de Auditoría
- **Caso de uso asociado:** `CU-04 · Reasignar ambulancia manualmente con justificación`
- **Actor:** Despachador / Coordinador de Operaciones
- **Requisitos cubiertos:** RF-06, RF-09, RF-10, RF-12, RF-14, RF-15, RN-007
- **Objetivo:** Permitir la anulación del despacho algorítmico cuando existen factores operativos extraordinarios (falla mecánica, bloqueo de vía, orden médica superior), registrando obligatoriamente una justificación de mínimo 20 caracteres para trazabilidad en auditoría.

### 3.1 Representación Visual de la Interfaz

```
+---------------------------------------------------------------------------------------------------+
|  MODAL: REASIGNACIÓN MANUAL DE UNIDAD MÓVIL (CU-04)                                           [X] |
+---------------------------------------------------------------------------------------------------+
|  ADVERTENCIA DE AUDITORÍA:                                                                        |
|  La reasignacion manual anula el despacho algoritmico optimizado. Esta accion quedara registrada  |
|  en el HISTORIAL_ESTADOS_SERVICIO con fecha, hora, usuario responsable e IP bajo norma RN-007.     |
|---------------------------------------------------------------------------------------------------|
|  Incidente en curso: INC-2026-0892 | Triage I (Rojo) | Cra 5 # 8-20 Centro                        |
|  Unidad actualmente asignada: MOVIL M-104 (TAM) -> Estado: EN_RUTA (Distancia: 1.8 km)             |
|                                                                                                   |
|  SELECCIÓN DE NUEVA UNIDAD DE REEMPLAZO:                                                          |
|  Ambulancia disponible: [ MOVIL M-106 (TAM) - Ubicada en Base Sur (3.1 km - ETA: 6.5 min)    |v] |
|  Tripulacion de reemplazo: Dra. L. Gomez (Medico) + TPH J. Cruz + Cond. M. Lopez                  |
|                                                                                                   |
|  MOTIVO OPERATIVO NORMALIZADO:                                                                    |
|  Causal: [ Falla mecanica sobrevenida en vehiculo asignado                                    |v] |
|          - Opciones: Falla mecanica / Congestion vial no sorteable / Prioridad vital externa /   |
|                      Novedad de salud en tripulacion / Cambio de condicion del paciente           |
|                                                                                                   |
|  JUSTIFICACIÓN TÉCNICA Y OPERATIVA DETALLADA (Obligatorio - Minimo 20 caracteres):                |
|  +---------------------------------------------------------------------------------------------+  |
|  | Conductor reporta pinchadura de neumatico delantero derecho en Cra 6 con Calle 10. Unidad   |  |
|  | queda temporalmente inmovilizada. Se requiere despacho urgente de M-106 por Triage I.      |  |
|  +---------------------------------------------------------------------------------------------+  |
|  Contador: 142 caracteres ingresados (Valido: >= 20 caracteres)                                   |
|                                                                                                   |
|  CONFIRMACIÓN DE RESPONSABILIDAD:                                                                 |
|  [X] Certifico que la reasignacion se efectua por fuerza mayor salvaguardando la vida del paciente|
|                                                                                                   |
|  [ CANCELAR OPERACIÓN ]                   [ CONFIRMAR REASIGNACIÓN Y NOTIFICAR AUDITORÍA ]         |
+---------------------------------------------------------------------------------------------------+
```

### 3.2 Diccionario de Datos y Validaciones de Pantalla P-02
| Control / Campo | Tipo | Origen de Datos | Regla de Validación (RN-007) |
|---|---|---|---|
| Selector de Nueva Unidad | Desplegable (Select) | `AMBULANCIA` (filtradas) | Solo muestra ambulancias operativas con el tipo de soporte requerido (TAB o TAM) |
| Causal Estandarizada | Desplegable (Enum) | Catálogo de Causales | Selección obligatoria de una categoría predefinida para analítica operativa |
| Justificación Detallada | Área de texto (Textarea) | `HISTORIAL_ESTADOS_SERVICIO.motivo_justificacion` | **Obligatorio: Longitud $\ge$ 20 caracteres**. Si tiene menos de 20 caracteres, el botón de confirmación permanece deshabilitado |
| Checkbox Certificación | Checkbox booleano | Interfaz de control | Obligatorio estar marcado para habilitar el guardado |
| Botón «Confirmar Reasignación» | Botón primario de guardado | CU-04 Paso 5 | Actualiza la asignación, libera la unidad anterior a estado `DISPONIBLE_FALLA` y registra la fila de auditoría |

---

## 4. Pantalla P-03: Cierre de Servicio Asistencial y Liquidación de Copago
- **Caso de uso asociado:** `CU-05 · Cerrar servicio asistencial y liquidar copago`
- **Actor:** Médico Asistencial / Facturador de Despacho
- **Requisitos cubiertos:** RF-16, RF-21, RF-44, RN-005, RN-008
- **Objetivo:** Registrar la entrega formal del paciente en la institución prestadora de salud (IPS receptora), documentar el resumen de atención clínica de traslado y liquidar automáticamente el copago o cuota moderadora según el régimen de afiliación en salud.

### 4.1 Representación Visual de la Interfaz

```
+---------------------------------------------------------------------------------------------------+
| [SGA] CIERRE CLÍNICO-ASISTENCIAL Y LIQUIDACIÓN FINANCIERA (CU-05)            | Servicio: SRV-0492 |
+---------------------------------------------------------------------------------------------------+
| 1. DATOS GENERALES DEL SERVICIO Y ENTREGA HOSPITALARIA                                            |
|---------------------------------------------------------------------------------------------------|
| Solicitud: INC-2026-0892 | Ambulancia: M-106 (TAM) | Medico: Dra. Laura Gomez (RM-98421 Huila)    |
| Paciente: [Paciente Simulado / Anonimizado] | CC: 00.000.000 | EPS: Sanitas | Regimen: [ Contributivo |v] |
| IPS Receptora: [ Hospital Universitario Hernando Moncaleano Perdomo                           |v] |
| Medico Receptor IPS: Dr. Fernando Ruiz (Urgencias Adultos) | Hora Entrega IPS: [ 11:15 ]          |
|                                                                                                   |
| 2. RESUMEN CLÍNICO DEL TRASLADO ASISTENCIAL (VALORACION_CLINICA)                                  |
|---------------------------------------------------------------------------------------------------|
| Signos Vitales al Arribo:                                                                         |
|  - PA: [ 120/80 ] mmHg  | FC: [ 84 ] lpm  | FR: [ 18 ] rpm  | SpO2: [ 98 ] %  | Glasgow: [ 15/15 ] |
| Diagnostico Principal CIE-10: [ S06.0 - Conmocion Cerebral                                    |v] |
| Procedimientos Realizados:                                                                        |
|  [X] Inmovilizacion cervical  [X] Oxigenoterapia por canula  [X] Canalizacion via venosa perif.  |
| Observaciones Medicas: Paciente estable durante traslado, sin signos de deterioro neurologico.    |
|                                                                                                   |
| 3. LIQUIDACIÓN DE COPAGO / CUOTA MODERADORA (RN-005)                                              |
|---------------------------------------------------------------------------------------------------|
| Categoria Salarial Afiliado: [ Rango B (Entre 2 y 5 SMMLV)                                    |v] |
| Tarifa Base Transporte Asistencial Medicalizado:        $ 285.000 COP                             |
| Cobertura Obligatoria EPS (85%):                       - $ 242.250 COP                            |
| Valor Copago Liquidado a Paciente / Acompanante:         $  42.750 COP                            |
|                                                                                                   |
| Metodo de Recaudo: [ En Sitio / Transferencia Digital PSE                                      |v] |
| Estado del Pago:   ( ) Pendiente de Facturacion Centralizada   (*) Pagado en Sitio (Recibo #8921) |
|                                                                                                   |
| 4. FINALIZACIÓN Y FIRMA DIGITAL                                                                   |
|---------------------------------------------------------------------------------------------------|
| Firma Digital Medico ReTHUS: [ HASH VERIFICADO: 4a8f9b2c1e7d... ]  Certificado Digital Activo     |
| [X] Confirmo que la informacion medica y financiera es veridica y el paciente quedo ingresado    |
|                                                                                                   |
|  [ GUARDAR BORRADOR ]                              [ PROCEDER AL CIERRE DEFINITIVO DEL SERVICIO ] |
+---------------------------------------------------------------------------------------------------+
```

### 4.2 Diccionario de Datos y Comportamiento de Pantalla P-03
| Control / Campo | Tipo | Origen de Datos | Regla de Validación / Comportamiento |
|---|---|---|---|
| IPS Receptora | Desplegable (Select) | Catálogo IPS Habilitadas | Obligatorio; debe corresponder a un centro hospitalario con urgencias habilitadas |
| Hora de Entrega | Timepicker | Interfaz | Debe ser posterior a la hora de despacho y traslado |
| Diagnóstico CIE-10 | Autocompletar / Buscador | Maestro CIE-10 | Código de 4 caracteres alfanuméricos estandarizado por el Ministerio de Salud |
| Régimen y Categoría | Selector enlazado | `PACIENTE.tipo_afiliacion` | Aplica la fórmula legal: Exento para Triage I en SOAT/Régimen Subsidiado; tarifa porcentual según categoría en Contributivo |
| Valor Copago Liquidado | Campo calculado (Readonly) | RN-005 | Se calcula de forma inmediata al cambiar la categoría salarial o el régimen |
| Botón «Cierre Definitivo» | Botón principal de culminación | CU-05 Paso 7 | Transiciona el servicio a `CERRADO_ASISTIDO`, libera la ambulancia a `DISPONIBLE` y genera la factura inmutable |

---

## 5. Trazabilidad con Casos de Uso del Análisis Conceptual

| Pantalla | Caso de Uso | Actores Participantes | Entidades del MER Afectadas |
|---|---|---|---|
| **P-01** | `CU-03 · Despachar ambulancia automáticamente` | Despachador de Central, Sistema SGA | `SOLICITUD_EMERGENCIA`, `AMBULANCIA`, `SERVICIO_ASISTENCIAL`, `PERSONAL_SERVICIO` |
| **P-02** | `CU-04 · Reasignar ambulancia manualmente con justificación` | Despachador, Coordinador Operativo | `SERVICIO_ASISTENCIAL`, `AMBULANCIA`, `HISTORIAL_ESTADOS_SERVICIO` (Débil) |
| **P-03** | `CU-05 · Cerrar servicio asistencial y liquidar copago` | Médico Tripulante, Facturador | `SERVICIO_ASISTENCIAL`, `VALORACION_CLINICA`, `PACIENTE`, `AMBULANCIA` |
