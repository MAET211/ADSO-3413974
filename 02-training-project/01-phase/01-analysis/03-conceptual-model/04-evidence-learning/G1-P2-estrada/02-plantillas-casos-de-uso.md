# 02 · Plantillas Extendidas de Casos de Uso Críticos
## Proyecto Formativo: Sistema Gestor de Ambulancias (SGA)
### Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz:** `MAET211` (Carpeta: `G1-P2-estrada`)  
**Fase del Proyecto:** 01 - Análisis | **Competencia:** 220501093 | **RAP:** 592373 (Criterio C2)  

---

## Introducción y Pautas Metodológicas de Redacción

Para dar estricto cumplimiento al **Criterio C2 de la Rúbrica G1-P2 (RAP 592373)** y a las reglas de arbitraje de la **Sección 7**, las siguientes tres (3) plantillas extendidas de casos de uso se elaboran con base en el **Anexo A oficial**:
1. **Regla de Precondiciones (Sección 7, Regla 3):** Se declaran únicamente los estados que el sistema asume como ciertos antes de que el actor ejecute la acción inicial. Cualquier comprobación o validación dinámica realizada por el software durante el caso se especifica como flujo alterno o excepción.
2. **Regla de Flujos Alternos vs Excepciones (Sección 7, Regla 4):**
   * **Flujo alterno:** Variante válida del negocio que permite al actor alcanzar un resultado exitoso alternativo (ej. atención resuelta en sitio sin traslado o activación de protocolo manual por saturación de flota).
   * **Excepción:** Falla operativa o transgresión de una regla de negocio que impide el objetivo del actor y provoca el rechazo o bloqueo de la acción (ej. ambulancia con SOAT/REPS vencido o cierre sin variables clínicas obligatorias).
3. **Prohibición de Jerga Técnica (Sección 7, Regla 10):** Toda la redacción describe la **intención del actor y la respuesta del sistema**, suprimiendo deliberadamente nombres de tablas físicas de base de datos, sentencias SQL, frameworks o protocolos técnicos.
4. **Coherencia con el Modelo de Dominio y Prototipo:** Cada concepto citado (`SolicitudEmergencia`, `Paciente`, `ServicioAsistencial`, `Ambulancia` TAB/TAM, `PersonalSalud`, `Factura`, `RegistroAuditoria`) coincide estrictamente con el diccionario conceptual de [`03-modelo-dominio.svg`](./03-modelo-dominio.svg) y enlaza 1:1 con [`05-prototipo-mockups.md`](./05-prototipo-mockups.md).

---

## 1. Plantilla Extendida: CU-03 · Asignar Ambulancia Automáticamente (Incluye CU-02)

| Campo | Especificación Formal del Caso de Uso (Anexo A) |
| :--- | :--- |
| **Identificador y Nombre:** | **CU-03 · Asignar ambulancia automáticamente (Incluye CU-02 · Radicar solicitud de emergencia)** |
| **Requisitos que atiende:** | `RF-009`, `RF-011`, `RF-014`, `RF-015`, `RF-016`, `RF-018`, `RF-019`, `RF-021`, `RF-022`, `RF-028`, `RF-029`, `RNF-009` |
| **Actor Primario:** | Coordinador Operativo (Iniciador). |
| **Actores Secundarios:** | Sistema Automático SGA (Ejecutor del algoritmo de despacho) y Paramédico / Tripulación Asistencial (Receptores en campo). |
| **Objetivo del Actor:** | Registrar una solicitud de emergencia con su clasificación clínica y lograr que el sistema seleccione y despache autónomamente la ambulancia TAB o TAM idónea en un máximo de 2 segundos. |
| **Precondiciones:** | 1. El coordinador operativo tiene sesión iniciada con privilegios activos de despacho.<br>2. El inventario institucional registra ambulancias dadas de alta con tripulación vinculada. |
| **Disparador:** | El coordinador recibe una llamada de auxilio y selecciona la opción *"Nueva Solicitud de Emergencia"*. |
| **Flujo Principal (Paso a Paso):** | 1. El coordinador registra los datos del reportante, la ubicación del evento, la identidad disponible del paciente y su sintomatología inicial.<br>2. El coordinador asigna la prioridad clínica según la escala de triage: **Rojo o Naranja** (emergencia/urgencia alta) o **Amarillo o Verde** (urgencia moderada o baja complejidad).<br>3. El coordinador confirma la radicación de la solicitud de emergencia.<br>4. El sistema almacena la solicitud en estado recibido y activa el motor de despacho automático (`DA-01`).<br>5. El sistema filtra la flota operativa según la regla clínica (`RN-002`): unidades de Transporte Asistencial Medicalizado (`TAM`) para prioridades Rojo/Naranja, o unidades de Transporte Asistencial Básico (`TAB`) para prioridades Amarillo/Verde.<br>6. El sistema descarta unidades sin vigencia de SOAT, revisión técnico-mecánica o habilitación REPS (`RN-003`) y verifica que el personal de turno esté disponible y certificado (`RN-004`).<br>7. El sistema selecciona la unidad disponible con menor distancia estimada, crea el servicio asistencial, cambia la unidad a ocupada y envía la orden de despacho a la tripulación.<br>8. La tripulación confirma la recepción de la orden y actualiza el estado del servicio a *En Ruta*, reflejando el cambio en tiempo real en el tablero del coordinador. |
| **Flujos Alternos:** | **6a. Contingencia por Saturación de Flota o Ausencia de Unidades Aptas:**<br>1. Si ninguna ambulancia del tipo requerido cumple disponibilidad (`RN-001`) y documentación vigente (`RN-003`), el sistema notifica inmediatamente en el tablero la condición `[Sin unidades o REPS vencido]`.<br>2. Conforme a la bifurcación de `DA-01`, el coordinador activa el protocolo de apoyo manual o coordinación externa con la red reguladora de urgencias, registrando la trazabilidad del incidente. |
| **Excepciones:** | **6b. Bloqueo Preventivo por Documentación Sanitaria o Personal Inhabilitado:**<br>1. Si la ambulancia más cercana presenta SOAT, técnico-mecánica o habilitación REPS vencidos (`RN-003`), o su tripulación supera el límite de horas continuas o tiene certificaciones vencidas (`RN-004`), el sistema bloquea su asignación.<br>2. El sistema excluye esa unidad de los candidatos y evalúa la siguiente ambulancia habilitada emitiendo una alerta administrativa en el panel. |
| **Postcondiciones:** | La solicitud de emergencia queda despachada en un servicio activo; la ambulancia cambia a ocupada; la tripulación queda en ruta y se registra el hito inicial de auditoría. |
| **Reglas de Negocio:** | `RN-001` (Disponibilidad), `RN-002` (Tipo TAB/TAM vs Triage), `RN-003` (Vigencia REPS/SOAT), `RN-004` (Habilitación de personal). |
| **Pantalla del Prototipo:** | `[Mockup P-01: Tablero de Triage, Monitoreo y Despacho Automatizado (CU-03)]` |

---

## 2. Plantilla Extendida: CU-04 · Asignar Ambulancia con Justificación Manual

| Campo | Especificación Formal del Caso de Uso (Anexo A) |
| :--- | :--- |
| **Identificador y Nombre:** | **CU-04 · Asignar ambulancia con justificación manual (Extiende a CU-03)** |
| **Requisitos que atiende:** | `RF-022`, `RF-023`, `RF-024`, `RF-055`, `RF-056`, `RF-057`, `RNF-028` |
| **Actor Primario:** | Coordinador Operativo (Iniciador y Tomador de Decisión). |
| **Actores Secundarios:** | Sistema Automático SGA (Validador de reglas y registrador de auditoría). |
| **Objetivo del Actor:** | Sustituir de forma controlada y justificada la ambulancia propuesta por el algoritmo automático cuando una contingencia operativa requiere asignar otra unidad específica. |
| **Precondiciones:** | 1. El caso de uso base `CU-03` ha evaluado una solicitud activa (ya sea con unidad sugerida o bajo contingencia `[Sin unidades o REPS vencido]`).<br>2. El coordinador posee un perfil autenticado con autorización de despacho manual. |
| **Disparador:** | El coordinador presiona la opción *"Asignación Manual con Justificación"* en el tablero de despacho (**P-01**). |
| **Flujo Principal (Paso a Paso):** | 1. El coordinador visualiza la propuesta automática o el aviso de contingencia y solicita la modificación manual.<br>2. El sistema abre la ventana modal de justificación (**P-02**) listando las ambulancias que cumplen disponibilidad y documentación vigente.<br>3. El coordinador selecciona la ambulancia de reemplazo acorde con el nivel de atención requerido.<br>4. El coordinador escoge la causal operativa (cierre vial, falla sobrevenida o priorización clínica) y redacta la justificación técnica obligatoria.<br>5. El coordinador confirma la asignación manual.<br>6. El sistema verifica que la justificación no esté vacía y que la unidad seleccionada cumpla las habilitaciones vigentes.<br>7. El sistema marca el servicio con indicador de asignación manual, actualiza los estados operativos de la ambulancia saliente y la entrante, y sella el motivo y el usuario responsable en el historial de estados y la bitácora inmutable de auditoría (`CU-06`). |
| **Flujos Alternos:** | **6a. Advertencia Clínica por Diferencia de Complejidad (TAB en Triage Crítico):**<br>1. Si el coordinador elige manualmente una unidad básica (`TAB`) para atender un paciente con prioridad `Rojo` o `Naranja` que demanda unidad medicalizada (`TAM`), el sistema despliega una alerta preventiva de riesgo clínico conforme a `RN-002`.<br>2. El coordinador confirma explícitamente su responsabilidad operativa por contingencia vital y el sistema completa la asignación registrando la advertencia en auditoría. |
| **Excepciones:** | **6b. Bloqueo por Omisión de Motivo Obligatorio (`RN-007`):**<br>1. Si el coordinador intenta confirmar la asignación manual sin diligenciar la justificación escrita requerida, el sistema impide guardar el cambio.<br>2. El sistema resalta el campo obligatorio con un mensaje correctivo indicando la exigencia normativa de registrar el motivo técnico antes de continuar. |
| **Postcondiciones:** | El servicio queda vinculado a la unidad elegida manualmente; la justificación, la causal y la identidad del coordinador quedan conservadas de forma inalterable en la bitácora de auditoría. |
| **Reglas de Negocio:** | `RN-002` (Advertencia clínica TAB/TAM), `RN-003` (Habilitación sanitaria), `RN-007` (Obligatoriedad de justificación en asignación manual), `RN-010` (Inmutabilidad de auditoría). |
| **Pantalla del Prototipo:** | `[Mockup P-02: Ventana Modal de Justificación de Despacho Manual (CU-04)]` |

---

## 3. Plantilla Extendida: CU-05 · Realizar Cierre Formal de Servicio

| Campo | Especificación Formal del Caso de Uso (Anexo A) |
| :--- | :--- |
| **Identificador y Nombre:** | **CU-05 · Realizar cierre formal de servicio (Incluye CU-11 · Generar factura inmutable y CU-06 · Auditar evento)** |
| **Requisitos que atiende:** | `RF-017`, `RF-019`, `RF-024`, `RF-025`, `RF-031`, `RF-055`, `RF-056`, `RNF-007`, `RNF-028` |
| **Actor Primario:** | Paramédico / Médico Tripulante (Líder de tripulación en campo). |
| **Actores Secundarios:** | Coordinador Operativo (Supervisor) y Sistema Automático SGA (Validador clínico, emisor de factura y auditor). |
| **Objetivo del Actor:** | Documentar las variables clínicas obligatorias de finalización de la atención y cerrar formalmente el servicio asistencial, liberando la ambulancia y disparando la facturación e historial auditado. |
| **Precondiciones:** | 1. El servicio asistencial se encuentra activo en etapa de atención en sitio o traslado hacia institución receptora.<br>2. El responsable de cierre cuenta con sesión autenticada y registro de habilitación activo en el servicio. |
| **Disparador:** | El paramédico selecciona la opción *"Confirmar Cierre Formal de Servicio"* en el formulario asistencial (**P-03**). |
| **Flujo Principal (Paso a Paso):** | 1. El paramédico concluye el traslado asistencial en la institución hospitalaria de destino y accede al servicio activo (`DA-02`).<br>2. El sistema presenta el formulario de cierre formal de atención conforme a los parámetros normativos de la Resolución 3100 (`RN-005`).<br>3. El paramédico registra obligatoriamente el **resultado de la atención** (ej. traslado efectivo), el **estado final del paciente** (estable, crítico o fallecido), la **institución hospitalaria destino** y se confirma como **responsable de cierre**.<br>4. El paramédico revisa la coherencia de los horarios operativos (asignación, arribo y cierre) y confirma la finalización.<br>5. El sistema valida la completitud obligatoria de todos los campos exigidos (`[Campos obligatorios diligenciados]` en `DA-02`).<br>6. El sistema transiciona el estado del servicio a *Finalizado* y ejecuta en paralelo tres acciones concurrentes (bloque *Fork/Join* de `DA-02`):<br>   a) **Liberación operativa:** Cambia la ambulancia y su tripulación nuevamente al estado *Disponible*.<br>   b) **Facturación inmutable (`CU-11`):** Emite automáticamente la factura definitiva e inalterable vinculada al servicio (`RN-014`).<br>   c) **Auditoría transaccional (`CU-06`):** Sella el evento de cierre y los datos finales en la bitácora inmutable de auditoría (`RN-010`).<br>7. El sistema archiva el expediente asistencial cerrado y presenta la confirmación de liberación y comprobante al paramédico y al coordinador. |
| **Flujos Alternos:** | **3a. Resolución en Sitio sin Traslado a Institución Hospitalaria:**<br>1. Si el paciente recibe atención prehospitalaria completa en el lugar del incidente o firma desistimiento voluntario sin requerir traslado, el paramédico selecciona el resultado *"Atención resuelta en sitio"* o *"Desistimiento voluntario"*.<br>2. El sistema registra la novedad clínica correspondiente en las observaciones de entrega, valida la completitud del estado final y del responsable, y completa exitosamente el cierre sin traslado hospitalario. |
| **Excepciones:** | **5a. Bloqueo por Datos Incompletos (`RN-005`):**<br>1. Si falta cualquiera de los cuatro datos obligatorios (resultado de atención, estado final del paciente, destino o responsable), el sistema toma la rama `[Datos incompletos (Bloqueo RN-005)]` de `DA-02`.<br>2. El sistema bloquea la transición a *Finalizado*, resalta los campos faltantes y no libera la ambulancia ni genera la factura hasta su corrección.<br><br>**5b. Bloqueo por Intento de Cancelación en Etapa Avanzada (`RN-006`):**<br>1. Si se intenta anular o cancelar un servicio que ya alcanzó el estado *En Ruta*, *En Atención* o *Traslado*, el sistema rechaza la cancelación e indica que toda interrupción debe documentarse como novedad operativa y formalizar su cierre. |
| **Postcondiciones:** | El servicio queda cerrado en estado *Finalizado*; la ambulancia retorna a *Disponible*; queda emitida la factura inmutable (`RN-014`) sin posibilidad de edición directa; y la bitácora de auditoría conserva el registro íntegro. |
| **Reglas de Negocio:** | `RN-005` (Cierre obligatorio completo), `RN-006` (Restricción de cancelación tardía), `RN-010` (Auditoría inmutable por 5 años), `RN-014` (Inmutabilidad de factura). |
| **Pantalla del Prototipo:** | `[Mockup P-03: Formulario de Cierre Formal de Servicio y Facturación Inmutable (CU-05)]` |
