# 02 · Plantillas Extendidas de Casos de Uso Críticos
## Proyecto Formativo: Sistema Gestor de Ambulancias (SGA)
### Sistema de Gestión Integral de Movilidad Asistencial, Vigilancia y Traslado
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz:** Miguel Ángel Estrada Torrentes (GitHub: `MAET211` · Carpeta: `G1-P2-estrada`)  
**Fase del Proyecto:** 01 - Análisis | **Competencia:** 220501093 | **RAP:** 592373 (Criterio C2)  

---

## Introducción y Pautas Metodológicas de Redacción

Para dar estricto cumplimiento al **Criterio C2 de la Rúbrica G1-P2 (RAP 592373)** y a las reglas de arbitraje de la **Sección 7**, las siguientes tres (3) plantillas extendidas de casos de uso se elaboran con base en el **Anexo A oficial**:
1. **Regla de Precondiciones (Sección 7, Regla 3):** Se declaran únicamente los estados que el sistema asume como ciertos antes de que el actor ejecute la acción inicial. Cualquier comprobación o validación dinámica realizada por el software durante el caso se especifica como flujo alterno o excepción.
2. **Regla de Flujos Alternos vs Excepciones (Sección 7, Regla 4):** 
   * **Flujo alterno:** Variante válida del negocio que permite al actor alcanzar un resultado exitoso alternativo (ej. sugerencia de ambulancia de apoyo o despacho asistencial interinstitucional).
   * **Excepción:** Falla operativa o transgresión de una regla de negocio que impide el objetivo del actor y provoca el rechazo o bloqueo de la acción (ej. ambulancia con SOAT vencido o cierre sin variables clínicas obligatorias).
3. **Prohibición de Jerga Técnica (Sección 7, Regla 10):** Toda la redacción describe la **intención del actor y la respuesta del sistema**, suprimiendo deliberadamente nombres de tablas físicas de base de datos, sentencias SQL, frameworks o endpoints de API.

---

## 1. Plantilla Extendida: CU-03 · Asignar Ambulancia Automática (Incluye CU-02)

| Campo | Especificación Formal del Caso de Uso (Anexo A) |
| :--- | :--- |
| **Identificador y Nombre:** | **CU-03 · Asignar ambulancia automáticamente (Incluye CU-02 · Radicar solicitud de emergencia)** |
| **Requisitos que atiende:** | RF-008, RF-009, RF-014, RF-015, RF-018, RF-019, RF-021, RF-022, RF-028 |
| **Actor Primario:** | Coordinador Operativo (Iniciador). |
| **Actores Secundarios:** | Sistema Automático SGA (Ejecutor del algoritmo de despacho) y Tripulación Asistencial (Receptores de orden en campo). |
| **Objetivo del Actor:** | Registrar un incidente de urgencia médica y lograr que el sistema asigne y despache de forma autónoma la unidad de emergencia idónea (TAB o TAM) en un tiempo máximo de 2 segundos. |
| **Precondiciones:** | 1. El coordinador operativo ha iniciado sesión de forma segura y cuenta con rol de despacho activo.<br>2. Existen ambulancias dadas de alta en el inventario institucional con personal asistencial vinculado. |
| **Disparador:** | El coordinador recibe una llamada de emergencia ciudadana y presiona la opción *"Nueva Solicitud de Emergencia"*. |
| **Flujo Principal (Paso a Paso):** | 1. El coordinador ingresa los datos de ubicación del evento, contacto del reportante y describe la sintomatología del paciente.<br>2. El coordinador asigna la prioridad clínica inicial según la escala de triage prehospitalario: Rojo (emergencia vital), Naranja (urgencia alta), Amarillo (urgencia moderada) o Verde (baja complejidad).<br>3. El coordinador confirma el registro de la solicitud.<br>4. El sistema almacena la solicitud en estado recibido e invoca inmediatamente el motor de despacho asistencial.<br>5. El sistema evalúa el parque automotor disponible y filtra las unidades operativas según la complejidad clínica requerida: solicitudes críticas (Rojo y Naranja) demandan ambulancias de Transporte Asistencial Medicalizado (TAM); solicitudes básicas (Amarillo y Verde) demandan unidades de Transporte Asistencial Básico (TAB).<br>6. El sistema identifica la ambulancia del tipo requerido que se encuentra más cercana al punto del incidente y cuya tripulación se encuentra en turno activo.<br>7. El sistema vincula la ambulancia seleccionada al servicio, actualiza el estado de la unidad a ocupada y notifica a la tripulación asignada en sus dispositivos en campo.<br>8. El sistema actualiza el tablero de control de flota en tiempo real y presenta al coordinador la confirmación de la unidad despachada junto con el tiempo estimado de arribo. |
| **Flujos Alternos:** | **6a. Sugerencia de Despacho Interinstitucional por Alta Ocupación:**<br>1. Si el sistema detecta que todas las unidades del tipo requerido se encuentran ocupadas en otros servicios activos, evalúa si es viable despachar temporalmente una unidad de mayor complejidad disponible (ej. despachar una unidad TAM para un caso básico).<br>2. Si no existen unidades propias de ningún tipo, el sistema genera una alerta prioritaria sugiriendo al coordinador transferir el caso a la red pública hospitalaria o solicitar apoyo al Centro Regulador de Urgencias.<br>3. El coordinador acepta la sugerencia y el sistema registra la solicitud en espera de apoyo externo, manteniendo la trazabilidad del incidente. |
| **Excepciones:** | **5a. Bloqueo por Vencimiento de Habilitación Sanitaria o Tecnomecánica:**<br>1. Si la ambulancia físicamente más cercana presenta vencimiento en su revisión técnico-mecánica, seguro obligatorio o habilitación ante el registro especial de prestadores de salud, el sistema bloquea inmediatamente su selección para el despacho.<br>2. El sistema descarta la unidad inhabilitada, selecciona la siguiente unidad en regla y emite una alerta administrativa sobre la documentación expirada.<br><br>**5b. Bloqueo por Inhabilitación de Personal Médico:**<br>1. Si el personal asignado a la unidad presenta certificaciones de soporte vital vencidas o supera el límite máximo de horas de turno continuo permitido, el sistema impide el despacho de la tripulación.<br>2. El sistema solicita al coordinador la reasignación de personal disponible antes de autorizar la salida de la ambulancia. |
| **Postcondiciones:** | La solicitud de emergencia queda en estado asignada; la ambulancia seleccionada cambia su estado a en servicio; la tripulación recibe los datos de georreferenciación y se genera el primer hito en el historial cronológico del servicio. |
| **Reglas de Negocio:** | RN-001 (Disponibilidad de ambulancia), RN-002 (Idoneidad de tipo TAB/TAM vs triage), RN-003 (Documentación sanitaria vigente), RN-004 (Habilitación de personal médico). |
| **Pantalla del Prototipo:** | `[Mockup P-01: Tablero de Triage y Despacho Automatizado]` |

---

## 2. Plantilla Extendida: CU-04 · Asignar Ambulancia con Justificación Manual

| Campo | Especificación Formal del Caso de Uso (Anexo A) |
| :--- | :--- |
| **Identificador y Nombre:** | **CU-04 · Asignar ambulancia con justificación manual (Extiende a CU-03)** |
| **Requisitos que atiende:** | RF-009, RF-022, RF-023, RF-055, RF-056, RF-057 |
| **Actor Primario:** | Coordinador Operativo (Iniciador y Tomador de Decisión). |
| **Actores Secundarios:** | Sistema Automático SGA (Validador y Registrador de Auditoría). |
| **Objetivo del Actor:** | Anular de forma consciente y justificada la asignación automática propuesta por el algoritmo del sistema, seleccionando una unidad asistencial específica según su criterio operativo. |
| **Precondiciones:** | 1. El caso de uso base CU-03 ha generado una propuesta automática de despacho para una solicitud activa.<br>2. El coordinador cuenta con perfil autorizado para realizar anulaciones manuales de despacho. |
| **Disparador:** | El coordinador presiona la opción *"Modificar Asignación / Despacho Manual"* en el panel de confirmación. |
| **Flujo Principal (Paso a Paso):** | 1. El coordinador visualiza la ambulancia sugerida por el sistema y selecciona la opción de modificación manual.<br>2. El sistema despliega el catálogo de todas las ambulancias operativas disponibles en la zona.<br>3. El coordinador selecciona manualmente la unidad que considera más conveniente.<br>4. El sistema presenta un formulario modal exigiendo la justificación técnica u operativa del cambio.<br>5. El coordinador selecciona el motivo del desvío (ej. congestión vial imprevista en la ruta sugerida, conocimiento previo del terreno o indicación médica especial) y redacta una observación complementaria.<br>6. El coordinador confirma la reasignación.<br>7. El sistema valida que el campo de justificación no esté vacío y que la unidad elegida cumpla con los requisitos mínimos de habilitación sanitaria.<br>8. El sistema reasigna el servicio a la nueva ambulancia, actualiza los tableros de control y registra de forma inmutable el evento en la bitácora de auditoría vinculando la identidad del coordinador y el motivo manifestado. |
| **Flujos Alternos:** | No aplica (el flujo principal contempla la resolución exitosa con criterio humano). |
| **Excepciones:** | **7a. Rechazo por Ausencia de Justificación:**<br>1. Si el coordinador intenta confirmar el despacho manual sin ingresar una justificación escrita válida, el sistema bloquea la acción.<br>2. El sistema resalta el campo de justificación en rojo y muestra el mensaje: *"Norma de Auditoría: Se requiere registrar el motivo del cambio manual para continuar"*.<br><br>**7b. Intento de Asignación de Unidad No Conforme:**<br>1. Si la unidad seleccionada manualmente no corresponde a la complejidad clínica requerida (ej. asignar una ambulancia básica a un paciente en paro cardiorrespiratorio que exige unidad medicalizada), el sistema emite una advertencia de riesgo clínico.<br>2. El sistema exige una doble confirmación con firma digital del coordinador si este insiste en la decisión por fuerza mayor. |
| **Postcondiciones:** | El servicio queda asignado a la ambulancia seleccionada manualmente; la decisión y su justificación quedan selladas de forma inalterable en la bitácora de auditoría para futuras revisiones del Centro Regulador. |
| **Reglas de Negocio:** | RN-007 (Obligatoriedad de justificación en asignación manual), RN-010 (Inmutabilidad de auditoría). |
| **Pantalla del Prototipo:** | `[Mockup P-02: Ventana Modal de Justificación de Despacho Manual]` |

---

## 3. Plantilla Extendida: CU-05 · Realizar Cierre Formal de Servicio

| Campo | Especificación Formal del Caso de Uso (Anexo A) |
| :--- | :--- |
| **Identificador y Nombre:** | **CU-05 · Realizar cierre formal de servicio (Incluye CU-11 · Facturación y CU-06 · Auditoría)** |
| **Requisitos que atiende:** | RF-018, RF-019, RF-024, RF-025, RF-031, RF-055, RF-056 |
| **Actor Primario:** | Paramédico / Líder de Tripulación Asistencial (Iniciador). |
| **Actores Secundarios:** | Coordinador Operativo (Supervisor) y Sistema Automático SGA (Liquidador financiero y auditor). |
| **Objetivo del Actor:** | Registrar los datos clínicos finales de la atención, hospital receptor y liberar la unidad de emergencia para retornar al estado de disponibilidad operativa. |
| **Precondiciones:** | El servicio se encuentra en estado de traslado o atención en sitio concluida. |
| **Disparador:** | El paramédico presiona el botón *"Finalizar y Cerrar Atención"* en la aplicación web desde la tableta. |
| **Flujo Principal (Paso a Paso):** | 1. El paramédico accede al servicio activo bajo su responsabilidad.<br>2. El paramédico selecciona la opción de cierre de atención asistencial.<br>3. El sistema despliega el formulario de liquidación operativa y clínica exigido por la Resolución 3100 de 2019.<br>4. El paramédico registra el resultado de la atención (traslado efectivo a institución de salud, atención y resolución en el sitio del evento o desistimiento voluntario firmado).<br>5. El paramédico registra el estado clínico de entrega del paciente (estable, crítico o fallecido) y el nombre de la institución hospitalaria que recibe el caso.<br>6. El paramédico registra el nombre y registro profesional del médico o enfermero que recibe al paciente en el área de urgencias.<br>7. El paramédico revisa el resumen de los datos y confirma el envío del reporte de cierre.<br>8. El sistema valida la consistencia y completitud obligatoria de todos los campos asistenciales.<br>9. El sistema transiciona el estado del servicio a finalizado y actualiza el estado de la ambulancia y su tripulación a disponible en el panel de monitoreo.<br>10. El sistema genera de forma automática la factura interna inmutable con las tarifas parametrizadas según el tipo de servicio prestado (TAB o TAM).<br>11. El sistema registra el evento de cierre en la bitácora inalterable de auditoría con sello de tiempo y emite el comprobante digital de liquidación. |
| **Flujos Alternos:** | **4a. Atención Culminada en Sitio sin Traslado:**<br>1. Si el paciente fue estabilizado en el lugar y no requirió traslado a un hospital, el paramédico marca la opción *"Atención en Sitio / Alta Médica Prehospitalaria"*.<br>2. El sistema inhabilita los campos de hospital receptor y médico de entrega, pero exige adjuntar el consentimiento informado firmado por el paciente o familiar.<br>3. El paramédico envía el reporte y el servicio se cierra exitosamente sin destino de traslado. |
| **Excepciones:** | **8a. Bloqueo por Omisión de Variables Clínicas Obligatorias:**<br>1. Si el paramédico intenta cerrar el servicio omitiendo el estado final del paciente o el centro de salud de recepción en un caso de traslado, el sistema bloquea el botón de finalización.<br>2. El sistema resalta los campos faltantes e informa: *"Requisito REPS: Debe diligenciar el estado clínico del paciente y la institución receptora para proceder al cierre"*.<br><br>**8b. Discrepancia en Tiempos Operativos:**<br>1. Si la hora de cierre registrada es anterior a la hora de asignación o arribo al sitio, el sistema rechaza la transacción por inconsistencia cronológica.<br>2. El sistema solicita la corrección de los sellos de tiempo antes de validar el registro. |
| **Postcondiciones:** | El servicio queda sellado en estado finalizado y bloqueado contra modificaciones directas; la ambulancia retorna al estado disponible para nuevas emergencias; se expide la factura electrónica interna y se archiva el registro asistencial. |
| **Reglas de Negocio:** | RN-005 (Campos obligatorios de cierre clínico), RN-006 (Prohibición de cancelación en etapas avanzadas), RN-010 (Auditoría inmutable), RN-014 (Inmutabilidad de la factura emitida). |
| **Pantalla del Prototipo:** | `[Mockup P-03: Formulario de Cierre Clínico y Liquidación Asistencial]` |
