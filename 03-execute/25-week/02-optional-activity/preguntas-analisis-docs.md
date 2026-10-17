# Preguntas de Análisis Técnico — Apartado DOCS
## Proyecto: Orderflow Engine (`orderflow-engine-docs`)

Este documento consolida las **5 preguntas técnicas esenciales** formuladas a partir del análisis exhaustivo del repositorio de documentación (`spec/`, `governance/`, `handoff/` y `assignment/`), contrastando lo solicitado originalmente por el cliente en el *take-home* con la arquitectura y el código implementado.

---

### Pregunta 1: Arquitectura Multitienda y Separación de Responsabilidades
> **¿De qué manera el diseño del sistema garantiza el aislamiento estricto de productos, precios y pedidos entre tiendas (como "Tienda Norte" en Colombia y "Tienda Quito" en Ecuador), y qué mecanismo técnico en la API y en la base de datos impide que los pedidos de una tienda aparezcan en el historial de otra?**

* **Referencia documental:**
  - `spec/SPEC.md §5` (Multi-country and multi-tenant)
  - `spec/data-model.md §1, §2 y §4` (Reference data, Catalog and levers, Quotes and orders)
  - `spec/api-contract.md §2 (E-05) y §4 (BD-01)`
* **Respuesta técnica documentada:**
  - **Encabezados de contexto:** Cada petición HTTP exige los encabezados `X-Tenant-Id` (que identifica la tupla país/marca, ej. `co-alpha` o `ec-alpha`) y `X-Customer-Id`.
  - **Aislamiento en base de datos:** En PostgreSQL, todas las tablas de catálogo, clientes, cotizaciones y pedidos están en tercera forma normal (3FN) y emplean claves primarias compuestas lideradas por el tenant: `(tenant_id, id)`. Ninguna clave foránea permite vincular datos de distintos tenants.
  - **Filtrado en API e Historial (`E-05`):** La consulta `GET /api/v1/orders?customerId=...` filtra a nivel de base de datos por `tenant_id` y `customer_id`.
  - **Protección de privacidad (`BD-01`):** Si un cliente intenta consultar una cotización o un pedido perteneciente a otra tienda o cliente, la API responde intencionalmente `404 NOT_FOUND` en lugar de `403 FORBIDDEN` para no revelar la existencia del recurso.

---

### Pregunta 2: Motor de Precios Dinámico y Políticas Fiscales por País
> **¿Cómo implementa el motor de precios el cálculo de impuestos y políticas comerciales diferenciadas por país —como el IVA del 19% en Colombia frente al 15% en Ecuador, o los obsequios gravados (`TAXED`) frente a los exentos (`EXEMPT`)— asegurando que la moneda, la escala decimal y las tasas no queden quemadas en el código fuente?**

* **Referencia documental:**
  - `spec/constitution.md Art. P-07` (No country data in code)
  - `spec/SPEC.md §3 (BR-04, BR-05) y §4` (Money and rounding policy)
  - `spec/SPEC.md §11` (Golden Tests GT-03 y GT-04)
  - `spec/data-model.md §1` (Tablas `countries` y `currencies`)
* **Respuesta técnica documentada:**
  - **Dominio puro y desacoplado:** El motor `pricing.domain` funciona como una función matemática pura `price(cart, snapshot) -> breakdown`. No contiene valores ni tasas cableadas (*hard-coded*).
  - **Políticas como datos:** La escala decimal (COP: 0, USD/GTQ/PEN: 2), el modo de redondeo (`HALF_UP`) y la política fiscal de obsequios (`EXEMPT` o `TAXED`) residen en las tablas `countries` y `currencies`.
  - **Aritmética exacta:** Se prohíbe el uso de tipos de coma flotante (`float`/`double`), utilizando exclusivamente la clase de valor inmutable `Money` respaldada por `BigDecimal`.
  - **Puntos de redondeo explícitos:** El redondeo monetario se aplica únicamente por línea sobre la base gravable tras descuentos comerciales (`RP-2` y `RP-4`). Los totales de la orden nunca se re-redondean (`RP-5`), preservando la identidad contable: $\text{Total} = \sum \text{neto} + \sum \text{impuestos}$.

---

### Pregunta 3: Garantía de Cotización Sellada frente a Cambios en Catálogo
> **¿Cuál es el mecanismo técnico que garantiza que el total cotizado sea exactamente idéntico al total confirmado, impidiendo cualquier divergencia incluso si en el sistema se actualizan precios o se desactivan promociones entre el momento de la cotización y la confirmación?**

* **Referencia documental:**
  - `spec/constitution.md Art. P-02` (The quoted total is the confirmed total)
  - `spec/SPEC.md §0 (G-1), §6` (Quote equals confirmation)
  - `spec/data-model.md §4` (Quotes and orders)
  - `spec/SPEC.md §11` (Golden Test GT-06)
* **Respuesta técnica documentada:**
  - **Patrón de Cotización Sellada (*Sealed Quote*):** Al emitir una cotización (`POST /api/v1/quotes`), los precios unitarios, tasas y descuentos calculados se persisten en las tablas `quotes`, `quote_lines` y `quote_line_adjustments` de forma estrictamente inmutable (*insert-only*). No existe sentencia `UPDATE` para estas tablas.
  - **Ausencia de montos en la orden:** Al confirmar (`POST /api/v1/orders`), la tabla `orders` **no almacena ningún monto ni vuelve a ejecutar el motor de cálculo**. La orden guarda únicamente su número correlativo y una referencia foránea única `quote_id`.
  - **Renderizado determinista:** El desglose de la orden se lee directamente desde las líneas congeladas de la cotización. Aunque el catálogo modifique precios posteriormente, la orden confirmada refleja exactamente el total cotizado durante el tiempo de vida de la cotización (TTL de 15 minutos).

---

### Pregunta 4: Eliminación de "Pedidos Perdidos" y Confirmación Idempotente
> **¿Cómo resuelve la confirmación en `POST /orders` el defecto histórico donde un tendero recibía número de pedido pero este luego no aparecía en su historial, y de qué manera se asegura que las notificaciones externas (Push y ERP) no se pierdan ni se dupliquen?**

* **Referencia documental:**
  - `assignment/Prueba_Tecnica_Tech_Lead_1.pdf` (Parte A2: Confirmación del pedido)
  - `spec/constitution.md Art. P-03, P-04 y P-05`
  - `spec/SPEC.md §7.1, §7.2 (Invariante I-201), §7.4 (Outbox relay) y §7.6`
  - `spec/architecture.md §3.3 y §3.4`
* **Respuesta técnica documentada:**
  - **Invariante del 201 (`I-201`):** La causa raíz histórica era enviar la respuesta HTTP antes de confirmar la transacción en base de datos o leer desde réplicas desactualizadas. En el diseño actual, el cuerpo HTTP 201 solo se serializa **después del `COMMIT` exitoso** de una única transacción atómica ACID que adquiere bloqueos en orden determinista: clave de idempotencia $\rightarrow$ cotización (`FOR UPDATE`) $\rightarrow$ cuenta de crédito.
  - **Idempotencia estricta:** La cabecera `Idempotency-Key` evita duplicados y doble consumo de cupo ante reintentos de red o pulsaciones dobles (*double tap*), devolviendo de forma segura la misma respuesta con el encabezado `Idempotent-Replayed: true`.
  - **Transactional Outbox:** Las llamadas a sistemas externos (Push y ERP) nunca se realizan dentro de la transacción de la orden. Se insertan eventos en la tabla `outbox_events` de forma atómica con la orden. Un despachador en segundo plano (*Outbox Relay*) arrienda los eventos con `SKIP LOCKED` y los envía con reintentos exponenciales y deduplicación por `event_id`, garantizando entrega sin pérdidas ni duplicados aun con caídas del ERP.

---

### Pregunta 5: Desviación de Alcance y Prevención de Defectos en el Frontend
> **Dado que el enunciado original solicitaba únicamente una pantalla de resumen en front-end (con un límite máximo de 1 hora), ¿cuál es la diferencia real entre lo solicitado y lo desarrollado en el cliente web, y cómo se implementó la prevención de los tres defectos visuales exigidos (textos cortados, controles tapados e imágenes desalineadas)?**

* **Referencia documental:**
  - `assignment/Prueba_Tecnica_Tech_Lead_1.pdf` (Plus opcional · Front)
  - `spec/SPEC.md §1 (Deviation), §10 (Frontend) y §14.3` (Beyond the assignment)
  - `spec/TASKS.md (T-17, T-19)`
* **Respuesta técnica documentada:**
  - **Diferencia de alcance (*Scope Deviation*):** El enunciado planteaba una pantalla de resumen de pedido acotada a una hora. Por decisión de producto documentada, se desarrolló una aplicación Angular completa que cubre todo el ciclo de compra: catálogo interactivo (`/cart`), resumen de cotización (`/quotes/:quoteId`), confirmación (`/orders/:orderId`), historial (`/orders`) y selector de tiendas con internacionalización dinámica (ES/EN), registrando un tiempo total de 13.5 horas.
  - **Prevención a nivel de componentes (no por pantalla):**
    1. *Textos sin truncamiento:* Se implementó el componente `ui-text` con la regla CSS `overflow-wrap: anywhere` y sin puntos suspensivos (`text-overflow: ellipsis`), asegurando que nombres largos de productos o tiendas se ajusten verticalmente sin desbordar en pantallas de 375px y 768px (`AC-42`).
    2. *Controles siempre visibles:* Se implementó el componente `ui-action-bar` fijado al pie, respetando el área segura (`env(safe-area-inset-*)`) y elevándose automáticamente ante la apertura del teclado virtual mediante sincronización con `visualViewport` (`AC-43`).
    3. *Consistencia visual de imágenes:* Se implementó el componente `ui-product-image` gobernado por una relación de aspecto fija (`aspect-ratio: 1/1`) y `object-fit: contain`, garantizando uniformidad en el grid independientemente de las proporciones de la imagen original (`AC-44`).
