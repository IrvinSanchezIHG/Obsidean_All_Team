---
date: 2026-05-12
tags:
  - lfc
  - sfmc
  - translations
  - smartling
  - journey-builder
  - deployment-plan
  - monitoring
  - data-cloud
  - onboarding
  - meeting-notes
type: meeting-notes
related:
  - "[[LFC_20260511_Tier Translation Logic & Dynamic Content QA]]"
  - "[[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting]]"
  - "[[Translation Workflow]]"
  - "[[Deployment Plan]]"
created: 2026-08-11
status: Active
---

# LFC Training — Comprehensive Onboarding for Email Campaign Development and Deployment

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[LFC_20260512_Comprehensive Onboarding for Email Campaign Development and Deployment]]
> WHERE file.path != this.file.path
> ```

> [!info] Contexto
> Sesión de capacitación LFC del 12 de mayo de 2026, la más extensa hasta ahora. Continúa el build de la campaña **Next Day** (registro/booking/completion, revisado el día anterior) y cubre, en orden: (1) el flujo completo de envío a traducción vía Smartling con Alex, (2) una sesión práctica de armado de journey con Anu, (3) el Deployment Plan como documento de registro, (4) los checks post-activación (Golden Hour / End of Day), y (5–6) dos categorías de proyectos de alto riesgo — ad hoc complejos (caso real: Points Expiration) y proyectos de Data Cloud/Loyalty Cloud — con las reglas de seguridad que existen precisamente por incidentes reales que el equipo ya vivió.

## 1. Traducción — flujo completo de envío a Smartling

#smartling

### 1.1 Antes de enviar: preparar el email aprobado

Nunca se envía a traducción el email "de trabajo". El flujo es: una vez que el email en inglés (USEN) está aprobado, se **duplica** dentro de una subcarpeta dedicada (ej. `Smartlink test`) creada específicamente para ese envío a traducción. Se conserva siempre el original aprobado sin tocar — si algo se traduce mal o Smartling regresa AMPscript traducido por error, hay que poder volver al estado previo sin reconstruir el email desde cero.

### 1.2 Convención de naming: guion bajo en vez de decimal

SFMC no permite decimales en nombres de contenido, así que el equipo sustituye el punto decimal por un guion bajo. Para campañas con múltiples variantes (ej. **Next Day**, que se dividió en Campaign A–F, cada una con oferta de 10K y 20K puntos), el Content ID de subject/preheader sigue un patrón como `1_1A1_1` — el prefijo identifica campaña y variante aunque ese detalle no le importe al equipo de traducción; le importa a LFC cuando la traducción regresa, para saber exactamente dónde va cada texto.

> [!tip] Por qué se envían todas las variantes juntas
> Aunque solo una campaña esté lista, conviene mandar a traducir **todas las variantes a la vez** (A a F) — para cuando se llega a la campaña C es fácil olvidar que ya se había enviado algo parecido, y eso retrasa el proceso.

### 1.3 Enviar el job en Smartling

1. Login en Smartling → **Request Type**: Content Building Email (o el tipo de bloque correspondiente).
2. Elegir la carpeta que refleja la ruta real en Salesforce (ej. `Always On > Next Day > Campaign A > Registration`).
3. Nombrar el job con el nombre real del email.
4. Seleccionar idiomas — la lista de opciones de Smartling **no es 1 a 1 con los region language codes de SFMC**; hay que traducir mentalmente entre ambos sistemas:
   - "Global English" (UK) en Smartling cubre `CAEN`, `GCEN` (Australia) y `EUEN` (Inglaterra) al mismo tiempo.
   - `CAFR` / `EUFR` = francés canadiense y francés europeo — se seleccionan por separado.
   - `EUDE` = alemán, `AMJP` = japonés.
   - Para español: Smartling ofrece una opción **"International Spanish"** que cubre `MSUS` + `EUS` (español americano y europeo) en un solo paquete — no confundir con `ESES` (castellano), que es una opción aparte y solo se agrega si la campaña la requiere.
   - **Siempre verificar contra el List Pull** qué idiomas aplican antes de seleccionar — no toda campaña usa los ~28 disponibles.
5. Guardar el job, indicar fecha de entrega (normalmente según el **work-back schedule**; "Rush" solo si aplica, pero el equipo LFC no está autorizado a aprobar rush directamente) y copiar el link generado — ese link se necesita para el siguiente paso.

### 1.4 Formulario de localización (Initiative Dashboard)

Después del job de Smartling, se llena un formulario separado (vive en el **Initiative Dashboard**, que centraliza todos los links relevantes del proceso):

| Campo | Qué va ahí |
|---|---|
| Project name | Sigue una cadencia fija: fecha de despliegue + MRM ID |
| Asset name | Nombre del proyecto/email (si son varios emails, separados por coma) |
| Requester / Content creator | El correo del desarrollador |
| Team | "Email Team" |
| Smartling link | El URL del job creado en el paso anterior |
| Urgency | High/Critical solo si es turnaround rápido (días); Medium si faltan semanas |
| Word count | Se copia directo del conteo que dio Smartling |
| Documents | PDF del email aprobado + documento de contenido dinámico + alt text/property tags (ver 1.5) |

> [!tip] Un solo documento, no varios
> El equipo aprendió (por corrección posterior de su propio localization team) que es mejor **consolidar todo en un solo documento** (con pestañas si hace falta) en vez de mandar archivos sueltos — mismo criterio que ya se usa para el subject/preheader: si algo necesita traducirse, se agrupa en un solo lugar para que el traductor no tenga que adivinar cómo conectar piezas sueltas.

### 1.5 Qué traduce Smartling y qué NO

- **Smartling SÍ traduce**: todo el contenido estático del template (body copy, legal copy, alt text, property tags) y cualquier texto que se le entregue explícitamente en el documento de contenido dinámico.
- **Smartling NUNCA toca el AMPscript** — ni la lógica de la sección dinámica del email. Esto es intencional: si el traductor tocara el código, el AMPscript se rompería. Por eso cualquier palabra que viva **dentro de una declaración de variable AMPscript** (ej. "night"/"nights", nombres de tier) no se traduce automáticamente — hay que **extraerla y enviarla por separado** como parte del documento de contenido dinámico, y luego, cuando regresa traducida, pegarla manualmente en la lógica de `Lookup`/condicional correspondiente.
- El texto del **unsub block / footer** ya está traducido a todos los idiomas desde hace tiempo — nunca se vuelve a tocar ni se reenvía a traducción salvo que cambie el copy legal en sí.

### 1.6 Aplicar las traducciones cuando regresan

Cuando el localization team termina, llega un correo con el documento traducido adjunto (reorganizado, pero con toda la información pedida) — una fila por idioma/región, con el **region language code** como identificador de fila.

Pasos al recibirlo:
1. **Cambiar el region language code placeholder** en cada versión del email — Smartling genera automáticamente una copia del email por idioma en cuanto se envía el job, pero todas nacen marcadas como `USEN` hasta que alguien las actualiza manualmente al código real (ej. `GCCH` para China). Este atributo es el que controla, vía AMPscript, qué logo de header, qué tier bar y qué unsub block se renderizan — si no se actualiza, el AMPscript nunca jala el idioma correcto aunque el copy ya esté traducido.
2. **Revisar, no asumir que está correcto** — la traducción puede regresar "un poco rara"; siempre se revisa antes de dar por bueno un idioma.
3. Pegar el subject/preheader traducido directamente en la Data Extension/content area correspondiente.
4. Para las palabras dinámicas (las que viven en AMPscript): reemplazar manualmente cada palabra en inglés por su traducción dentro del bloque `Lookup`/condicional — se puede optar por hacerlo vía Data Extension (agregando una fila más a la DE de traducciones) o directamente hardcodeado en el AMPscript; cualquiera de las dos formas es válida, es preferencia del desarrollador, pero si se hace vía DE hay que acordarse de agregar el `Lookup` correspondiente en el código.

### 1.7 Proofing con el region language code correcto

> [!warning] El error más común no es de código
> Si se hace un live proof usando un registro de la DE que tiene el region language code equivocado (ej. seleccionar por accidente un contacto USEN cuando se quería probar chino), el proof va a mostrar el idioma incorrecto **aunque el AMPscript esté perfecto**. Es fácil interpretar esto como un bug de código cuando en realidad es solo un registro mal elegido. Siempre confirmar el region language code del registro de prueba antes de sacar conclusiones.

Relacionado: [[Translation Workflow]] · [[Smartling]] · [[Subject & Preheader Localization]]

---

## 2. Journey Builder — sesión práctica (hands-on con Oscar)

#journey-builder

Sesión guiada por Anu, usando el email Nurture (USEN) que Oscar ya había construido, para armar un journey de prueba desde cero.

### 2.1 Business Unit: Commercial vs. Transactional

En la esquina superior derecha de Journey Builder hay un selector de Business Unit. El equipo LFC normalmente solo tiene acceso a **IHG Commercial**. Existe una segunda BU, **Transactional**, administrada por el equipo de Krishna — sus assets y propiedades **no se comparten** con Commercial. Si en el futuro llega una solicitud de email transaccional (ej. confirmación de reservación), el primer paso no es construir el email — es pedir acceso a esa BU por separado, vía el MIC o Kamaria.

### 2.2 Estructura de carpetas

- **Journeys**: `Life Cycle > [año] > [tipo de campaña] > [subcarpeta por trimestre]` — ej. `2026 > Nurture > Nurture Q2Q3`, la más reciente. Ad hoc, en cambio, no organiza tanto por subcarpeta — casi todo vive suelto en su carpeta raíz.
- **Data Extensions**: estructura distinta, mantenida por el equipo de datos (Ronic): `Shared Data Actions > Customer 360° Segments > IHG One R LFC > Final DS > LFC Q2 Nurture 2026`. Dentro de ahí vive la **internal test list / seed list** (en este caso, 52 registros) — reservada solo para revisión interna antes de activar un journey real, distinta de las DEs de predicción que sí contienen datos reales de clientes.

### 2.3 Datos de prueba: nunca editar la DE real

> [!warning] Regla no negociable
> No se edita directamente la Data Extension que entrega el equipo de datos — cualquier confusión ahí genera ida y vuelta innecesaria con Ronic. En vez de eso, se usa una consulta SQL sencilla para armar datos de prueba seguros: se toma **un registro real al azar por idioma/región** (para conservar todos los campos y combinaciones reales), y se **sobrescribe solo el subscriber key y el email address** con una dirección de prueba (ej. `oscar@gmail.com`). Así, aunque algo salga mal, nunca se le envía un correo a un cliente real por accidente.

El equipo GALE usa una dirección compartida (`gailihgqa@gmail.com`) para segregar fácilmente los correos de prueba de distintos proyectos en una sola bandeja. Si no existe un Gmail de prueba específico para IHG, hay que crear uno.

### 2.4 Decision splits: Mailing Date e idioma

1. **Mailing Date = Today** (no una fecha fija hardcodeada) — mismo checkpoint ya visto en sesiones anteriores, para evitar enviar con datos desactualizados si la automatización de refresh no corrió a tiempo.
2. **Primer split de idioma — lógica negativa**: por limitación de Journey Builder para armar muchos splits de golpe, primero se separa "no inglés" del resto usando una condición de **exclusión con AND** (no OR): `region_language <> USEN AND <> CAEN AND <> EUEN AND <> MSEN AND <> AMEN AND <> GCEN`. Quien cumple *todas* esas condiciones (es decir, no es ninguno de los códigos en inglés) cae en la rama "S"; el resto cae en la rama "No" (inglés). Es lógica negativa — fácil de confundir con OR si no se piensa dos veces.
3. **Segundo split, dentro de la rama de inglés**: separa **American English** (`USEN` OR `MSEN`) de **Global English** (`CAEN` OR `EUEN` OR `AMEN` OR `GCEN`) — aquí sí se usa OR, porque se está probando pertenencia a un grupo, no exclusión de todos.

> [!note] Por qué solo se construyó un idioma
> En esta sesión Oscar solo tenía el email en American English construido, así que los splits de idiomas regionales adicionales (uno por idioma traducido) se dejaron sin configurar — el patrón es el mismo que el split de inglés, solo replicado por cada idioma con asset propio.

### 2.5 Conexión de datos y el gotcha de "is not null"

Se conecta el journey vía **Contact Data** (no la DE compartida cruda) porque garantiza datos frescos y sin duplicados, y luego se hace scroll hasta **Standard Segmentation**.

> [!warning] "Is null" vs. "is not null"
> Al configurar el filtro de entrada, escribir `SubscriberKey is null` **excluye por accidente al 90% de los registros válidos** — el filtro correcto es `SubscriberKey is not null`, para incluir solo a quienes sí tienen un subscriber key real dentro de esa segmentación. Es un error fácil de cometer porque suena parecido, pero invierte completamente la lógica del journey.

### 2.6 Configuración del journey

- **Reentry**: "No re-entry" para un journey de prueba o de envío único; "Allow re-entry" para touch-points recurrentes — depende del tipo de campaña.
- **High-throughput sending**: solo se activa para campañas con volumen alto (≥ ~500K contactos); para campañas de cientos o miles de contactos por día, no se necesita.
- **Exit criteria**: se configura siempre, sin excepción.
- **Naming de journeys de prueba**: usar un prefijo/sufijo claro como `test_Oscar_delete`, para que quede evidente que ese journey debe borrarse después y no quede como basura en la carpeta compartida.

### 2.7 Validate & Test

1. Click en **Validate**, luego **Test**.
2. Seleccionar un par de registros al azar de la DE de prueba.
3. En **Send Type**, elegir **"Send only tested messages"**.
4. Usar la dirección de Gmail de prueba del equipo (ver 2.3) como destinatario.
5. Revisar el correo recibido.

### 2.8 Checklist final antes de activar

- [ ] Todos los decision splits probados con registros de distintos idiomas.
- [ ] Journey settings (reentry, exit criteria, throughput) configurados según el tipo de campaña.
- [ ] Data Extension de origen es la de prueba/seed list — nunca la real, para este paso.
- [ ] Revisar (click) **todos los links del email de prueba excepto el de unsubscribe** — confirmar que cada URL resuelve antes de pasar a producción.

> [!note] Caso real visto en vivo durante la sesión
> El seed list que se iba a usar tenía el Content ID desactualizado (mostraba `6` en vez de `7`) y el mailing date seguía marcando la semana anterior, **a pesar de que Ronic había confirmado que ya estaba refrescado**. Lección: verificar la frescura de la DE directamente en la data, no solo confiar en una confirmación verbal — para efectos de la prueba, se ajustó manualmente el mailing date del seed list de prueba a "hoy" (nunca se haría esto sobre una DE de producción).

Relacionado: [[Journey Builder]] · [[Data Layer]] · [[QA Process]]

---

## 3. Deployment Plan

### 3.1 Qué es y dónde vive

El Deployment Plan es un documento único por proyecto, alojado en **SharePoint**, que centraliza **toda** la información de un journey/campaña de principio a fin — el registro de referencia al que se puede volver incluso sin acceso a Marketing Cloud (ej. si alguien pregunta "¿cuál es el schedule de este journey?" y el desarrollador está fuera de la oficina). Los deployment plans históricos de 2025–2026 viven archivados en una carpeta maestra.

### 3.2 Estructura del documento

| Sección | Contenido | Nota |
|---|---|---|
| Revision history | Quién cambió qué y cuándo (ej. creado 27-marzo, se agregó reminder el 6-abril, luego registro A2/A7 el mismo día) | Se actualiza cada vez que hay un cambio, por pequeño que sea |
| Journey purpose | Resumen en lenguaje simple de qué trata el journey, + link al **CRF** | Deliberadamente **no** se duplica el List Pull ni otros documentos de soporte — el CRF ya indexa todo eso y lo usan QA, dev, platform y monitoring; duplicarlo generaría desincronización |
| Data Extension details | Nombre de la DE, ruta del data action, conteos observados al activar | **No** incluye la query/automatización que arma esa DE, salvo que el desarrollador LFC la haya construido él mismo (caso excepcional, ver 3.4) — normalmente esa documentación la mantiene el equipo de datos por separado, para evitar duplicar trabajo |
| Journey (por email/touch-point) | Capturas de pantalla, business unit, nombre y carpeta del journey, schedule (único o recurrente), exit criteria, decision splits con capturas, journey settings | Se repite por cada touch-point del proyecto |

### 3.3 Cuándo se construye: nunca en paralelo al build

> [!warning] Documentar al final, no mientras se construye
> A diferencia de otras empresas donde se documenta en paralelo al desarrollo, en LFC/IHG **se documenta hasta que el build y el QA están 100% terminados**. La razón: los emails de LFC cambian tanto durante el desarrollo que documentar en paralelo genera reescritura constante y termina desincronizando el documento con lo que realmente se construyó. El Deployment Plan también pasa por su propio QA antes de usarse en el walkthrough con marketing managers.

Secuencia completa: **Build → QA (email + journey) → Deployment Plan (construido y QA'd) → walkthrough con Marketing Managers (incluye validación en vivo en la misma llamada) → activación del journey.**

### 3.4 Caso de excepción: proyecto Milestone Rewards (2025)

En ese proyecto, el desarrollador construyó él mismo la query/automatización (porque el equipo de datos no estaba manteniendo esa tabla de vouchers en particular) — por eso, y solo por eso, el Deployment Plan se desvió de la plantilla estándar para incluir documentación completa de la automatización y cada query. El documento resultante creció a **305 páginas**, activo desde el 8 de septiembre hasta el 4 de marzo de 2026 — el ejemplo que ilustra por qué mantener un solo documento con historial de revisiones importa tanto en proyectos que se extienden por meses.

Relacionado: [[Deployment Plan]] · [[CRF]] · [[QA Process]]

---

## 4. Post-activación: Golden Hour Check y End of Day Check

Los conceptos generales de **Golden Hour Check** y **End of Day Check** ya están documentados en [[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting]]; esta sesión agregó el detalle operativo de cómo se ejecutan y se comunican en la práctica.

- **Cómo se revisa**: Interactions → Triggered Emails → buscar el nombre del journey → seleccionar la versión activa → revisar conteos de cola, completados y errores. Si aparecen registros en el bucket de error, hay que trabajar en resolverlos **de inmediato** para evitar un problema de despliegue mayor.
- **Comunicación con el equipo de Bangalore**: cuando la cola de envío sigue corriendo más allá del horario laboral de quien activó el journey, el handoff se hace **respondiendo en el mismo hilo de correo** (nunca mandando un correo nuevo, para no generar confusión con distintos subject lines). Ese hilo incluye al equipo de Bangalore, a la project manager de Bangalore (Mita) y al miembro de platform team (Sumanth) — el equipo de Bangalore entra ~2 horas después de que el equipo en EE. UU. termina su día, hace el End of Day Check, y responde en ese mismo hilo con los hallazgos.
- **Sin cobertura offshore**: si no hay equipo en India disponible (feriado, o un equipo más nuevo sin esa cobertura todavía), el fallback simple es hacer el End of Day Check uno mismo a primera hora del día siguiente.
- **Recordatorio compartido**: el equipo usa un "hot sheet" en el chat de Teams que lista los checks pendientes — útil cuando un desarrollador tiene varias campañas corriendo al mismo tiempo y es fácil que se le olvide uno.

Relacionado: [[Monitoring]] · [[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting]]

---

## 5. Proyectos ad hoc complejos — caso real: Points Expiration

#ad-hoc

### 5.1 Qué es

Tres comunicaciones automáticas que avisan a un miembro que sus puntos están por expirar: **día 7, día 30 y día 60** antes de la fecha de expiración (cada una es un recordatorio independiente con distinto lead time hacia la misma fecha).

### 5.2 El problema de clasificación (ya corregido)

Históricamente, día 7 y día 30 estaban clasificados como **commercial** (sujetos a honrar el opt-out/unsubscribe por ley CAN-SPAM), mientras que día 60 era **transactional** (se debe enviar sin importar el estado de suscripción). Resultado: cualquier miembro que se hubiera dado de baja de correos promocionales **nunca recibía los avisos de día 7 y 30**, solo el de día 60 — generando reclamos y hasta demandas cuando sus puntos expiraban "sin aviso".

**Corrección aplicada la semana previa a esta sesión** (trabajando con Ronic/equipo de datos): los tres correos se reclasificaron a **transactional**, para que se envíen sin importar el estado de opt-out.

> [!note] Por qué esto es legal
> Un correo transaccional (notificación de cuenta, no promocional) está exento de la obligación de honrar el opt-out bajo CAN-SPAM — por eso puntos-por-expirar puede clasificarse así, a diferencia de una oferta comercial.

Aun con la corrección, siguen llegando reclamos por razones legítimas no relacionadas con el envío: el correo cayó en la carpeta de promociones/spam, el buzón estaba lleno, hubo un bounce, o simplemente el miembro no lo abrió.

### 5.3 Cómo investigar un reclamo

El equipo legal/CS pasa el caso con **member ID y/o email** (no con subscriber key) a los marketing managers → Kamaria → el desarrollador. Dos formas de investigar:

| Método | Cuándo usarlo | Detalle clave |
|---|---|---|
| **Contact Builder** (All Contacts → filtro canal = Email → buscar por email) | Preferido — el más simple, y da una captura de pantalla de la UI fácil de compartir con el equipo legal | Solo cubre ~1 año de historial |
| **Query Studio** (SQL query guardada, documentada en la sección de notas del deployment doc) | Cuando se necesita más detalle o el registro es más viejo | **Gotcha crítico**: el lookback period por default es de solo 60 días — hay que cambiarlo a 365 días o la query dirá falsamente "no se envió ningún correo" |

Antes de cualquier conclusión, siempre revisar primero **All Subscribers** para confirmar si el contacto está opted-in u opted-out (indicador en rojo = opted-out) — aunque, con la reclasificación a transactional, esto ya no bloquea el envío, sigue siendo información útil de contexto.

Para historial más allá de lo que cubre Marketing Cloud (Contact Builder ~1 año, Query Studio ~6 meses), hay que escalar directamente a Prasad/Ronic — Marketing Cloud no es el sistema de registro de largo plazo para ese dato.

### 5.4 Reglas de seguridad — por qué existen

> [!danger] Nunca pausar un journey o automatización "solo para ver"
> Si se pausa una automatización o journey para inspeccionar su configuración y se olvida reactivarla, los clientes futuros **dejan de recibir el correo silenciosamente** — a veces sin que nadie lo note por días. Ya ha pasado, con otros clientes del equipo. En vez de pausar: usar **Ctrl+F** para buscar la actividad por nombre dentro del canvas de la automatización sin abrirla/editarla, o abrir la actividad de SQL Query solo para **ver** la query sin tocar "Guardar"/"Done".

> [!danger] Nunca editar una Data Extension conectada a Contact Builder
> Si una DE es parte de una relación de datos de Contact Builder (ejemplo real visto en la sesión: una DE de **auto-suppression**), **no se debe editar nada ahí directamente** — ni siquiera un campo que parezca inofensivo. Tocarla puede romper la relación silenciosamente, y **todos los journeys conectados a esa relación de Contact Builder dejan de enviar correos**, sin un error obvio que lo señale.

Relacionado: [[QA Process]] · [[Data Layer]]

---

## 6. Proyectos de Data Cloud / Loyalty Cloud

#data-cloud

### 6.1 Por qué son distintos

Ciertos disparadores (ej. un miembro sube de tier: club → silver → gold → platinum → diamond) se originan como objetos creados en **Salesforce Data Cloud**, que después se sincronizan hacia Marketing Cloud para disparar journeys de educación/nurture sobre el nuevo nivel. El equipo de Data Cloud tiene ancho de banda limitado y cualquier cambio ahí requiere un ciclo de release completo — reducir un delay de sincronización, por ejemplo, puede tardar **meses** en resolverse del lado de Data Cloud. Por eso, del lado de Marketing Cloud hay que diseñar **alrededor** del delay, no esperar a que se corrija en el origen.

### 6.2 Buena práctica #1 — Mock setup antes de activar

Antes de activar cualquier journey disparado por Data Cloud para envíos reales, se deja correr la automatización **1–2 semanas generando conteos de audiencia sin enviar ningún correo real**, comparando esos conteos contra los de Data Cloud (o, si no se tiene acceso directo a Data Cloud, contra el área de **Synchronized Data Extensions** en Marketing Cloud, que espeja los feeds relevantes) — para validar que la lógica de selección de audiencia está capturando a la gente correcta antes de comprometerse a un envío en vivo.

### 6.3 Buena práctica #2 — Ampliar el lookback period (caso real: voucher cancellation)

Ejemplo real documentado en la sesión: una automatización que notifica cancelación de vouchers corría cada hora, con una query SQL que originalmente solo miraba hacia atrás **1 hora** (para calzar con la frecuencia de la automatización). Como la sincronización Data Cloud → Marketing Cloud tenía un delay impredecible, algunas cancelaciones no llegaban a tiempo para ser capturadas en su propia hora — esos miembros simplemente no recibían el correo.

**Fix**: la automatización siguió corriendo cada hora, pero el lookback period de la query SQL se amplió a **3 horas (180 minutos)** — así, aunque un registro se pierda en su propia corrida, la siguiente corrida (dentro de esas 3 horas) lo vuelve a capturar.

> [!tip] Frecuencia de la automatización ≠ ventana de lookback de la query
> Son dos configuraciones independientes. Ampliar el lookback (de 1 a 2–3 horas, según el proyecto) absorbe el delay de sincronización sin necesidad de cambiar qué tan seguido corre la automatización.

### 6.4 Buena práctica #3 — Siempre diseñar una rama para valores null

Ciertos campos que vienen de Data Cloud (ejemplo real: `offer opt in`) **no reciben un valor Y/N inmediatamente** cuando se crea el registro, por el mismo delay de sincronización. Un journey antiguo del equipo solo manejaba el caso "Y" (enviar) sin ninguna rama explícita para null — cualquiera cuyo valor no se hubiera propagado a tiempo caía en una rama sin manejar y **nunca recibía el correo en absoluto** (no solo tarde: nunca).

**Fix implementado**: se agregó un decision split explícito para valores null, con los contactos esperando en un **wait step de 4 horas**, tras el cual se vuelve a checar el campo; si sigue null, esperan **otras 4 horas** y se checa de nuevo — porque el delay real observado para que un cambio de tier se propague puede llegar hasta **8 horas**. En un batch real mostrado en la sesión, la mayoría de los registros que originalmente habrían caído en "sin correo" se recuperaron hacia la rama correcta después de las dos rondas de espera; solo un puñado quedó sin resolver.

> [!note] Lección general
> Cualquier proyecto que toque datos de Data Cloud/Loyalty Cloud debe tratarse como inherentemente más lento y riesgoso de construir bien que un proyecto LFC o ad hoc estándar (que jala datos ya frescos y listos desde Ronic/Prasad). Siempre presupuestar tiempo para una fase de validación tipo mock-run, y esperar descubrir casos límite de forma empírica, no de antemano.

Relacionado: [[Data Layer]] · [[Journey Builder]]

---

## Relacionado

[[LFC_20260511_Tier Translation Logic & Dynamic Content QA]]
[[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting]]
[[Translation Workflow]]
[[Smartling]]
[[Journey Builder]]
[[Deployment Plan]]
[[Monitoring]]
[[QA Process]]
[[Data Layer]]
