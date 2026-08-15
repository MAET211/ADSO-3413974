# AuditoriaSistemaGestionSena

Revisión UX/UI — SENA Gestión de Horarios (v3, con evidencias y template documentado)

**Sitio auditado:** https://code-sena.github.io/design-software-mockup/
**Rol principal evaluado:** Aprendiz (con revisión comparativa de los 6 roles del sistema)
**Fecha:** 08 de agosto de 2026
**Repositorio fuente:** code-sena/design-software-mockup

## Objetivo

Documentar, con criterio de instructor ADSO, la revisión UX/UI del mockup "SENA — Gestión de Horarios" y complementarla con la extracción formal del template visual utilizado en la presentación de resultados (`SENA_Sistema_Audit-mejoras.pptx`), de modo que el informe quede estructurado, trazable y listo para ser entregado al vocero de ficha.

Nota de revisión de contexto: se verificó que el Markdown original y la presentación `.pptx` pertenecen al mismo proyecto (auditoría UX/UI del mockup de gestión de horarios SENA, Ficha 3413974-adyacente). No se encontraron términos ajenos al dominio de UX/UI/software (por ejemplo, terminología clínica o médica) que rompieran el contexto del proyecto; por lo tanto, el contenido técnico original se conserva sin alteraciones de significado.

## MetodologiaDeRevision

Para hacer la revisión me apoyé en el mockup, en las capturas de pantalla tomadas durante las pruebas y en la estructura del proyecto disponible. También se contrastaron los comportamientos comprobables en el código con los datos que aparecen en las pantallas. La idea fue no quedarse solo con "se ve bien o se ve mal", sino revisar qué pasa al intentar usar las funciones.

Limitación declarada desde el inicio: las pantallas 46 a 53 (el nuevo "Hub de parametrización") no tenían captura al momento del análisis de código — el propio README del proyecto lo indica ("quedan pendientes de captura"). Para esas 8 pantallas la revisión inicial fue solo de código, marcada como **NO VERIFICABLE VISUALMENTE**. Esta brecha se cerró posteriormente con 28 capturas aportadas por el aprendiz (ver sección `EvidenciasDeCapturas`).

Cada hallazgo se relaciona con una captura, una observación directa o una parte concreta del código. Donde algo no se puede comprobar por tratarse de un prototipo estático sin backend, se marca explícitamente como **NO VERIFICABLE EN EL MOCKUP**.

**Qué se revisó:**
- 53 pantallas y modales del inventario oficial (`shell/routes.js`, arreglo `M.inventory`), agrupadas en 7 bloques: Auth y shell, Coordinador, Instructor, Aprendiz, Administrador, Back-office, Parametrización.
- 6 roles: público (no autenticado), Coordinador Académico, Instructor, Aprendiz, Director de Centro, Administrador de Soporte.
- Componentes compartidos: tabla, paginación, filtros, modal, tabs, estados (carga/vacío/error), KPI, calendario semanal.
- 90 capturas de referencia (45 desktop 1440×1000 + 45 móvil 390×844) publicadas por el propio proyecto.

**Fuera de alcance / no verificable:** cualquier comportamiento que dependa de un backend real (persistencia, autenticación real, generación de documentos, exportaciones). El propio README del proyecto declara que "las acciones no persisten datos fuera de localStorage" y que "no existe autenticación real, integración API, generación de archivos ni descarga firmada". Esto no se cuenta como error del mockup, salvo cuando el propio mockup aparenta ofrecer esa función sin advertirlo (ver F-006, F-019, F-025).

## ResumenEjecutivo

En general, el mockup tiene una apariencia bastante organizada: los colores, las tarjetas y la tipografía mantienen una línea coherente entre las pantallas. Sin embargo, al probar las funciones aparecieron varios problemas que sí afectan el uso real. En total se documentaron **35 hallazgos**, varios de ellos repetidos porque provienen de componentes compartidos entre muchas pantallas.

Hallazgos más relevantes:

- **Paginación no funcional en ningún lugar del sistema.** Los botones "Anterior/Siguiente/1/2/3" no tienen manejador de clic. En listados como "Fichas" (56 registros, se muestran 5) o "Documentos" (42 registros, se muestran 4), el aprendiz nunca puede ver el resto de los datos.
- **Filtros que no filtran nada.** Ningún formulario de filtros del sistema tiene botón "Aplicar" ni lógica de envío; solo existe "Limpiar filtros".
- **14 botones de eliminar/cancelar/revocar "muertos"** (sin manejador alguno), repartidos en 6 pantallas distintas, sin confirmación ni retroalimentación de ningún tipo.
- **Inconsistencias de datos graves:** el detalle de cualquier usuario siempre muestra "Juan Pérez" en el cuerpo, sin importar a quién se abrió.
- **Bug de navegación por rol:** el enlace "Ver todas" de notificaciones cambia el rol activo a Aprendiz sin avisar, sin importar quién esté usando el sistema.

**Distribución de severidad:** 10 críticos · 12 altos · 9 medios · 3 bajos + 1 clasificado como mejora / no verificable.
**Origen de los hallazgos:** 26 del análisis de código original (F-001 a F-026) + 9 identificados exclusivamente a partir de las 28 capturas de pantalla aportadas por el aprendiz (F-027 a F-035).

## TemplateUtilizado

Esta sección documenta la plantilla visual extraída directamente de `SENA_Sistema_Audit-mejoras.pptx`. No se propone un diseño nuevo: se describe únicamente lo que ya existe en el mockup de presentación.

**Nombre del template:** Sistema dual "Analytics Dark / Editorial Light" — dos variantes de una misma identidad visual, alternadas según el propósito de cada diapositiva (narrativa/explicativa vs. datos/decisión).

**Paleta de colores:**

| Token | Valor | Uso |
| --- | --- | --- |
| Fondo oscuro primario | `#0B1524` | Fondo de diapositivas de datos y cierre |
| Fondo oscuro de tarjeta | `#121F33` | Superficie de tarjetas sobre fondo oscuro |
| Fondo claro | Blanco / gris muy claro | Fondo de diapositivas narrativas y de diagramas |
| Crimson (severidad crítica) | `#C0243B` | Etiquetas "CRÍTICO", acentos de alerta |
| Naranja (severidad alta) | `#D9822B` | Etiquetas "ALTO", acentos secundarios |
| Texto principal | `#FFFFFF` | Títulos y texto sobre fondo oscuro |
| Texto secundario | `#AEBBCB` | Subtítulos y texto de apoyo sobre fondo oscuro |
| Texto sobre fondo claro | Gris oscuro / negro | Títulos y cuerpo en diapositivas narrativas |

**Tipografía:** familia sans serif geométrica en negrita para títulos (peso alto, tracking ajustado) y sans serif regular para cuerpo de texto y descripciones. Contraste tipográfico consistente entre título (grande, bold) y texto de apoyo (pequeño, regular) en todas las diapositivas.

**Fondo:** alterna entre dos modos según el rol de la diapositiva —
- *Modo dato/decisión:* fondo azul marino sólido (`#0B1524`), usado en diapositivas de cifras, hallazgos priorizados y conclusiones.
- *Modo narrativo/diagrama:* fondo blanco o gris muy claro, usado en diapositivas de portada, resumen de hallazgos, ecosistema de roles y recorrido del aprendiz.

**Estilo de tarjetas:** rectángulos redondeados con etiqueta de severidad de color sólido (crimson o naranja) en la esquina superior, seguida de encabezado en negrita y texto descriptivo en dos bloques ("Problema" / "Solución" o similar). Fondo de tarjeta ligeramente más claro que el fondo general para crear jerarquía sin usar bordes decorativos.

**Iconografía:** iconos de línea simple, en su mayoría contenidos dentro de un círculo gris de contorno fino, usados únicamente en las diapositivas de fondo claro (roles, ecosistema, checklist de fortalezas). Las diapositivas de fondo oscuro prescinden de iconografía decorativa y priorizan tipografía y color.

**Jerarquía visual:** un número grande (35, 10, 12, 9, 3…) actúa como protagonista visual en las diapositivas de cifras, acompañado de una etiqueta descriptiva pequeña debajo. En las diapositivas de listado, el orden de lectura es: etiqueta de severidad → título del hallazgo → bloque "Problema" → bloque "Solución".

**Reglas de consistencia visual:**
1. El par crimson/naranja se reserva exclusivamente para indicar severidad (crítico/alto) y no se usa como color decorativo en ningún otro contexto.
2. Toda diapositiva de fondo oscuro usa el mismo tono de azul marino y el mismo texto secundario gris-azulado; no hay variaciones de tono entre diapositivas del mismo modo.
3. Las diapositivas de fondo claro comparten el mismo estilo de icono circular y la misma paleta de grises para texto secundario.
4. Los títulos siempre van en la esquina superior izquierda, en negrita, con el mismo tamaño relativo entre diapositivas del mismo modo.

## AplicacionDelTemplate

Verificación diapositiva por diapositiva de cómo se mantiene la identidad visual descrita en `TemplateUtilizado`:

- **Diapositiva 1 (Portada):** modo claro. Título en negrita grande, subtítulo en gris regular, metadatos de pie de página en texto pequeño. Establece la tipografía base del resto del documento.
- **Diapositiva 2 (nueva — Template Visual del Mockup):** modo oscuro, creada en esta actividad para documentar explícitamente la plantilla. Reutiliza el mismo fondo `#0B1524`, las mismas tarjetas redondeadas y el mismo par crimson/naranja de etiquetas que las diapositivas 8, 9 y 10, sin introducir ningún elemento visual nuevo.
- **Diapositiva 3 (Signos Vitales del Prototipo):** modo claro. Introduce la jerarquía "número grande + etiqueta pequeña" (35 hallazgos) y las primeras etiquetas de color por severidad, anticipando el código cromático que se usará en el resto del documento.
- **Diapositiva 4 (El Ecosistema Analizado):** modo claro. Usa el estilo de iconografía circular de línea simple para representar los 6 roles, consistente con la ausencia de iconos decorativos en las diapositivas oscuras.
- **Diapositiva 5 (Una Base Sólida):** modo claro. Tarjetas con check verde para fortalezas — mantiene el mismo estilo de tarjeta redondeada que las diapositivas de hallazgos, cambiando solo el color de acento (verde de confirmación en vez de crimson/naranja) porque comunica información positiva, no severidad.
- **Diapositiva 6 (El Recorrido como Aprendiz):** modo oscuro narrativo. Línea de tiempo horizontal con los mismos tonos de texto principal/secundario del modo oscuro.
- **Diapositiva 7 (Las Cascaritas del Sistema):** modo oscuro. Introduce globos de diálogo, manteniendo tipografía y paleta ya establecidas.
- **Diapositiva 8 (35 — resumen numérico):** modo oscuro puro, transición hacia el bloque de hallazgos priorizados; reafirma la jerarquía de número grande.
- **Diapositivas 9, 10 y 11 (Top 10 por foco: Navegación y Estructura / Operación y Datos / Funcionalidad Específica):** modo oscuro. Aplican de forma estricta el estilo de tarjeta con etiqueta CRÍTICO/ALTO, bloques "Problema" y "Solución", sin desviaciones entre las tres diapositivas.
- **Diapositiva 12 (Conclusiones y Próximos Pasos):** modo oscuro. Cierra el documento con tres columnas de igual estilo de tarjeta, consistente con el resto del bloque de datos.

**Conclusión de la verificación:** el mockup aplica su template de forma consistente en las 12 diapositivas (11 originales + 1 añadida en esta actividad). No se detectaron mezclas de paleta, tipografía ni estilo de tarjeta fuera de lo documentado en `TemplateUtilizado`.

## HallazgosEncontrados

### TablaMaestraDeHallazgos

| ID | Pantalla(s) | Rol(es) | Categoría | Problema | Severidad |
| --- | --- | --- | --- | --- | --- |
| F-001 | Todas las tablas paginadas (≈20 pantallas) | Todos | Funcional/Navegación | Botones "Anterior/1/2/3/Siguiente" y selector "por página" sin manejador de clic | CRÍTICO |
| F-002 | Todas las pantallas con filtros (≈15) | Todos | UX/Formularios | Formulario de filtros sin botón "Aplicar" ni envío programado | CRÍTICO |
| F-003 | Mi disponibilidad, Horarios, Franjas, Ambientes, Reglas, Categorías/Estados de actor, Detalle de usuario | Instructor, Coordinador, Director/Soporte | Formularios/UX | 14 botones "Eliminar/Cancelar sesión/Revocar" sin manejador ni confirmación | CRÍTICO |
| F-004 | Cualquier pantalla en estado de error | Todos | UX | Botón "Reintentar" sin listener; en error 500 el botón navega a Inicio, no reintenta | ALTO |
| F-005 | Cualquier pantalla en estado vacío | Todos | UX | Botón "Limpiar filtros" del estado vacío sin manejador | ALTO |
| F-006 | Login | Público | Formularios/Lógica | El formulario no valida credenciales; cualquier texto no reconocido inicia sesión como Coordinador por defecto | CRÍTICO |
| F-007 | Menú de usuario → Cerrar sesión | Todos | Lógica/Seguridad | "Cerrar sesión" navega a /login pero nunca limpia localStorage; el rol persiste | ALTO |
| F-008 | Todo el sistema para rol Director | Director | Lógica/Roles | Solo lectura calculada de forma global, sin relación al permiso real (contradice matriz RBAC) | ALTO |
| F-009 | Menú de usuario, /inventory | Todos | UI/Datos | Texto hardcodeado "Índice de 45 pantallas"; el inventario real tiene 53 | MEDIO |
| F-010 | Header (todas las pantallas autenticadas) | Todos | UI/Datos | Insignia de notificaciones fija en "3", no depende de datos reales | BAJO |
| F-011 | Panel de notificaciones (overlay) | Todos | Funcional/Roles | "Ver todas" fuerza el rol activo a Aprendiz sin aviso, sin importar el rol de origen | CRÍTICO |
| F-012 | Todos los modales (≈25 instancias) | Todos | Accesibilidad | Sin gestión de foco al abrir/cerrar modales | ALTO |
| F-013 | Prácticamente todos los formularios | Todos | Formularios | Solo 14 usos de `required`; sin indicador visual sistemático de obligatoriedad | MEDIO |
| F-014 | Nuevo usuario, Asignar rol, Registrar seguimiento, Agregar sesión | Coordinador, Director, Instructor | Formularios/UX | Mensajes de error mostrados de forma permanente sin interacción del usuario | ALTO |
| F-015 | Login (desktop), Horarios (móvil) | Público, Coordinador | UI/Accesibilidad | Iconos SVG (ojo, búsqueda) se renderizan como manchas negras sólidas | MEDIO |
| F-016 | Horarios — lista (móvil) | Coordinador | UI/Responsive | Caja blanca vacía flotando sobre el botón "Limpiar filtros" | BAJO |
| F-017 | Modal agregar/editar sesión (móvil) | Coordinador | Responsive | Modal no se adapta a una columna; campos quedan cortados fuera del viewport | CRÍTICO |
| F-018 | Detalle de usuario, Modal Asignar rol | Director, Soporte | Datos/Lógica | El cuerpo siempre muestra "Juan Pérez"/"Instructor", sin importar qué usuario se abrió | CRÍTICO |
| F-019 | Plantillas de documento | Soporte | Navegación/Lógica | "+ Nueva plantilla" enlaza a la edición de una plantilla existente, no a un formulario en blanco | ALTO |
| F-020 | Auditoría — lista | Soporte | Datos | Columnas "Recibido" y "Ocurrido en origen" usan la misma clave de datos | MEDIO |
| F-021 | Mi horario (Instructor) | Instructor | Navegación | "Semana anterior"/"Semana siguiente" sin manejador | ALTO |
| F-022 | Menú del Director | Director | Navegación/Roles | Director tiene permiso de ruta pero el menú lateral no enlaza esas pantallas | MEDIO |
| F-023 | Parametrización (Back-office antiguo vs. Hub nuevo) | Soporte, Director | Arquitectura/Navegación | Coexisten dos sistemas de parametrización; el menú solo enlaza al nuevo | MEDIO |
| F-024 | Parametrización — Jornadas | Director/Soporte | Datos | Valor de jornada nocturna mal escrito como 'NIGTH' | BAJO |
| F-025 | Nueva contraseña | Público | Formularios | Sin validación real de coincidencia entre contraseñas | NO VERIFICABLE / MEJORA |
| F-026 | Recuperar contraseña | Público | Formularios | Sin validación de formato de correo ni de campo vacío | MEDIO |
| F-027 | Modal "Agregar sesión" sobre "Nuevo horario" | Coordinador | Datos/Consistencia | "Nuevo horario" abre precargado con datos de un horario ya existente, en vez de un formulario vacío | ALTO |
| F-028 | Modal "Agregar sesión", "Nueva/editar franja", "Generar documento" | Coordinador, Director, Soporte | Formularios/Funcional | Mensajes de validación se muestran siempre, incluso con datos válidos | CRÍTICO |
| F-029 | Modal "Nuevo usuario" | Director | Datos | El formulario abre con nombre y apellido ya escritos y un error ya visible | ALTO |
| F-030 | Parametrización — Currículo académico, modal competencia | Director | UI/Accesibilidad | Checkboxes sin separación visual entre opciones; modal con scroll horizontal | ALTO |
| F-031 | ≥6 pantallas del Hub de Parametrización + Mi disponibilidad + Notificaciones | Todos | Datos/Funcional | El indicador "Mostrando X–Y de Z" no coincide con los datos reales ni con el tamaño de página seleccionado | CRÍTICO |
| F-032 | Parametrización — RBAC, listado de roles | Director | Datos/Funcional | El rol AREA_LEADER tiene 0 permisos asignados, a diferencia de los demás | MEDIO |
| F-033 | Parametrización — RBAC, modal "Rol y sus permisos — COORDINATOR" | Director | Datos/Seguridad aparente | Permiso de gestión de roles marcado para un rol cuyo alcance declarado es menor | MEDIO |
| F-034 | Hub de Parametrización (portada) | Director | Navegación/Funcional | La tarjeta "Catálogos y parámetros" es la única de 8 que no abre su pantalla | CRÍTICO |
| F-035 | Administración — Documentos | Soporte | Funcional/UX | Documento en estado de error muestra botón "Reintentar" sin manejador (por F-004) | ALTO |

### PatronesRepetidos

| Patrón | Apariciones | Pantallas |
| --- | --- | --- |
| Botón de acción sin manejador (eliminar, cancelar, revocar, reintentar, descargar, copiar) | ≥18 | Mi disponibilidad, Horarios, Franjas, Tipos de ambiente/inventario, Reglas, Categorías/Estados de actor, Documentos, Auditoría, Detalle de usuario |
| Paginación decorativa | Todas las tablas con `pagination()` | ~20 pantallas de listado |
| Filtros sin botón de aplicar | Todas las pantallas con `filters()` | ~15 pantallas |
| Mensaje de error/validación mostrado de forma permanente | 5 | Nuevo usuario, Asignar rol, Registrar seguimiento, RBAC, Agregar sesión |
| Texto o dato hardcodeado que ignora el registro seleccionado | 3 focos | Detalle de usuario, "45 pantallas", insignia de notificaciones fija en "3" |

## PriorizacionDeHallazgosCriticos

De los 35 hallazgos documentados, estos 10 representan bloqueos funcionales severos que deben corregirse antes de cualquier paso a producción:

| # | Problema | Pantalla(s) | Impacto | Severidad | Solución recomendada |
| --- | --- | --- | --- | --- | --- |
| 1 | Filtros no aplican ningún criterio | ~15 pantallas | El usuario cree que puede acotar resultados y no puede | CRÍTICO | Agregar botón "Aplicar filtros" con manejador que reconstruya la tabla |
| 2 | Paginación decorativa | ~20 pantallas | Datos más allá de la página 1 son inalcanzables | CRÍTICO | Cablear `data-page` en los botones y re-renderizar con la nueva página |
| 3 | "Ver todas" de notificaciones cambia el rol activo sin avisar | Panel de notificaciones | Cambia el contexto de sesión como efecto secundario oculto | CRÍTICO | Enlazar sin forzar el cambio de rol, o mostrar aviso explícito |
| 4 | 14+ botones de eliminar/cancelar/revocar sin función | 6 pantallas | Simula operaciones CRUD que no existen; sin confirmación | CRÍTICO | Modal de confirmación explícita antes de ejecutar |
| 5 | Modal "Agregar sesión" roto en móvil | Modal de sesión (móvil) | Contenido fuera de pantalla, formulario inutilizable | CRÍTICO | Forzar una sola columna en formularios de dos columnas en móvil |
| 6 | Detalle de usuario muestra datos de otro usuario | Detalle de usuario, modal Asignar rol | Riesgo real de confusión al asignar/revocar un rol | CRÍTICO | Reemplazar literales por los campos reales del registro |
| 7 | Login no valida credenciales | Login | El estado de error nunca se activa por uso real | CRÍTICO | Validación mínima antes de redirigir |
| 8 | Director forzado a solo lectura de forma global | Todo el sistema para Director | Contradice la matriz RBAC propia del sistema | ALTO | Verificación de permisos reales por pantalla |
| 9 | No se puede cambiar de semana en "Mi horario" | Mi horario — Instructor | Bloquea la consulta de horarios pasados/futuros | ALTO | Cablear los botones a la actualización de la consulta por semana |
| 10 | "+ Nueva plantilla" abre una plantilla existente | Plantillas de documento | Alta probabilidad de sobrescribir una plantilla real sin darse cuenta | ALTO | Ruta de creación con formulario en blanco real |

## PropuestasDeMejora

Con base en los hallazgos anteriores, el orden de corrección recomendado es:

1. **Cablear primero los componentes compartidos** (`pagination()`, `filters()`, `state()` con `data-retry`), porque cada corrección ahí se propaga automáticamente a docenas de pantallas — es la relación costo/beneficio más alta de todo el informe.
2. **Auditar cada botón "peligroso"** (eliminar/revocar/desactivar) y exigir un modal de confirmación estándar antes de ejecutarlo, reutilizando el patrón de modal ya existente.
3. **Revisar cada pantalla de "detalle"** para asegurar que todo el contenido derive del registro real seleccionado, no solo el encabezado.
4. **Añadir gestión de foco centralizada** a los modales, para resolver F-012 en sus ~25 instancias de una sola vez.
5. **Reemplazar el copy hardcodeado** ("45 pantallas", "3 pendientes") por valores calculados desde los datos reales del inventario y las notificaciones.
6. **Definir la navegación del Director:** si tiene permiso de ruta sobre Horarios/Fichas/Disponibilidad, debe tener también su entrada de menú, o retirarle el permiso si es intencional que no la tenga.
7. **Decidir el futuro del sistema antiguo de parametrización:** retirarlo del inventario o enlazarlo desde la navegación de Soporte.
8. **Publicar las capturas faltantes** para cerrar cualquier brecha de verificación visual pendiente.

## EvidenciasDeCapturas

Estas evidencias provienen de 28 capturas tomadas durante la revisión práctica del sistema, varias marcadas con círculos o flechas sobre el problema detectado. Esta sección cerró la brecha de verificación visual señalada en `MetodologiaDeRevision`, cubriendo entre otras varias pantallas del Hub de Parametrización (#46–53) antes marcadas NO VERIFICABLE VISUALMENTE.

Convención usada: **OBSERVADO** = visible directamente en la captura · **INFERENCIA** = deducción razonable · **NO VERIFICABLE EN EL MOCKUP** = no comprobable por ser un prototipo estático.

Confirmaciones directas de hallazgos ya documentados:

- **F-001** (paginación no funciona): confirmado en Horarios, Mi disponibilidad, Notificaciones y 6+ pantallas del Hub de Parametrización.
- **F-002** (filtros no filtran): con el filtro "Estado = Etapa productiva" aplicado, la primera fila visible tiene estado "Ejecución".
- **F-003** (eliminar/cancelar sin función): confirmado en Horarios.
- **F-014** (validaciones permanentes en formularios vacíos): confirmado en "Nuevo usuario" y "Registrar seguimiento".
- **F-020** (columnas "Recibido"/"Ocurrido en origen" duplicadas): mismo valor en ambas columnas.

Distribución del origen de los 35 hallazgos:

| Rango | Origen | Cantidad |
| --- | --- | --- |
| F-001 a F-026 | Análisis de código (v1) | 26 |
| F-027 a F-035 | Evidencia visual — 28 capturas del aprendiz (v3) | 9 |
| **Total acumulado** | | **35** |

## Conclusiones

**¿El sistema es fácil de usar?** En la parte del Aprendiz sí resulta sencillo, porque las opciones son pocas y se entienden rápido. El problema aparece en los roles que administran información, donde hay botones, filtros y páginas que parecen funcionar pero no responden.

**¿Qué está mejor logrado?** La parte visual. Los colores de estados, la tipografía, las tarjetas y la adaptación de varias tablas a móvil están bien pensadas — y esa misma solidez visual es la que se documentó formalmente en `TemplateUtilizado`.

**¿Qué cambiaría primero?** Los problemas que se repiten en muchas pantallas: paginación, filtros y manejo de modales. Corregir el componente compartido arregla varias pantallas de una vez.

**¿Qué debería corregirse antes de producción?** Primero los problemas críticos, sobre todo los que pueden afectar datos, permisos o el cambio de sesión. Después, los componentes repetidos, para que el arreglo se refleje en varias pantallas simultáneamente.

**Veredicto general:** la base estética y técnica del mockup es sólida — la plantilla visual está bien definida y se aplica de forma consistente en todas las pantallas —, pero el prototipo requiere una fase de estabilización funcional urgente en tablas, filtros y modales antes de avanzar a producción.
