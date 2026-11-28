# A3 · Patrones de Diseño (GoF) Aplicados al SGA
**Evidencia:** Guía 2 · Producto 1 (`G2-P1`) — Artefacto A3  
**Competencia:** 220501095 · **RAP:** 593103 (Criterio 3)  
**Aprendiz:** `MAET211` (Carpeta: `G2-P1-estrada`)  

---

## 1. Patrones Seleccionados y Reflejo Directo en el Diagrama de Clases

Para cumplir con el **Criterio 3 (Nivel 100)** de `Rubricas_G2.md`, se aplican **dos (2) patrones GoF distintos**, ambos diferentes de *Singleton* y modelados explícitamente dentro de [`02-diagrama-clases.svg`](./02-diagrama-clases.svg):
1. **Strategy (`Estrategia`)** — Patrón de comportamiento.
2. **Facade (`Fachada`)** — Patrón estructural.

---

## 2. Justificación Técnica Aplicada al Caso SGA

| Patrón GoF | Problema Concreto del Caso SGA | Por qué se eligió este Patrón | Clases que lo Implementan (`02-diagrama-clases.svg`) | Mejora Concreta en Mantenibilidad y Evolutividad |
|---|---|---|---|---|
| **Strategy (`Estrategia`)** *(Comportamiento)* | El SGA debe asignar ambulancias bajo **dos políticas incompatibles entre sí** según el contexto operativo: **(a)** asignación automática algorítmica en $\le 2\text{ s}$ por cercanía, disponibilidad y tipo `TAB`/`TAM` (`RF-022`, `CU-03`), y **(b)** anulación manual justificada por contingencia vial exigiendo motivo `RN-007` (`RF-023`, `CU-04`), además de futuras reglas (prioridad por saturación CRUE). | Desacopla el **qué** (asignar una unidad al servicio) del **cómo** (criterio de selección), sustituyendo condicionales rígidos `if/else` dentro de `ServicioAsistencial` o el controlador por polimorfismo sobre una interfaz común (`IEstrategiaAsignacion`). | • **Interfaz:** `IEstrategiaAsignacion`<br>• **Estrategia Concreta 1:** `AsignacionAutomaticaProximidad`<br>• **Estrategia Concreta 2:** `AsignacionManualContingencia`<br>• **Contexto:** `FachadaEmergenciaSGA` | Para agregar en el futuro una tercera política (ej. despacho por convenio externo o IA de tráfico) basta crear una nueva clase que implemente `IEstrategiaAsignacion`, cumpliendo el principio **Open/Closed (OCP)** sin tocar código ya validado de `CU-03` ni de `CU-04`. |
| **Facade (`Fachada`)** *(Estructural)* | Tanto el flujo de atención inicial (`DA-01`: crear paciente/solicitud, validar `REPS`/`RN-003`, verificar personal `RN-004`, ejecutar estrategia y crear servicio) como el cierre formal (`DA-02`: validar 4 campos `RN-005`, cerrar `ServicioAsistencial`, liberar `Ambulancia`, emitir `Factura` inmutable `RN-014`, grabar `RegistroAuditoria` `RN-010` y notificar en tiempo real) involucran la coordinación de **6 clases distintas** con consistencia atómica. | Si la capa de controladores/API invocara directamente cada clase del dominio, se produciría alto acoplamiento, riesgo de omitir la factura o la auditoría en algún endpoint y duplicación de secuencias transaccionales. `FachadaEmergenciaSGA` encapsula esa orquestación detrás de dos operaciones claras (`atenderEmergencia()` y `finalizarYCerrarServicio()`). | • **Fachada:** `FachadaEmergenciaSGA`<br>• **Subsistemas coordinados:** `SolicitudEmergencia`, `ServicioAsistencial`, `Ambulancia`, `Factura`, `RegistroAuditoria`, `IEstrategiaAsignacion` | Reduce el acoplamiento de la capa API hacia las entidades internas del núcleo; centraliza el cumplimiento obligatorio de las reglas `RN-001` a `RN-014` en un único punto verificable y facilita cambiar procesos internos del cierre sin alterar la interfaz consumida por los controladores. |

---

## 3. Verificación de Flujo Polimórfico (`Strategy` + `Facade`)

1. Al recibir una solicitud (`RF-021`, `RF-022`), el controlador invoca `fachada.atenderEmergencia(solicitud)` usando inyectada la implementación `AsignacionAutomaticaProximidad`.
2. Si el coordinador fuerza despacho manual (`RF-023`, `RN-007`), la fachada conmuta la estrategia hacia `AsignacionManualContingencia` manteniendo intacta la firma `estrategia.seleccionarAmbulancia(solicitud, flota)`.
3. Al concluir el traslado (`RF-025`, `RN-005`), `fachada.finalizarYCerrarServicio(idServicio, cierre)` valida el cumplimiento REPS en `ServicioAsistencial`, libera `Ambulancia`, invoca el módulo financiero mediante `Factura` (`RN-014`) y persiste el hito en `RegistroAuditoria` (`RN-010`) dentro de una transacción unificada.
