# Revisión UX/UI — SENA Gestión de Horarios

Revisión UX/UI — SENA Gestión de Horarios (v3, con evidencias)

Revisión del mockup “SENA — Gestión de Horarios”

Sitio auditado: https://code-sena.github.io/design-software-mockup/ Rol principal: Aprendiz. También revisé los demás roles para comparar cómo cambia el sistema. Fecha: 08 de agosto de 2026 Repositorio fuente: code-sena/design-software-mockup

0. Cómo hice la revisión

Para hacer la revisión me apoyé en el mockup, en las capturas de pantalla que tomé durante las pruebas y en la estructura del proyecto disponible. También contrasté los comportamientos que se pueden comprobar en el código y los datos que aparecen en las pantallas. La idea fue no quedarme solo con “se ve bien o se ve mal”, sino revisar qué pasa cuando intento usar las funciones.

Hay una limitación que dejo clara desde el principio: las pantallas 46 a 53 (el nuevo “Hub de parametrización”) no tienen captura todavía — el propio README del proyecto lo dice explícitamente (“quedan pendientes de captura”). Para esas 8 pantallas mi revisión es solo de código, no visual. Lo marco como NO VERIFICABLE VISUALMENTE en cada caso.

Cada falla que dejo en este documento la relaciono con una captura, con algo que pude observar o con una parte concreta del proyecto. No estoy contando problemas por inventar. Donde algo no se puede comprobar (por ser un prototipo estático sin backend), lo digo explícitamente como NO VERIFICABLE EN EL MOCKUP.

## 1. Resumen de lo que encontré

En general, el mockup tiene una apariencia bastante organizada: los colores, las tarjetas y la tipografía mantienen una línea parecida entre las pantallas. Pero cuando empecé a probar las funciones encontré varios problemas que sí afectan el uso. En total quedaron 35 hallazgos, y varios se repiten porque vienen de componentes que se usan en muchas pantallas. Los que más me llamaron la atención fueron:

La paginación no funciona en ningún lugar del sistema. Los botones “Anterior/Siguiente/1/2/3” no tienen ningún manejador de clic. En listados como “Fichas” (56 registros, se muestran 5) o “Documentos” (42 registros, se muestran 4), el aprendiz nunca puede ver el resto.

Los filtros no filtran nada. Ningún formulario de filtros del sistema tiene botón “Aplicar” ni lógica de envío; solo existe “Limpiar filtros”.

14 botones de eliminar/cancelar/revocar están “muertos” (sin manejador alguno), repartidos en 6 pantallas distintas, sin confirmación ni feedback de ningún tipo.

A esto se suman inconsistencias de datos graves (el detalle de cualquier usuario siempre muestra “Juan Pérez” en el cuerpo, sin importar a quién se abrió) y un bug de navegación por rol (el enlace “Ver todas” de notificaciones cambia el rol activo a Aprendiz sin avisar, sin importar quién esté usando el sistema).

Total de hallazgos: 35 (documentados con evidencia de código o captura) — 26 del análisis de código original + 9 nuevos identificados exclusivamente a partir de las 28 capturas de pantalla aportadas por el aprendiz (sección 18 en adelante). Distribución de severidad: 10 críticos · 12 altos · 9 medios · 3 bajos + 1 clasificado como mejora.

En esta versión agrego las 28 capturas que tomé mientras revisaba el sistema. Estas capturas me sirvieron para confirmar varios problemas que ya estaban identificados y también para encontrar 9 fallas nuevas, sobre todo datos que aparecen precargados, mensajes de validación que salen sin hacer nada y problemas con la paginación.

## 2. Qué revisé

53 pantallas y modales del inventario oficial (shell/routes.js, array M.inventory), agrupadas en 7 bloques: Auth y shell, Coordinador, Instructor, Aprendiz, Administrador, Back-office, Parametrización.

6 roles: público (no autenticado), Coordinador Académico, Instructor, Aprendiz, Director de Centro, Administrador de Soporte.

Componentes compartidos: tabla, paginación, filtros, modal, tabs, estados (carga/vacío/error), KPI, calendario semanal.

90 capturas de referencia (45 desktop 1440×1000 + 45 móvil 390×844) publicadas por el propio proyecto.

Fuera de alcance / no verificable: cualquier comportamiento que dependa de un backend real (persistencia, autenticación real, generación de documentos, exportaciones) — el propio README del proyecto declara que “las acciones no persisten datos fuera de localStorage” y que “no existe autenticación real, integración API, generación de archivos ni descarga firmada”. Lo respeto y no lo cuento como error del mockup salvo cuando el propio mockup aparenta ofrecer esa función sin advertirlo (ver F-006, F-019, F-025).

## 3. Roles que revisé

## 4. Cómo hice las pruebas

Revisé la parte principal del sistema: rutas, permisos por rol y acciones de la interfaz.

Revisé las 53 rutas, los permisos de cada rol y las pantallas que aparecen en la navegación.

Revisé los componentes que se repiten en muchas pantallas, especialmente tablas, filtros, paginación, modales y estados.

También revisé los módulos principales del sistema para comparar que lo que se muestra tenga sentido con cada función.

Busqué patrones que normalmente pueden generar problemas: botones sin acción, validaciones, accesibilidad, confirmaciones y manejo de sesión.

Después comparé las capturas de login, formularios, tablas, modales y vista móvil para confirmar si lo que aparecía en el código realmente se veía en pantalla.

También comparé algunos datos de prueba con lo que aparece en pantalla, porque una cosa es que la interfaz se vea bien y otra que muestre el registro correcto.

## 5. Tabla maestra de hallazgos

## 6. Cascaritas que encontré

¿Qué pasa si dejo el correo vacío en Login? → Nada se lo impide; el sistema inicia sesión igual, como Coordinador (F-006).

¿Qué pasa si escribo mal mi contraseña? → No importa, no se valida (F-006).

¿Qué pasa si intento eliminar una sesión, una excepción de disponibilidad o un usuario? → El botón no responde; no hay confirmación ni mensaje (F-003).

¿Qué pasa si cierro sesión y vuelvo a entrar por una URL directa? → El sistema me sigue reconociendo con mi rol anterior porque nunca se limpió (F-007).

¿Qué pasa si estoy como Coordinador y abro el panel de notificaciones y toco “Ver todas”? → Sin avisar, paso a ver el sistema como Aprendiz (F-011).

¿Qué pasa si abro el formulario de “Nuevo usuario” sin tocar nada? → Ya veo un error (“Este correo ya está registrado”) sobre un campo que ni siquiera edité (F-014).

¿Qué pasa si hago clic en la página 2 de cualquier listado? → Nada. No existe forma de ver los registros restantes (F-001).

¿Qué pasa si uso los filtros y hago clic en algún botón para aplicarlos? → No existe ese botón; solo puedo “Limpiar filtros” (F-002).

¿Qué pasa si, como Director, quiero editar un horario? → Todo aparece en modo solo lectura, sin ninguna explicación en pantalla de por qué (F-008).

¿Qué pasa si como Director busco “Horarios” en el menú? → No está. Solo puedo llegar ahí si conozco la URL de memoria o uso el índice maestro (F-022).

¿Qué pasa si pulso “+ Nueva plantilla”? → Termino editando una plantilla que ya existía, con su código bloqueado (F-019).

¿Qué pasa si entro al mockup desde un celular y abro “Agregar sesión”? → Parte del formulario queda literalmente fuera de la pantalla (F-017).

## 7. Problemas de uso y experiencia

Ausencia total de retroalimentación tras acciones “destructivas” o de escritura (crear, editar, eliminar): ningún botón “Guardar”/“Crear”/“Asignar” muestra un toast de éxito, cierra el modal automáticamente ni refleja el cambio en la tabla — NO VERIFICABLE si esto es una limitación consciente del prototipo estático o una omisión, pero desde la experiencia del aprendiz es indistinguible de “no pasó nada”.

Falta de confirmación antes de acciones irreversibles (eliminar, revocar, desactivar usuario) — más grave aún porque, además de faltar la confirmación, el botón ni siquiera dispara nada (F-003).

El botón type="reset" “Limpiar filtros” dentro del propio formulario de filtros sí funciona nativamente en HTML (borra el contenido visual de los campos), pero como no existe un “Aplicar”, el usuario nunca sabe si filtrar realmente cambia algo — la sensación es de una interfaz decorativa, no funcional.

Los mensajes de ayuda dinámicos (“→ 105% de asistencia” en Registrar seguimiento) sugieren que el sistema recalcula en tiempo real, pero al no existir listeners de input, el valor queda fijo pase lo que pase se escriba.

## 8. Problemas visuales

Sistema de tokens compartido (tokens.css) consistente: colores de estado, tipografía y espaciados coherentes entre pantallas — positivo, no se documenta como hallazgo.

Iconos SVG con fallas de renderizado visibles en al menos 2 capturas de referencia (F-015).

Elemento visual “flotante” no identificado sobre el botón “Limpiar filtros” en móvil (F-016).

## 9. Problemas de accesibilidad

Uso de aria-label, aria-expanded, role="dialog"/aria-modal presente en muchos componentes — cobertura parcial pero real (no es que falte por completo).

Sin gestión de foco en modales/paneles (F-012): esto es la falla de accesibilidad más importante encontrada, porque afecta a los ~25 modales y 2 paneles laterales (drawer, notificaciones) del sistema completo.

Cero atributos alt en toda la aplicación — contextualmente esperable, porque no hay ninguna etiqueta <img>; todo el contenido gráfico son iconos SVG inline, muchos ya cubiertos por aria-label en el botón que los contiene. No lo cuento como hallazgo aparte de F-012/F-015.

Objetivos táctiles: el propio “App Shell por rol” (shell/screens.js:8) declara como meta “objetivos táctiles ≥44px” — NO VERIFICABLE con precisión sin poder medir directamente en el navegador, queda como pendiente de validación con herramientas de accesibilidad reales (axe, Lighthouse) sobre el sitio en vivo.

## 10. Problemas en celular / responsive

F-015, F-016 y F-017 (ver tabla maestra) son los tres hallazgos móviles confirmados con captura.

La adaptación general de tablas a móvil (formato de tarjeta apilada en vez de scroll horizontal) es un acierto de diseño — confirmado en mobile/08-horarios-lista.png.

Pendiente de revisión visual (sin captura publicada): pantallas 46 a 53 en vista móvil — NO VERIFICABLE VISUALMENTE.

## 11. Problemas de funcionamiento

F-001, F-002, F-003, F-004, F-005, F-006, F-007, F-011, F-019, F-021 (ver tabla maestra) son, en conjunto, los hallazgos que más comprometerían el uso real del sistema si este código pasara a producción sin revisión: paginación, filtros, eliminar/cancelar, reintentar, limpiar filtros vacíos, login, logout, notificaciones, plantillas y navegación semanal no hacen lo que su propio texto promete.

## 12. Diferencias e inconsistencias entre roles

Coordinador vs. Director sobre las mismas pantallas de Horarios/Fichas/Disponibilidad: mismo componente, pero Director nunca ve botones de acción (F-008) y además no tiene entrada de menú para llegar ahí (F-022) — dos capas de fricción sobre la misma función.

Soporte vs. Director en Parametrización: comparten el Hub nuevo, pero Soporte también conserva rutas del sistema antiguo que Director no tiene en su propio inventario visible por navegación (F-023).

Notificaciones existen como concepto para Aprendiz (pantalla dedicada) y como overlay genérico para todos los roles vía campana del header, pero el overlay siempre termina forzando el contexto de Aprendiz al usar “Ver todas” (F-011) — la función no está realmente pensada para los demás roles, aunque aparece disponible para todos ellos.

## 13. Problemas que se repiten

## 14. Mi recorrido como aprendiz

Escenario: “Soy un aprendiz y quiero consultar y gestionar mi información académica.”

Qué hago primero: Entro por /login. El formulario ya viene con un correo y contraseña de ejemplo precargados (coordinador@sena.edu.co / Demo2026!). Los reemplazo por uno que empiece con “aprendiz” para entrar con mi rol.

Qué veo: Aterrizo en /mi-horario, con mi horario semanal de la ficha 2874412 listado por día (no como calendario visual — esa vista solo la tiene Instructor).

Qué entiendo: Puedo ver mis clases de la semana y pulsar “Ver detalle” en cualquiera.

Dónde me confundo: Al abrir el detalle de una clase no hay forma de volver excepto el enlace “Volver a Mi horario” — no hay breadcrumb ni indicación de en qué parte del sistema estoy más allá del título de la página.

Qué problema encuentro: Si voy a “Notificaciones” y luego a la campana del header para ver el panel superpuesto, y toco “Ver todas” desde ahí, no pasa nada visible distinto porque ya estaba en mi propio rol — pero si un Coordinador hiciera lo mismo, terminaría viendo el sistema como si fuera yo (F-011), lo cual muestra que el diseño de notificaciones no está pensado realmente por rol.

Cómo intento solucionarlo: No hay nada que yo, como aprendiz, pueda hacer para “arreglarlo” — es un problema de diseño, no de uso.

Si el sistema me ayuda: Dentro de mis dos pantallas propias (Mi horario, Notificaciones) el sistema es simple y no me confunde: pocos elementos, texto claro, sin jerga técnica.

Si logro completar el proceso: Sí — como Aprendiz, con solo 4 pantallas disponibles (horario, detalle de clase, notificaciones, detalle de notificación), el recorrido es corto y no tropieza con los problemas sistémicos de paginación/filtros, porque ninguna de mis pantallas los usa. La experiencia del Aprendiz es, irónicamente, la más sólida de las 6 revisadas, precisamente por ser la más pequeña.

Escenario adicional — Instructor registrando seguimiento: entra a /instructor/seguimiento, pulsa “+ Registrar seguimiento” y ve, sin haber escrito nada, una advertencia de que los asistentes no pueden superar el total de aprendices (F-014) — un instructor novato podría pensar que ya cometió un error antes de empezar.

## 15. Los 10 problemas que yo corregiría primero

## 16. Qué corregiría

Cablear primero los componentes compartidos (pagination(), filters(), state() con data-retry), porque cada corrección ahí se propaga automáticamente a docenas de pantallas — es la relación costo/beneficio más alta de todo el informe.

Auditar cada botón “peligroso” (eliminar/revocar/desactivar) y exigir un modal de confirmación estándar antes de ejecutarlo, ya existente como patrón (C().modal) pero no reutilizado para confirmaciones.

Revisar cada pantalla de “detalle” (userDetail, y por extensión cualquier futura pantalla similar) para asegurarse de que todo el contenido derive del registro real, no solo el encabezado.

Añadir gestión de foco a C().modal() de forma centralizada (un único cambio en bindInteractions que mueva el foco al abrir y lo devuelva al cerrar) para resolver F-012 en las ~25 instancias de una sola vez.

Revisar el copy hardcodeado (“45 pantallas”, “3 pendientes”) y sustituirlo por valores calculados desde M.inventory.length y desde los datos reales de notificaciones.

Definir qué pasa con la navegación del Director: si tiene permiso de ruta sobre Horarios/Fichas/Disponibilidad, debe tener también su entrada de menú — o, si es intencional que no la tenga, quitarle el permiso de ruta para no dejar “puertas traseras” no documentadas.

Decidir el futuro del sistema antiguo de parametrización (#40, #45): o se retira del inventario, o se enlaza desde algún lugar de la navegación de Soporte.

Publicar las 8 capturas faltantes (pantallas 46-53) para poder cerrar la brecha de verificación visual señalada en este informe.

## 17. Conclusión como aprendiz

¿El sistema es fácil de usar? En la parte del Aprendiz sí me pareció sencillo, porque las opciones son pocas y se entienden rápido. El problema aparece más en los roles que tienen que administrar información, porque ahí hay botones, filtros y páginas que parecen funcionar pero no responden.

¿Qué es lo que más me confundió? Que cuando uno pulsa un botón y no pasa nada, el sistema tampoco explica qué ocurrió. Como usuario nuevo, uno termina pensando si hizo algo mal o si el problema es de la página.

¿Qué está mejor logrado? La parte visual. Los colores de estados, la tipografía, las tarjetas y la forma en que varias tablas se acomodan en celular están bien pensadas.

¿Qué cambiaría primero? Empezaría por los problemas que se repiten en muchas pantallas: paginación, filtros y manejo de los modales. Si se corrige el componente que está mal, se arreglan varias pantallas de una vez.

¿Qué problemas impedirían que un aprendiz lo use correctamente? En las pantallas propias del Aprendiz no encontré algo que le impida completar su recorrido. Los problemas más fuertes aparecen en Coordinador, Instructor, Director y Soporte.

¿Qué problemas son solo visuales? Principalmente los iconos que se ven mal, la caja que aparece flotando en móvil y algunos textos que están desactualizados.

¿Qué problemas son realmente funcionales? Los de paginación, filtros, eliminar/cancelar, reintentar, login, cierre de sesión, notificaciones, plantillas y cambio de semana, porque no es solo que se vean mal: la acción no hace lo que debería.

¿Qué debería corregirse antes de producción? Primero los problemas críticos, sobre todo los que pueden afectar datos, permisos o el cambio de sesión. Después corregiría los componentes repetidos para que el arreglo se refleje en varias pantallas.

## 18. Evidencias de las capturas que tomé

Estas evidencias salen de las capturas que tomé mientras iba revisando el sistema. En varias marqué con círculos o flechas lo que me estaba generando el problema.

Esta sección cierra la brecha de verificación visual señalada en la Nota metodológica (§0): cubre, entre otras, varias pantallas del Hub de Parametrización (#46–53) que antes estaban marcadas NO VERIFICABLE VISUALMENTE.

Como en el resto del informe: OBSERVADO = visible directamente en la captura · INFERENCIA = deducción razonable · NO VERIFICABLE EN EL MOCKUP = no comprobable por ser un prototipo estático.

## 18.1 Tabla de evidencias

## 18.2 Confirmaciones directas de hallazgos ya documentados

F-001 (paginación no funciona): confirmado en Horarios, Mi disponibilidad, Notificaciones y 6+ pantallas del Hub de Parametrización.

F-002 (filtros no filtran): evidencia más clara del informe —  con el filtro “Estado = Etapa productiva” aplicado, la primera fila visible tiene estado “Ejecución”.

F-003 (eliminar/cancelar sin función): confirmado en Horarios

F-014 (validaciones permanentes en formularios vacíos): confirmado en “Nuevo usuario” y “Registrar seguimiento”

F-020 (columnas “Recibido”/“Ocurrido en origen” duplicadas):  muestra el mismo valor en ambas columnas.

F-021 (no se puede cambiar de semana):

## 19. Hallazgos nuevos que encontré en las capturas

El análisis de código no podía detectar estos hallazgos porque son de datos mostrados o de layout renderizado, no de “falta un event listener”.

ID: F-027 Pantalla: Modal “Agregar sesión” abierto desde “Nuevo horario” · Rol: Coordinador Académico · Categoría: Datos / Consistencia

Evidencia E-007

Problema: El formulario “Nuevo horario” abre con el campo Ficha ya precargado (“2874412 — ADSO”) y la tabla de Sesiones ya contiene 3 filas idénticas a un horario existente, en lugar de un formulario en blanco. ¿Por qué es un problema? Un “nuevo horario” no debería mostrar datos de un horario ya existente. ¿Cómo afecta al aprendiz? Genera la duda de si está creando algo nuevo o editando sin saberlo; si lo usa como referencia, puede asumir que crear siempre parte de datos previos. Severidad: ALTO Recomendación: El formulario debe iniciar completamente vacío. Evidencia: E-007

ID: F-028 Pantalla: Modal “Agregar sesión”, “Nueva/editar franja”, “Generar documento” · Rol: Coordinador, Director, Soporte · Categoría: Formularios / Funcionalidad

Problema: Los mensajes de validación se muestran de forma permanente, incluso cuando el valor ya cumple la condición descrita: “Este instructor ya tiene una sesión” con valores por defecto; “hora inicio debe ser menor que hora fin” con 07:00/10:00 (válido); “Ingresa un UUID válido” con “sch-01” ya escrito. ¿Por qué es un problema? Sugiere que los mensajes están fijos en el HTML del formulario, no ligados a una validación real. ¿Cómo afecta al aprendiz? Pierde la confianza en cualquier mensaje de validación del sistema, incluidos los que sí son reales. Severidad: CRÍTICO — aparece en al menos 3 formularios distintos, es un patrón. Recomendación: Los mensajes de error deben aparecer solo tras una validación fallida real, nunca por defecto. Evidencia: E-001, E-007, E-015, E-027

ID: F-029 Pantalla: Modal “Nuevo usuario” · Rol: Director de Centro · Categoría: Datos

Evidencia E-013

Problema: El formulario “Nuevo usuario” abre con Nombre=“Laura”, Apellido=“Ramírez” ya escritos y el error “correo ya registrado” visible sin interacción previa. ¿Por qué es un problema? Un formulario de creación no debería traer datos de otra persona precargados. ¿Cómo afecta al aprendiz? Riesgo de crear un usuario con datos que no pretendía ingresar si no revisa con cuidado. Severidad: ALTO Recomendación: Inicializar el formulario completamente vacío. Evidencia: E-013

ID: F-030 Pantalla: Parametrización — Currículo académico, modal competencia · Rol: Director de Centro · Categoría: UI / Accesibilidad

Evidencia E-014

Problema: Los checkboxes de “Resultados de aprendizaje asociados” no tienen separación entre opciones — el texto de una se pega al inicio de la siguiente. El modal muestra además scroll horizontal. ¿Por qué es un problema? Es difícil saber a qué casilla corresponde cada texto. ¿Cómo afecta al aprendiz? Puede marcar/desmarcar el resultado de aprendizaje equivocado sin notarlo. Severidad: ALTO Recomendación: Cada checkbox con su etiqueta en su propia fila; eliminar el scroll horizontal ajustando el ancho o usando wrap. Evidencia: E-014

ID: F-031 Pantalla: Sistémico — 6+ pantallas del Hub de Parametrización, Mi disponibilidad, Notificaciones · Rol: Todos · Categoría: Datos / Funcional

Evidencia E-020

Problema: El indicador “Mostrando X–Y de Z” y los números de página no coinciden con la cantidad real de registros ni con el tamaño de página seleccionado. Ejemplos: “Mostrando 1–9 de 9” pero se listan páginas 2 y 3 igualmente; “10 por página” seleccionado pero se listan 12 filas; “Mostrando 1–3 de 34” sin filtro aplicado. ¿Por qué es un problema? Va más allá de F-001 (“no responde al clic”): aquí el cálculo mismo del número de páginas y del tamaño de página no coincide con los datos mostrados — es una capa adicional del mismo defecto sistémico del componente pagination(). ¿Cómo afecta al aprendiz? Refuerza la desconfianza general en los datos que el sistema dice tener frente a los que realmente muestra. Severidad: CRÍTICO — amplía el alcance de F-001, mismo componente compartido. Recomendación: Calcular totalPáginas = ceil(total / porPágina) y ocultar páginas inexistentes; aplicar realmente el tamaño de página al recorte de filas. Evidencia: E-004, E-008, E-016, E-017, E-020

ID: F-032 Pantalla: Parametrización — RBAC, listado de roles · Rol: Director de Centro · Categoría: Datos / Funcionalidad

Evidencia E-023

Problema: El rol “AREA_LEADER” aparece con 0 permisos asignados, mientras el resto tiene entre 5 y 45. ¿Por qué es un problema? Un rol con cero permisos no podría hacer nada si se asignara a un usuario real. ¿Cómo afecta al aprendiz? Al revisar los 7 roles del sistema no encuentra diferencia funcional que justifique la existencia de este rol. Severidad: MEDIO Recomendación: Completar la matriz de permisos de AREA_LEADER o marcarlo como “en construcción”. Evidencia: E-023

ID: F-033 Pantalla: Parametrización — RBAC, modal “Rol y sus permisos — COORDINATOR” · Rol: Director de Centro · Categoría: Datos / Seguridad aparente

Evidencia E-022

Problema: El permiso IDENTITY_ROLE_MANAGE (gestión de roles del sistema) está marcado para el Coordinador Académico, cuya descripción es “fichas, instructores y horarios”; en cambio IDENTITY_USER_MANAGE (más básico) no está marcado. ¿Por qué es un problema? Es contradictorio: el rol con menor alcance declarado tiene un permiso de administración de sistema. ¿Cómo afecta al aprendiz? Es el tipo de “cascarita” de examen: “¿por qué el Coordinador puede gestionar roles pero no usuarios?” sin respuesta consistente. Severidad: MEDIO Recomendación: Revisar la matriz de permisos contra la matriz RBAC oficial del proyecto. Evidencia: E-022

ID: F-034 Pantalla: Hub de Parametrización (portada) · Rol: Director de Centro · Categoría: Navegación / Funcional

Evidencia E-026

Problema: De las 8 tarjetas del Hub, “Catálogos y parámetros” es la única que no abre su pantalla; presenta un error al hacer clic. ¿Por qué es un problema? Es una ruta rota accesible desde la navegación principal del módulo, no un caso límite. ¿Cómo afecta al aprendiz? Interrumpe cualquier flujo que dependa de configurar catálogos genéricos antes de operar — el propio banner de la pantalla dice “Complete la parametrización antes de operar”. Severidad: CRÍTICO Recomendación: Corregir la ruta/render de “Catálogos y parámetros”; agregar manejo de error visible con reintento real. Evidencia: E-026

ID: F-035 Pantalla: Administración — Documentos · Rol: Administrador de Soporte · Categoría: Funcional / UX

Evidencia E-027

Problema: Una fila de la tabla de documentos muestra el botón “Reintentar” (rojo) en lugar de “Descargar” — pero por F-004 ese botón no tiene manejador de clic. ¿Por qué es un problema? El único documento marcado con error queda sin ninguna vía real de recuperación. ¿Cómo afecta al aprendiz? Si necesitara ese documento específico, no tiene ninguna acción disponible que le ayude a resolverlo. Severidad: ALTO Recomendación: Implementar el manejador de “Reintentar” o mostrar un mensaje explicando qué hacer. Evidencia: E-027

## 20. Galería de evidencias

Capturas no referenciadas en las secciones anteriores, incluidas aquí para dejar constancia de las 28 en su totalidad:

E-003 — Ficha 2874412, detalle (Coordinador).

E-004 — Horarios, paginación circulada por el aprendiz (Coordinador).

E-005 — Disponibilidad de ambiente, enlace “Ver reporte” circulado (Coordinador).

E-008 — Mi disponibilidad (Instructor).

E-010 — Mi horario, navegación semanal (Instructor).

E-011 — Notificaciones (Aprendiz).

E-012 — Indicadores, Ficha 2874412 (Director).

E-016 — Tipos de ambiente, modal (Director).

E-017 — Tipos de ambiente, tabla (Director).

E-018 — Catálogos de monitoreo, modal KPI (Director).

E-019 — Catálogos de monitoreo, tabla (Director).

E-021 — Geografía institucional (Director).

E-024 — Error 403 al navegar como Director (Director).

E-025 — Datos de referencia, Mi centro (Director).

E-028 — Auditoría, detalle de registro (Soporte).

## 21. Cierre de la revisión

Distribución de severidad acumulada: 10 críticos · 12 altos · 9 medios · 3 bajos · 1 no verificable/mejora.

Pendiente para una v3: el aprendiz reportó tener capturas adicionales del error específico de “Catálogos y parámetros” (F-034, error reportado como “400”) que no se incluyeron en el .docx recibido — se recomienda anexarlas cuando estén disponibles para documentar el código de error exacto.

Fin del informe — versión 3. 35 hallazgos documentados: 26 con referencia exacta a archivo/línea de código, 9 adicionales con referencia a captura de pantalla real tomada por el aprendiz durante el uso del sistema.


### Tabla 1

| Rol | Pantalla de inicio | Pantallas propias | Acceso de solo lectura a pantallas de otro rol |
| --- | --- | --- | --- |
| Público | /login | Login, recuperar/nueva contraseña | — |
| Coordinador Académico | / | Dashboard, Horarios (CRUD), Conflictos, Disponibilidad, Fichas | — |
| Instructor | /instructor/mi-horario | Mi horario, Mi disponibilidad, Seguimiento | — |
| Aprendiz | /mi-horario | Mi horario, Notificaciones | — |
| Director de Centro | /admin/indicadores | Indicadores, Usuarios, Datos de referencia, Parametrización (Hub) | Sí — Horarios, Disponibilidad y Fichas del Coordinador, en modo solo lectura forzado (ver F-008, F-022) |
| Administrador de Soporte | /backoffice/documentos | Documentos, Plantillas, Auditoría, Parametrización antigua | Comparte el Hub de parametrización con Director |

### Tabla 2

| ID | Pantalla(s) | Rol(es) | Categoría | Problema | Severidad | Evidencia |
| --- | --- | --- | --- | --- | --- | --- |
| F-001 | Todas las tablas paginadas (≈20 pantallas) | Todos | Funcional/Navegación | Botones “Anterior/1/2/3/Siguiente” y selector “por página” sin manejador de clic | CRÍTICO | assets/components.js:25 — pagination() no genera ningún data-* |
| F-002 | Todas las pantallas con filtros (≈15) | Todos | UX/Formularios | Formulario de filtros sin botón “Aplicar” ni envío programado | CRÍTICO | assets/components.js:33-38; sin listener data-filter-form en app.js |
| F-003 | Mi disponibilidad, Horarios, Franjas, Ambientes, Reglas, Categorías/Estados de actor, Detalle de usuario (6+ pantallas) | Instructor, Coordinador, Director/Soporte | Formularios/UX | 14 botones “Eliminar/Cancelar sesión/Revocar” sin manejador ni confirmación | CRÍTICO | ver §9 “Problemas repetidos” para el listado completo |
| F-004 | Cualquier pantalla en state=error; Estados globales (500) | Todos | UX | Botón “Reintentar” (data-retry) no tiene listener; en 500 el botón navega a Inicio, no reintenta | ALTO | assets/components.js:48; shell/screens.js:14 |
| F-005 | Cualquier pantalla en state=empty | Todos | UX | Botón “Limpiar filtros” del estado vacío es un <button> sin manejador | ALTO | assets/components.js:49 |
| F-006 | Login | Público | Formularios/Lógica | El formulario no valida credenciales; cualquier texto no reconocido inicia sesión como Coordinador por defecto; el estado de error solo se activa manualmente vía URL | CRÍTICO | shell/app.js:63; iam/screens.js:6 |
| F-007 | Menú de usuario → Cerrar sesión | Todos | Lógica/Seguridad | “Cerrar sesión” navega a /login pero nunca limpia localStorage; el rol persiste | ALTO | shell/app.js:18-19,54 (no hay localStorage.removeItem) |
| F-008 | Todo el sistema para rol Director | Director | Lógica/Roles | readonly se calcula como role==='director' de forma global, sin relación al permiso real; contradice la matriz RBAC (#53) donde CENTER_DIRECTOR tiene 36 permisos, muchos WRITE/PUBLISH | ALTO | shell/app.js:25 |
| F-009 | Menú de usuario, /inventory | Todos | UI/Datos | Texto hardcodeado “Índice de 45 pantallas” en 2 lugares; el inventario real tiene 53 | MEDIO | shell/shell.js:9; shell/screens.js:6 |
| F-010 | Header (todas las pantallas autenticadas) | Todos | UI/Datos | Insignia de notificaciones fija en “3”, no depende de datos reales ni de rol | BAJO | shell/shell.js:9 (aria-label="Notificaciones, 3 pendientes" literal) |
| F-011 | Panel de notificaciones (overlay) | Todos | Funcional/Roles | El enlace “Ver todas” fuerza ?as=learner, cambiando el rol activo a Aprendiz sin aviso, sin importar el rol desde el que se abrió | CRÍTICO | shell/shell.js:13 |
| F-012 | Todos los modales (≈25 instancias) | Todos | Accesibilidad | Sin focus trap ni devolución de foco al cerrar; aria-modal="true" presente pero sin manejo real de foco | ALTO | assets/components.js:52; sin lógica de foco en app.js |
| F-013 | Prácticamente todos los formularios | Todos | Formularios | Solo 14 usos de required en toda la app; sin indicador visual sistemático de obligatoriedad | MEDIO | grep global |
| F-014 | Nuevo usuario, Asignar rol, Registrar seguimiento, Agregar sesión (≥5 pantallas) | Coordinador, Director, Instructor | Formularios/UX | Mensajes de error mostrados de forma permanente sin interacción del usuario (ej. “Este correo ya está registrado” al abrir el modal en blanco) | ALTO | iam/screens.js:17,22; monitoring/screens.js:19; ver §6 (cascaritas) |
| F-015 | Login (desktop), Horarios (móvil) | Público, Coordinador | UI/Accesibilidad | Iconos SVG (ojo, búsqueda) se renderizan como manchas negras sólidas, sin forma reconocible | MEDIO | Captura desktop/01-login.png, mobile/08-horarios-lista.png |
| F-016 | Horarios — lista (móvil) | Coordinador | UI/Responsive | Caja blanca vacía flotando sobre el botón “Limpiar filtros” | BAJO | Captura mobile/08-horarios-lista.png |
| F-017 | Modal agregar/editar sesión (móvil) | Coordinador | Responsive | Modal no se adapta a una columna: campos “Competencia” y “Ambiente” quedan cortados fuera del viewport; sin fondo opaco completo | CRÍTICO | Captura mobile/11-modal-agregar-editar-sesion.png |
| F-018 | Detalle de usuario, Modal Asignar rol | Director, Soporte | Datos/Lógica | El encabezado usa el usuario real seleccionado, pero el cuerpo (pestaña Perfil, “Roles asignados”, título del modal) siempre muestra “Juan Pérez”/“Instructor”, sin importar qué usuario se abrió | CRÍTICO | iam/screens.js:21-22 |
| F-019 | Plantillas de documento | Soporte | Navegación/Lógica | “+ Nueva plantilla” enlaza a la edición de una plantilla existente (tpl-01, código en solo lectura), no a un formulario en blanco | ALTO | document/screens.js:13 |
| F-020 | Auditoría — lista | Soporte | Datos | Columnas “Recibido” y “Ocurrido en origen” usan la misma clave de datos y siempre muestran el mismo valor | MEDIO | audit/screens.js:8 (key:'date' repetido) |
| F-021 | Mi horario (Instructor) | Instructor | Navegación | “Semana anterior”/“Semana siguiente” sin manejador; no se puede cambiar de semana | ALTO | scheduling/screens.js:108 |
| F-022 | Menú del Director | Director | Navegación/Roles | Director tiene permiso de ruta para Horarios/Disponibilidad/Fichas pero el menú lateral no los enlaza; solo accesibles por URL directa | MEDIO | shell/routes.js:69-76 vs. navByRole.director (línea 108) |
| F-023 | Parametrización (Back-office antiguo vs. Hub nuevo) | Soporte, Director | Arquitectura/Navegación | Coexisten dos sistemas de parametrización (#40/#45 antiguo, #46-53 nuevo); el menú solo enlaza al nuevo, dejando huérfanas las pantallas antiguas | MEDIO | shell/routes.js:89-102 vs. navByRole.support |
| F-024 | Parametrización — Jornadas | Director/Soporte | Datos (interno) | Valor de jornada nocturna mal escrito como 'NIGTH' en datos y <option value> | BAJO | scheduling/screens.js:131-158 |
| F-025 | Nueva contraseña | Público | Formularios | Sin validación real de coincidencia entre contraseñas; “Guardar” es un enlace que navega a Login sin importar el contenido | NO VERIFICABLE / MEJORA | iam/screens.js:8 |
| F-026 | Recuperar contraseña | Público | Formularios | Sin validación de formato de correo ni de campo vacío; “Enviar enlace” es un enlace que siempre “funciona” | MEDIO | iam/screens.js:7 |
| F-027 | Modal “Agregar sesión” sobre “Nuevo horario” | Coordinador | Datos/Consistencia | “Nuevo horario” abre precargado con la ficha 2874412 y 3 sesiones ya existentes, en vez de un formulario vacío | ALTO | Captura del aprendiz (E-007) |
| F-028 | Modal “Agregar sesión”, “Nueva/editar franja”, “Generar documento” (3+ formularios) | Coordinador, Director, Soporte | Formularios/Funcional | Mensajes de validación (“instructor ya tiene sesión”, “hora inicio > hora fin”, “UUID inválido”) se muestran siempre, incluso con datos válidos — parecen fijos en el HTML, no una validación real | CRÍTICO | Capturas del aprendiz (E-001, E-007, E-015, E-027) |
| F-029 | Modal “Nuevo usuario” | Director | Datos | El formulario de creación abre con Nombre=“Laura”, Apellido=“Ramírez” y el error “correo ya registrado” ya visible, sin que el usuario escriba nada | ALTO | Captura del aprendiz (E-013) |
| F-030 | Parametrización — Currículo académico, modal competencia | Director | UI/Accesibilidad | Checkboxes de “Resultados de aprendizaje” sin separación visual entre opciones (texto pegado); modal con scroll horizontal | ALTO | Captura del aprendiz (E-014) |
| F-031 | ≥6 pantallas del Hub de Parametrización + Mi disponibilidad + Notificaciones | Todos | Datos/Funcional | El indicador “Mostrando X–Y de Z” y el número de páginas no coinciden con los datos reales ni con el tamaño de página seleccionado (ej. “1–9 de 9” pero muestra páginas 2 y 3; “10 por página” pero lista 12 filas) | CRÍTICO | Capturas del aprendiz (E-004, E-008, E-016, E-017, E-020) |
| F-032 | Parametrización — RBAC, listado de roles | Director | Datos/Funcional | El rol AREA_LEADER tiene 0 permisos asignados, a diferencia de los otros 6 roles del sistema (5 a 45 permisos) | MEDIO | Captura del aprendiz (E-023) |
| F-033 | Parametrización — RBAC, modal “Rol y sus permisos — COORDINATOR” | Director | Datos/Seguridad aparente | El Coordinador Académico tiene marcado el permiso IDENTITY_ROLE_MANAGE (gestión de roles del sistema), inconsistente con el alcance declarado del rol | MEDIO | Captura del aprendiz (E-022) |
| F-034 | Hub de Parametrización (portada) | Director | Navegación/Funcional | La tarjeta “Catálogos y parámetros” es la única de 8 que no abre su pantalla; presenta un error al hacer clic | CRÍTICO | Captura del aprendiz (E-026) |
| F-035 | Administración — Documentos | Soporte | Funcional/UX | Un documento en estado de error muestra botón “Reintentar” (rojo) que, por F-004, no tiene manejador — sin vía real de recuperación | ALTO | Captura del aprendiz (E-027) |

### Tabla 3

| Patrón | N.º de apariciones | Pantallas |
| --- | --- | --- |
| Botón de acción sin data-*/manejador (eliminar, cancelar, revocar, reintentar, descargar, copiar) | ≥18 | Mi disponibilidad, Horarios (2), Franjas horarias, Tipos de ambiente, Tipos de inventario, Reglas de disponibilidad, Categorías de actor, Estados de actor, Transiciones de estado, Documentos (descargar/reintentar), Auditoría (copiar JSON), Detalle de usuario (editar/desactivar/revocar rol/revocar sesión) |
| Paginación decorativa | Todas las tablas con pagination() | ~20 pantallas de listado |
| Filtros sin botón de aplicar | Todas las pantallas con filters() | ~15 pantallas |
| Mensaje de error/validación mostrado de forma permanente sin interacción | 5 | Nuevo usuario, Asignar rol, Registrar seguimiento, RBAC (implícito en selects pre-marcados), Agregar sesión |
| Texto o dato hardcodeado que ignora el registro seleccionado | 3 focos | Detalle de usuario (Perfil/Roles/modal), “45 pantallas” (2 lugares), insignia de notificaciones fija en “3” |

### Tabla 4

| # | Problema | Pantalla(s) | Impacto | Severidad | Por qué corregir primero | Solución recomendada |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | Filtros no aplican ningún criterio | ~15 pantallas | El usuario cree que puede acotar resultados y no puede | CRÍTICO | Afecta la usabilidad básica de casi todo listado del sistema | Agregar botón “Aplicar filtros” con manejador que reconstruya la tabla, o al menos re-renderizar en change/submit |
| 2 | Paginación decorativa | ~20 pantallas | Datos más allá de la página 1 son inalcanzables | CRÍTICO | Mismo alcance masivo que el #1 | Cablear data-page en los botones y re-renderizar M.screens[...] con el nuevo page |
| 3 | “Ver todas” de notificaciones cambia el rol activo sin avisar | Panel de notificaciones (todas las pantallas) | Cambia el contexto de sesión como efecto secundario oculto | CRÍTICO | Rompe la confianza en la navegación de cualquier rol que no sea Aprendiz | Enlazar a /notificaciones sin forzar ?as=learner, o mostrar un aviso explícito de cambio de rol |
| 4 | 14+ botones de eliminar/cancelar/revocar sin función | 6 pantallas | Simula operaciones CRUD que no existen; sin confirmación | CRÍTICO | Es la base de cualquier gestión de catálogos/usuarios | Cablear data-open-modal="confirm-delete" con modal de confirmación explícita |
| 5 | Modal “Agregar sesión” roto en móvil | Modal de sesión (móvil) | Contenido fuera de pantalla, formulario inutilizable | CRÍTICO | Bloquea por completo una tarea central del Coordinador en móvil | Forzar grid-template-columns: 1fr dentro de @media (max-width: 768px) en los formularios de dos columnas |
| 6 | Detalle de usuario muestra datos de otro usuario (“Juan Pérez”) | Detalle de usuario, modal Asignar rol | Riesgo real de confusión sobre a quién se le asigna/revoca un rol | CRÍTICO | Es un defecto de integridad de datos, no solo estético | Reemplazar los literales por los campos reales del objeto u encontrado |
| 7 | Login no valida credenciales | Login | El estado de error nunca se activa por uso real | CRÍTICO | Es la primera pantalla que ve cualquier persona | Añadir validación mínima (correo/contraseña no vacíos, dominio institucional) antes de redirigir |
| 8 | Director forzado a solo lectura de forma global | Todo el sistema para Director | Contradice la matriz RBAC propia del sistema (36 permisos) | ALTO | Inconsistencia arquitectónica entre la documentación de permisos y el comportamiento real | Sustituir el flag global por verificación de features reales (x-required-feature) por pantalla |
| 9 | No se puede cambiar de semana en “Mi horario” (Instructor) | Mi horario — Instructor | Bloquea la consulta de horarios pasados/futuros | ALTO | Función anunciada visualmente pero inexistente | Cablear los botones a updateQuery({week:...}) y filtrar calendarSessions por semana |
| 10 | “+ Nueva plantilla” abre una plantilla existente | Plantillas de documento | Contradice literalmente el texto del botón | ALTO | Alta probabilidad de que un aprendiz sobrescriba sin darse cuenta una plantilla real | Crear una ruta /.../plantillas/nueva/editar con un formulario en blanco real |

### Tabla 5

| Evidencia | Pantalla | Rol | Nota del aprendiz | Hallazgo relacionado |
| --- | --- | --- | --- | --- |
| E-001 | Modal “Agregar sesión” | Coordinador | “Error porque esto es para editar y no me deja agregarla ya que se editó la sesión” | F-028, F-037 |
| E-002 | Horarios — tabla de sesiones | Coordinador | “Al eliminar no deja y cancelar tampoco” | F-003 |
| E-003 | Ficha 2874412 — detalle | Coordinador | — | F-001 |
| E-004 | Horarios — paginación | Coordinador | “ninguno de los botones de agregar sesión funcionan” | F-001, F-031 |
| E-005 | Disponibilidad — Laboratorio A-204 | Coordinador | “no funcionan tampoco” | Enlace sin acción |
| E-006 | Fichas — listado con filtros | Coordinador | “el ver reporte tampoco funciona” | F-002 |
| E-007 | Modal “Agregar sesión” sobre “Nuevo horario” | Coordinador | “ninguno de esos botones funciona ni los display” | F-027, F-028 |
| E-008 | Mi disponibilidad | Instructor | “el form… no sirve tampoco no registra” | F-001, F-031 |
| E-009 | Modal “Registrar seguimiento” | Instructor | “panel de instructor igual dashboard sin funcionar nada” | F-014 |
| E-010 | Mi horario (semana) | Instructor | “tampoco deja mirar semana pasada ni la siguiente” | F-021 |
| E-011 | Notificaciones | Aprendiz | “dice que hay más de 18 y los botones no dejan saltar” | F-001 |
| E-012 | Indicadores — Ficha 2874412 | Director | “nada sirve solo mostrario” | F-001 |
| E-013 | Modal “Nuevo usuario” | Director | “nada de ello me deja hacer actualizaciones” | F-014, F-029 |
| E-014 | Currículo académico — modal competencia | Director | “Igual” | F-030 |
| E-015 | Jornadas/franjas — modal franja | Director | “no deja editar ni agregar ninguna franja” | F-028 |
| E-016 | Tipos de ambiente — modal | Director | “igual” | F-031 |
| E-017 | Tipos de ambiente — tabla | Director | “se muestran los datos pero no sirve ninguna función” | F-031 |
| E-018 | Catálogos de monitoreo — modal KPI | Director | “igual” | Layout — label superpuesto |
| E-019 | Catálogos de monitoreo — tabla | Director | “muestra pero nada funciona” | F-031 |
| E-020 | Estados de actores | Director | “nada funciona” | F-031 |
| E-021 | Geografía institucional | Director | “nada funciona” | F-031 |
| E-022 | RBAC — modal “Rol y sus permisos” | Director | “no funciona no deja actualizar ni crear” | F-033 |
| E-023 | RBAC — listado de roles | Director | “están los datos pero nada funciona” | F-032 |
| E-024 | Error 403 | Director | “error” | RBAC / permisos |
| E-025 | Datos de referencia (Mi centro) | Director | “nada funciona” | F-001, F-031 |
| E-026 | Hub de Parametrización (portada) | Director | “el único que dirige y no funciona… error 400” | F-034 |
| E-027 | Documentos — modal “Generar documento” | Soporte | “no sirve no deja documentar” | F-028, F-035 |
| E-028 | Auditoría — modal “Detalle de registro” | Soporte | “nada funciona ni lo de atrás ni el form” | F-020 |

### Tabla 6

| Rango | Origen | Cantidad |
| --- | --- | --- |
| F-001 a F-026 | Análisis de código (v1) | 26 |
| F-027 a F-035 | Evidencia visual — 28 capturas del aprendiz (v3) | 9 |
| Total acumulado |  | 35 |