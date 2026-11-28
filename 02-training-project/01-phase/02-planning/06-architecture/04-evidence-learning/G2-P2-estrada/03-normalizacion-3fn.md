# B3 · Evidencia de Normalización Paso a Paso (0FN → 3FN)
**Evidencia:** Guía 2 · Producto 2 (`G2-P2`) — Artefacto B3  
**Competencia:** 220501095 · **RAP:** 593101 (Criterio 3)  
**Aprendiz:** `MAET211` (Carpeta: `G2-P2-estrada`)  

---

## 1. Alcance de la Normalización

Siguiendo el **Criterio 3 (Nivel 100)** de `Rubricas_G2.md`, se normalizan paso a paso (`0FN` $\rightarrow$ `1FN` $\rightarrow$ `2FN` $\rightarrow$ `3FN`) **dos (2) tablas reales propias del proyecto SGA** con sus **dependencias funcionales (DF)** escritas explícitamente y el estado anterior y posterior en cada transición:
1. **Caso 1 (Llave Compuesta $\rightarrow$ Dependencia Parcial en 2FN y Transitiva en 3FN):** `registro_despacho_tripulacion` (da origen a `servicios`, `personal`, `personal_servicio`, `ambulancias` y `sedes`).
2. **Caso 2 (Atributo Multivaluado + Dependencias Transitivas en 3FN):** `expediente_solicitud_usuario` (da origen a `pacientes`, `paciente_telefonos`, `solicitudes_emergencia`, `usuarios`, `roles` y `sedes`).

Al finalizar, el modelo completo queda en **Tercera Forma Normal (3FN)** sin anomalías de inserción, actualización ni borrado. *(No se aplican desnormalizaciones ad-hoc en este modelo relacional.)*

---

## 2. Caso 1 · Normalización de `registro_despacho_tripulacion` (Llave Compuesta + Transitividad)

### Estado Inicial (`0FN`) — Registro Plano Consolidado de Planilla Prehospitalaria
`registro_despacho_crudo(`**`id_servicio, id_personal`**`, estado_servicio, hora_asignacion, id_ambulancia, placa, tipo_ambulancia, id_sede, nombre_sede, ciudad_sede, tarjeta_profesional, tipo_personal, nombre_tripulante, correos_y_roles_operativos)`

- **Llave primaria compuesta de partida:** `(id_servicio, id_personal)`.
- **Problemas iniciales:** La columna `correos_y_roles_operativos` concatena múltiples valores separados por coma (`"Lider / enfermero@sga, ..."`), y coexisten atributos propios de la ambulancia, la sede y el tripulante en la misma relación.

### Dependencias Funcionales Identificadas (`DF`)
- **DF1 (dependencia parcial solo de `id_servicio`):**  
  `id_servicio → estado_servicio, id_ambulancia, placa, tipo_ambulancia, id_sede, nombre_sede, ciudad_sede`
- **DF2 (dependencia parcial solo de `id_personal`):**  
  `id_personal → tarjeta_profesional, tipo_personal, nombre_tripulante`
- **DF3 (dependencia completa de la llave compuesta):**  
  `(id_servicio, id_personal) → rol_operativo, hora_asignacion, hora_liberacion, activo_en_tripulacion`
- **DF4 (dependencias transitivas encadenadas desde `id_servicio`):**  
  `id_servicio → id_ambulancia → placa, tipo_ambulancia, id_sede`  
  `id_ambulancia → id_sede → nombre_sede, ciudad_sede`

### Transición Paso a Paso

| Forma Normal | Violación Detectada (Antes) | Dependencias Funcionales Aplicadas | Resultado Normalizado (Después) |
|---|---|---|---|
| **0FN $\rightarrow$ 1FN** | Presencia de grupos repetitivos / celda no atómica (`correos_y_roles_operativos` mezclaba rol y correo en un mismo texto). | Toda columna debe ser atómica y tener dominio único. | Se atomiza la columna dejando únicamente `rol_operativo` y separando correo en el usuario correspondiente. Todos los campos quedan atómicos y con clave `(id_servicio, id_personal)`. |
| **1FN $\rightarrow$ 2FN** | **Dependencias parciales sobre la llave compuesta `(id_servicio, id_personal)`:** los datos del móvil y servicio dependen solo de `id_servicio` (DF1), y la tarjeta profesional solo de `id_personal` (DF2). | `id_servicio → estado, id_ambulancia, placa, tipo, id_sede, nombre_sede, ciudad_sede`<br>`id_personal → tarjeta_profesional, tipo_personal`<br>`(id_servicio, id_personal) → rol_operativo, hora_asignacion` | Se descompone en **tres relaciones sin dependencias parciales**:<br>1. `personal(id_personal PK, tarjeta_profesional, tipo_personal, ...)`<br>2. `personal_servicio(id_personal_servicio PK, id_servicio FK, id_personal FK, rol_operativo, hora_asignacion, hora_liberacion, activo_en_tripulacion)`<br>3. `servicio_temporal(id_servicio PK, estado, id_ambulancia, placa, tipo, id_sede, nombre_sede, ciudad_sede)` |
| **2FN $\rightarrow$ 3FN** | **Dependencias transitivas (DF4):** dentro de `servicio_temporal`, la `placa`, `tipo` e `id_sede` dependen transitivamente a través de `id_ambulancia`; y `nombre_sede`, `ciudad_sede` dependen de `id_sede`. | `id_servicio → id_ambulancia → (placa, tipo, id_sede)`<br>`id_ambulancia → id_sede → (nombre_sede, ciudad)` | Se extraen las entidades transitivas quedando en **3FN estricta**:<br>1. **`sedes`**`(id_sede PK, codigo_sede, nombre_sede, ciudad, direccion, activa)`<br>2. **`ambulancias`**`(id_ambulancia PK, id_sede FK, numero_unidad, placa, tipo, ...)`<br>3. **`servicios`**`(id_servicio PK, id_solicitud FK UNIQUE, id_ambulancia FK, estado, ...)` |

---

## 3. Caso 2 · Normalización de `expediente_solicitud_usuario` (1FN Multivaluada + Transitividad 3FN)

### Estado Inicial (`0FN`) — Ficha Única de Atención e Ingreso
`expediente_crudo(`**`id_solicitud`**`, codigo_radicado, direccion_evento, prioridad_triage, id_paciente, tipo_documento, numero_documento, nombre_paciente, fecha_nacimiento, telefonos_contacto, id_usuario_crea, correo_usuario, id_rol, nombre_rol, descripcion_rol, id_sede, nombre_sede)`

- **Llave primaria de partida:** `id_solicitud`.
- **Atributo no atómico:** `telefonos_contacto` almacena varios teléfonos en la misma celda (teléfono personal y teléfono familiar para contacto de emergencia `RF-018`).

### Dependencias Funcionales Identificadas (`DF`)
- **DF1 (clave $\rightarrow$ datos propios):** `id_solicitud → codigo_radicado, direccion_evento, prioridad_triage, id_paciente, id_usuario_crea`
- **DF2 (transitiva hacia paciente):** `id_solicitud → id_paciente → (tipo_documento, numero_documento, nombre_completo, fecha_nacimiento)`
- **DF3 (transitiva hacia usuario, rol y sede):**  
  `id_usuario → correo, nombre_completo, id_rol, id_sede`  
  `id_rol → nombre_rol, descripcion`  
  `id_sede → nombre_sede, ciudad, direccion`

### Transición Paso a Paso

| Forma Normal | Violación Detectada (Antes) | Dependencias Funcionales Aplicadas | Resultado Normalizado (Después) |
|---|---|---|---|
| **0FN $\rightarrow$ 1FN** | **Violación de atomicidad (`telefonos_contacto`):** una solicitud/paciente guarda varios números telefónicos concatenados en una sola columna. | Determinante compuesto de contacto: `(id_paciente, tipo_contacto, numero_telefono)`. | Se extrae el atributo multivaluado a tabla independiente:<br>**`paciente_telefonos`**`(id_telefono PK, id_paciente FK, tipo_contacto, numero_telefono, es_principal)` |
| **1FN $\rightarrow$ 2FN** | No hay dependencias parciales en `solicitudes_emergencia` al tener llave simple `id_solicitud`, mientras que `paciente_telefonos` adopta llave subrogada `id_telefono` y todos sus campos dependen únicamente de ella. | `id_solicitud → codigo_radicado, direccion_evento, prioridad_triage, id_paciente` | Todas las relaciones cumplen `2FN`. |
| **2FN $\rightarrow$ 3FN** | **Tres cadenas de dependencia transitiva (DF2 y DF3):** atributos de paciente dependían vía `id_paciente`, atributos de rol vía `id_rol` y atributos de sede vía `id_sede`. | `id_solicitud → id_paciente → datos_paciente`<br>`id_usuario → id_rol → (nombre_rol, descripcion)`<br>`id_usuario → id_sede → (nombre_sede, ciudad)` | Descomposición limpia en tablas independientes en **3FN**:<br>1. **`pacientes`**`(id_paciente PK, tipo_documento, numero_documento, nombre_completo, fecha_nacimiento, antecedentes_medicos)`<br>2. **`solicitudes_emergencia`**`(id_solicitud PK, id_paciente FK, codigo_radicado, direccion_evento, prioridad_triage, sintomatologia, ...)`<br>3. **`roles`**`(id_rol PK, nombre_rol, descripcion, activo)`<br>4. **`usuarios`**`(id_usuario PK, id_rol FK, id_sede FK, nombre_completo, correo, password_hash, ...)` |

---

## 4. Verificación Final de 3FN en Todo el Esquema (`16` Tablas)

- **Ninguna columna** contiene listas o valores múltiples (`1FN` al 100 %).
- **Las tablas con llave compuesta o asociativa** (`historial_estados_servicio` con PK `(id_servicio, numero_secuencia)` y `personal_servicio` con unicidad `(id_servicio, id_personal)`) no tienen atributos dependientes de un solo lado de la llave (`2FN` al 100 %).
- **Ningún atributo no clave** determina otro atributo no clave (`3FN` al 100 %).
