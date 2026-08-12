---
aliases:
  - "LFC Developer Onboarding Guide"
  - "Manual LFC"
  - "LFC Developer Onboarding"
  - "LFC Onboarding Guide"
tags:
  - lfc
  - sfmc
  - onboarding
  - developer-guide
  - journey-builder
  - ampscript
  - email
  - push
  - data-extensions
  - tracking
  - reporting
  - qa
  - test-cases
  - data-cloud
  - gcp
related:
  - "[[LFC_20260508_Lifecycle Email Build & Journey Setup]]"
created: 2026-08-07
status: Active
---

# Manual de Onboarding para Desarrolladores LFC

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[LFC_20260507_Lifecycle Email Development & Data Integration]]
> WHERE file.path != this.file.path
> ```

### Guía de referencia paso a paso para construir Email, Push y Journeys en Salesforce Marketing Cloud

#lfc #sfmc #onboarding #developer-guide

**Propósito del manual:** ofrecer una referencia práctica y reutilizable para que un nuevo Sr. Developer entienda cómo se construyen las campañas [[LFC]] de principio a fin, y pueda usar este documento como guía de trabajo para construir un [[Email|email]], un [[Push Notification|push]] y el [[Journey Builder|journey]] que los orquesta.

Este manual no documenta campaña por campaña. En su lugar, extrae el modelo operativo común, los pasos de construcción, los patrones reutilizables y los puntos críticos de decisión que se repiten en todo el trabajo LFC.

> [!info] Fuentes de este manual
> Este documento cubre la guía de onboarding original (La agencia) más los aprendizajes de la sesión de training del 7 de mayo de 2026 (naming, estructura de carpetas, flujo de datos GCP → Data Cloud → Automation Studio, tracking/tagging/reporting, tipos de prueba), donde participaron los equipos de Email Dev, Data/Segmentación y Analytics/Reporting.
>
> El build práctico de un email con AMPscript y la construcción detallada de un journey (decision splits, reentrada, Data Extensions de prueba) se cubrieron en la sesión siguiente — ver [[LFC_20260508_Lifecycle Email Build & Journey Setup]].

## Índice / Mapa de contenido

- [[#Paso 1 Entender cómo se organiza el trabajo LFC|Paso 1 · Organización del trabajo]]
- [[#Paso 2 Ubicar dónde vive cada cosa (estructura de carpetas)|Paso 2 · Estructura de carpetas]]
- [[#Paso 3 Aplicar la convención de nombres|Paso 3 · Convención de nombres]]
- [[#Paso 4 Confirmar que la campaña está lista para construir (Definition of Ready)|Paso 4 · Definition of Ready]]
- [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]]
- [[#Paso 6 Construir un Push Notification desde cero|Paso 6 · Build de Push]]
- [[#Paso 7 Construir el Journey desde cero|Paso 7 · Build de Journey]]
- [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8 · Data Extensions y el flujo de datos]]
- [[#Paso 9 Ejecutar el proceso de traducción y localización|Paso 9 · Localización]]
- [[#Paso 10 Reconocer los patrones reutilizables|Paso 10 · Patrones reutilizables]]
- [[#Paso 11 Diagnosticar las fallas más comunes|Paso 11 · Troubleshooting]]
- [[#Paso 12 Verificar con los checklists finales|Paso 12 · Checklists]]
- [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13 · Tracking y reporting]]
- [[#Paso 14 Diferenciar Internal Test y QA Test|Paso 14 · Internal Test vs. QA Test]]
- [[#Paso 15 Aplicar la metodología de Test Cases|Paso 15 · Metodología de Test Cases]]
- [[#Paso 16 Aprender de los incidentes institucionales|Paso 16 · Troubleshooting a gran escala]]
- [[#Paso 18 Consultar los recursos y documentación de referencia|Paso 18 · Documentación de referencia]]

> [!tip] El build práctico
> El ejemplo real de AMPscript (Paso 17 en la versión original) vive en [[LFC_20260508_Lifecycle Email Build & Journey Setup]], junto con el resto del build práctico de esa sesión.

---

## Paso 1: Entender cómo se organiza el trabajo LFC

#lfc #modelo-operativo #onboarding

Antes de construir nada, hay que entender que el trabajo LFC conecta **cuatro capas**: requisitos, datos, contenido y orquestación. Un build solo es exitoso cuando estas cuatro capas coinciden.

| Capa | Dueño | Qué entrega | Qué debe confirmar el Developer |
|---|---|---|---|
| Planeación de campaña | [[Campaign Manager]] / stakeholders | CRF, brief, timing, canal, mercado, objetivo | Entender qué se envía, a quién y cuándo |
| Creatividad | Creative / fuente Figma | Layout aprobado, contenido, expectativas de contenido dinámico | Saber qué secciones son estáticas vs. dinámicas y qué variables se necesitan |
| Audiencia / datos | [[Data Team]] | Lógica de list pull, DEs por stage, campos requeridos | Validar que todos los campos usados en el asset existan en la [[Data Extension|DE]] |
| Orquestación | Developer | Asset de email, asset de push, configuración del journey, evidencia de QA | Asegurar que el build final alinee stage, DE, asset, idioma y timing de lanzamiento |

**Regla clave:** SFMC no es el lugar donde se inventa la estrategia de audiencia. La segmentación ya debe venir reflejada en la DE que entrega el [[Data Team]]. El rol del developer es construir assets confiables y conectar la fuente correcta con el asset y canal correctos.

Relacionado: [[#Paso 4 Confirmar que la campaña está lista para construir (Definition of Ready)|Paso 4 · Definition of Ready]] · [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8 · Data Extensions]]

---

## Paso 2: Ubicar dónde vive cada cosa (estructura de carpetas)

#estructura-carpetas #content-builder #journey-builder

Emails, pushes, journeys, automations y Data Extensions **no viven en un solo lugar**. Antes de empezar cualquier build, hay que saber en qué dashboard buscar.

### 2.1 Carpetas de Content Builder (Email y Push)
- La estructura sigue la lógica de categorías El Grupo Commercial: categoría → región → año → mes → carpeta de campaña.
- El material antiguo puede estar en carpetas de archivo como `zArchive`.
- **Validaciones al iniciar un build:** confirmar la categoría de campaña, ubicar la carpeta de año/mes correcta, determinar si se crea contenido nuevo o se duplica una versión aprobada anterior, y verificar si existe una carpeta separada para [[Smartling]]/traducciones.

### 2.2 Carpetas de Journey
- Los journeys viven en [[Journey Builder]], generalmente bajo `My Journeys > Lifecycle`, organizados por año y campaña.
- Encontrar el email en Content Builder no significa que sabrás dónde está el journey de producción — son estructuras distintas.

### 2.3 Automations y Data Extensions
- Las automations viven en el dashboard de Automation, no en las carpetas de Journey Builder.
- Las [[Data Extension|Data Extensions]] se gestionan principalmente en `Contact Builder > Data Extensions`.
- La audiencia fuente de un journey debe verificarse en Contact Builder / Shared DEs, **nunca asumirse** a partir del asset.

### 2.4 Patrón Live / Dev / Archive dentro de cada carpeta de campaña

#naming-convention #buenas-practicas

Una práctica que se ha vuelto estándar (confirmada en el training del 7 de mayo) es mantener, dentro de cada carpeta de campaña, tres subcarpetas:

| Subcarpeta | Contiene | Regla |
|---|---|---|
| **Live** | Las versiones actualmente en producción/mercado | Nunca se edita directamente aquí |
| **Dev** | Cualquier trabajo en progreso sobre esa campaña | Aquí se hacen todas las ediciones activas |
| **Archive** | Versiones retiradas | Al mover un asset aquí, se le renombra agregando `Archive` + la fecha en que se archivó (formato `AAAAMMDD`) |

Cuando una versión nueva está lista para ir a producción, la versión anterior de **Live** se mueve a **Archive** (con su fecha) y la nueva versión ocupa su lugar en **Live**.

### 2.5 Carpetas de trabajo vs. carpeta final de Data Extensions

#data-extensions #automation-studio

No todas las Data Extensions relacionadas con una campaña tienen el mismo nivel de "verdad". Dentro del flujo de [[Automation Studio]] existen al menos dos tipos de carpeta:

- **Carpeta de trabajo ("Working")** — contiene las DEs intermedias del proceso de armado de audiencia: staging, contact history intermedio, etc. **Nunca se conecta un journey directamente a estas DEs.**
- **Carpeta "Final DE"** — para Life Cycle, **todas** las Data Extensions finales que sí se conectan al [[Entry Source]] de un journey viven exclusivamente en esta carpeta. Si una DE de Life Cycle no está en la carpeta "Final DE", no debe usarse como entry source de producción.

Las activaciones que vienen de [[Data Cloud]] se publican primero en una carpeta de **Customer 360** dentro de Marketing Cloud; desde ahí, Automation Studio las procesa (ver [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8]]) hasta dejarlas en la carpeta Final DE.

| Artefacto | Ubicación principal | Por qué importa en build/QA |
|---|---|---|
| Email asset | [[Content Builder]] | Aquí validas layout, AMPscript, bloques, subject/preheader y links |
| Push asset | Content Builder / selección [[MobilePush]] en el journey | Aquí validas contenido del mensaje, comportamiento al abrir y personalización |
| Journey | Journey Builder > My Journeys > Lifecycle | Aquí configuras el [[Entry Source]] y el send activity |
| Data Extension (trabajo) | Contact Builder / carpeta Working | DEs intermedias — nunca como entry source de producción |
| Data Extension (final) | Contact Builder / carpeta **Final DE** | Aquí verificas fuente de audiencia, campos requeridos, registros de prueba y alineación de stage |
| Automation | Automation dashboard | Relevante cuando la población del journey depende de una automation |

Relacionado: [[#Paso 7 Construir el Journey desde cero|Paso 7 · Build de Journey]] · [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8 · Data Extensions]] · [[#Paso 9 Ejecutar el proceso de traducción y localización|Paso 9 · Localización]]

---

## Paso 3: Aplicar la convención de nombres

#naming-convention #trazabilidad

El naming no es cosmético: es el mecanismo principal de auditabilidad entre assets, DEs y journeys. Un nombre inconsistente puede llevar a seleccionar el asset o la DE equivocada durante el journey setup o el QA — y, como se detalla en el [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13]], también rompe el reporting.

**Patrón reutilizable:**
- Email y Push: `Región_Categoría_Campaña_Identificador_Versión_Idioma`
- Data Extensions: normalmente anteponen el idioma o contexto regional antes del identificador de campaña, siguiendo el mismo patrón que el email.
- El nombre de campaña **no debe contener guiones bajos**; si necesitas un separador dentro del nombre, usa guiones medios o camelCase, porque los guiones bajos pertenecen al framework de naming (separan región, categoría, campaña, etc.), no al nombre en sí.

> [!note] Actualización — training del 7 de mayo de 2026
> - **Ya no se usa el número de MRM** como identificador de campaña. Se reemplazó por el **número de Smartsheet**.
> - El formato preferido para el nombre de campaña es **camelCase** (sin espacios, sin guiones bajos, sin guiones medios): cada palabra empieza con mayúscula. No es una regla estricta — lo único realmente innegociable es **no usar espacios**.
> - Para las versiones, no es obligatorio usar `A1`, `A2`, `A3`. Si un nombre descriptivo aporta claridad (por ejemplo `Member` / `NonMember` en vez de `A1` / `A2`), se prefiere el nombre descriptivo.
> - El **formato de fecha recomendado** para folders y archivo es `AAAAMMDD` (año-mes-día), porque mantiene el orden cronológico correcto al listar carpetas.
> - Las Data Extensions deben seguir el mismo patrón de naming que el email/push asociado — evita que alguien tenga que adivinar a qué campaña pertenece una DE.

| Elemento | Fuente de verdad | Uso del Developer |
|---|---|---|
| Región / Business Unit | CRF / Figma / reunión de campaña | Naming y validación de idioma/mercado |
| Categoría | [[Campaign Manager]] | Confirma familia de campaña y ubicación de carpeta |
| Nombre de campaña | CRF / brief / Figma | Nombres de archivo y trazabilidad (camelCase, sin espacios) |
| Identificador (Smartsheet) | CRF / Smartsheet | Identificación única de campaña |
| Versión | Developer, puede ser descriptiva | Rastrear revisiones y evitar lanzar una versión desactualizada |
| Idioma / mercado | CRF / requisitos de campaña | Naming, assets traducidos y lógica de DE |

Relacionado: [[#Paso 2 Ubicar dónde vive cada cosa (estructura de carpetas)|Paso 2 · Estructura de carpetas]] · [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13 · Tracking y reporting]]

---

## Paso 4: Confirmar que la campaña está lista para construir (Definition of Ready)

#definition-of-ready #requirements #crf

No debe iniciarse un build solo porque alguien lo pidió en un chat. Una campaña LFC está lista solo cuando se conocen: stage, canal, DE de entrada, requisitos del asset, variables dinámicas y timing de lanzamiento.

| Input | ¿Obligatorio? | Se usa para | Pregunta a responder antes de construir |
|---|---|---|---|
| CRF / brief | Sí | Requisitos, IDs, mercados, timing, canal | ¿Qué se lanza, en qué canal y para qué mercados? |
| Figma / creatividad aprobada | Sí | Layout, copy, contenido dinámico | ¿Qué módulos son estáticos y cuáles requieren personalización? |
| Comms Plan / List Pull | Sí | Audiencia y definición de stage | ¿Para qué stage es este asset y qué DE lo alimenta? |
| DE específica del stage | Sí | Fuente de entrada del asset/journey | ¿Todos los campos usados por el asset existen en la DE? |
| Asset de email o push aprobado | Sí (según canal) | Selección del send activity | ¿Se construye nuevo o se reutiliza/actualiza una versión aprobada? |
| URL Matrix / links finales | Cuando existen links | Destino del CTA y tracking | ¿Todas las URLs son finales y correctas por mercado? |
| Registros de prueba internos | Sí (para QA) | Proofs y pruebas en dispositivo | ¿Puedes validar el render con data realista? |
| Traducciones | Si es multilingüe | Build localizado y contenido de DE | ¿Qué idiomas se requieren y para cuándo? |

Relacionado: [[#Paso 1 Entender cómo se organiza el trabajo LFC|Paso 1 · Organización del trabajo]] · [[#Paso 9 Ejecutar el proceso de traducción y localización|Paso 9 · Localización]]

---

## Paso 5: Construir un Email desde cero

#email #ampscript #qa #content-builder

El build de email no es solo ensamblar HTML: es una combinación controlada de diseño, bloques de contenido reutilizables, declaración de variables [[AMPscript]], lógica condicional, personalización, proofing y alineación con la DE fuente. Piensa en el email en tres capas: plantilla visual, capa de lógica dinámica y contrato de datos (los campos que la DE debe proveer).

### 5.1 Localizar el asset o plantilla inicial
Confirma si la campaña usa una plantilla viva existente, una versión anterior o un asset nuevo. Antes de editar, identifica si el asset localizado es una plantilla de producción/viva que solo debe duplicarse, no editarse directamente — especialmente si la documentación indica que existe solo como preview/referencia.

### 5.2 Entender los requisitos dinámicos específicos de la campaña
Compara Figma contra los requisitos de la DE para determinar qué debe ser dinámico. Clasifica cada elemento personalizado en uno de estos cuatro tipos:

| Tipo de elemento dinámico | Descripción | Ejemplo de tarea |
|---|---|---|
| Campo directo de DE | El valor se imprime tal cual tras declararse | Tomar el first name de la DE e imprimirlo en el hero o subject |
| Variable derivada | El valor se ensambla o transforma con lógica | Construir una fecha futura o mensaje de reward con IF/CONCAT |
| Valor de content block | Un bloque reutilizable calcula o devuelve un valor | Referenciar un bloque compartido de formato de fecha o lógica de preheader |
| Valor dirigido por traducción | El valor viene de una DE de traducción / fuente localizada | Renderizar copy traducido según el código de región/idioma |

### 5.3 Declarar las variables en AMPscript
La capa de declaración [[AMPscript]], normalmente al inicio del email, es donde el email empieza a ser funcional. La regla principal es la consistencia: los nombres de variable usados en el email deben coincidir con la lógica usada después en subject, preheader, body y tracking.

En esta etapa, verifica explícitamente que **toda variable referenciada más adelante exista o se cree**. Si el diseño espera tier actual, siguiente tier, valor de reward, código de idioma, fecha de expiración o first name, cada uno debe venir directamente de la DE, crearse con un `SET` de AMPscript, o devolverse desde un content block/snippet compartido.

**Nunca asumas** que una variable ya está declarada en otro lugar solo porque imprimió correctamente en una campaña anterior. Inspecciona si la variable es local al email, heredada de un content block, o esperada desde la DE.

### 5.4 Construir la lógica de subject line y preheader
En muchos emails LFC, el subject y el preheader no son etiquetas estáticas: se ensamblan dinámicamente según el stage de la campaña, el status del tier, el tipo de reward o el formato de fecha. El flujo es: crear las variables auxiliares → escribir la lógica IF/ELSE que decide qué strings usar → asignar los valores resultantes a las variables de salida.

Un patrón recurrente es usar un campo [[ContentID]] o selector similar para decidir qué par subject/preheader aplica. Otro patrón recurrente es usar content blocks de formato de fecha para que la fecha se muestre correctamente por idioma/mercado.

| Qué validar en Subject/Preheader | Por qué importa |
|---|---|
| Existencia de la variable | Si falta, el output puede salir en blanco o romper la lógica |
| Casos condicionales | Distintos tiers, statuses o estados de campaña pueden requerir texto distinto |
| Comportamiento por idioma | Fechas formateadas o frases traducidas pueden cambiar por mercado |
| Valor de fallback/default | Si la data no coincide con ningún caso esperado, el email sigue teniendo un output válido |
| Espaciado y concatenación | Piezas dinámicas mal concatenadas pueden generar gramática rota (ej. singular/plural: "1 night" vs "5 nights") |

### 5.5 Poblar el body del email con contenido dinámico
Una vez declaradas las variables y listo el subject/preheader, implementa el body. Los cuerpos de email LFC suelen mostrar párrafos, mensajes de reward o visibilidad de componentes distintos según las variables ya creadas. Usar el editor HTML suele ser más seguro que el editor visual al agregar AMPscript, porque reduce el riesgo de alterar el formato de diseño o eliminar elementos ocultos del sistema.

**Orden recomendado de revisión de módulos del body:** hero/headline → lógica de reward u oferta → componentes de milestone o tier → CTA y URLs → footer/legal → regiones de impresión/tracking. Este orden sigue la misma secuencia en la que suelen detectarse los errores durante QA (ver también la metodología formal de [[#Paso 15 Aplicar la metodología de Test Cases|Test Cases]]).

### 5.6 Elegir entre `v()`, `ProperCase()` y `TreatAsContent()`

| Función | Úsala cuando... | Riesgo principal si se usa mal |
|---|---|---|
| `v()` | La variable ya contiene el valor final a mostrar | No transformará contenido ni renderizará lógica HTML |
| `ProperCase()` | El texto fuente necesita normalización de formato (ej. nombre, tier) | Puede producir un output extraño si el string no debía reformatearse |
| `TreatAsContent()` | La variable o bloque contiene markup renderizable o código dinámico | Usarla innecesariamente puede dificultar el debug o renderizar contenido no deseado |

### 5.7 Manejar módulos especiales y regiones de impresión
Algunas campañas agregan módulos condicionales visibles solo para segmentos específicos (mensajes por mercado, escenarios con/sin tarjeta). Además de crear la variable y condición para mostrar/ocultar el módulo, debes mantener cualquier región de impresión o lógica de tracking relacionada — una sección visible correctamente puede ocultar un tracking roto si se omitió el impression region o el identificador de campaña. Ver [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13]] para el detalle de cómo estas regiones alimentan el reporting.

### 5.8 Validar el contrato de datos contra la DE
Antes de enviar cualquier proof, compara el email contra la lista de campos de la [[Data Extension|DE]] fuente. La verificación debe ser literal: si el AMPscript referencia un campo o variable derivada de un campo, ese campo debe existir en la DE con el naming exacto y valores de muestra válidos. No basta con que exista un campo similar.

| Expectativa mínima de la DE para email | Razón |
|---|---|
| [[SubscriberKey]] | Requerido para identificación del contacto y comportamiento de envío |
| EmailAddress | Requerido para entrega del proof y envío de producción |
| Campo de idioma/mercado | Necesario cuando el contenido o los links varían por mercado |
| Todos los campos dinámicos usados en AMPscript | Requeridos para personalización de subject, preheader y body |
| Marcador de campaña o stage (recomendado) | Útil para QA, trazabilidad y troubleshooting |

### 5.9 Proofing y QA para email
El QA de email debe hacerse en capas: (1) validar que el asset renderiza técnicamente en preview, (2) probar con múltiples registros realistas para ejercitar la lógica condicional, (3) enviar proofs para confirmar render y comportamiento de links en un inbox real, (4) confirmar que se recibieron todas las aprobaciones de negocio.

> [!tip] Profundiza en esto
> El [[#Paso 14 Diferenciar Internal Test y QA Test|Paso 14]] explica los **cuatro tipos de prueba** del flujo LFC (Internal Test, QA Test, Live Proofing y Seed List) y cuál usar en cada momento, y el [[#Paso 15 Aplicar la metodología de Test Cases|Paso 15]] detalla cómo se construye formalmente la matriz de pruebas a partir del Figma. El ejemplo de AMPscript real que ilustra estos casos vive en [[LFC_20260508_Lifecycle Email Build & Journey Setup]].

| Chequeo de QA de email | Qué confirmar |
|---|---|
| Asset correcto | La versión duplicada/actualizada es la campaña e idioma correctos |
| Subject y preheader | Cada caso dinámico renderiza con gramática natural y data válida |
| Hero y módulos del body | Las secciones condicionales aparecen/se ocultan correctamente para el registro probado |
| Links | URLs de CTA, alias y tracking reflejan las URLs finales aprobadas |
| Footer y legal | Los bloques requeridos están presentes y no rotos por la personalización |
| Alt text | Cada imagen tiene un alt text validado, para accesibilidad y para cuando el cliente de correo bloquea imágenes |
| Proof recibido | El proof en inbox coincide con lo esperado y fue aprobado antes de producción |

Relacionado: [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8 · Data Extensions]] · [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13 · Tracking y reporting]] · [[#Paso 14 Diferenciar Internal Test y QA Test|Paso 14 · Internal Test vs. QA Test]] · [[#Paso 15 Aplicar la metodología de Test Cases|Paso 15 · Test Cases]]

---

## Paso 6: Construir un Push Notification desde cero

#push #mobilepush #qa

El push es más simple visualmente que el email, pero más frágil operativamente porque la entrega exitosa no puede confirmarse solo con un preview. Tiene tres capas esenciales: contenido del asset, disponibilidad del contacto/dispositivo ([[SubscriberKey]] + [[MemberID]]/elegibilidad de app) y configuración del comportamiento al abrir.

### 6.1 Confirmar el asset de push y el stage
El push debe mapear al stage correcto de lifecycle (TR1, TR2, TB1, TB2). No asumas que un push con nombre similar al email es automáticamente el correcto — verifica stage, idioma y requisitos de comportamiento explícitamente.

### 6.2 Validar los campos de entrega en la DE
La DE de push debe contener SubscriberKey y, para pruebas prácticas y muchos escenarios de entrega, MemberID o el identificador de app esperado por el setup de [[MobilePush]]. Si el contacto no puede resolverse a un perfil de dispositivo/app, el push puede estar completamente configurado y nunca llegar. Esta es la diferencia conceptual más grande frente al email.

| Requisito de DE para push | Por qué importa |
|---|---|
| SubscriberKey | Identificador central usado para resolver el contacto objetivo |
| MemberID/identificador de app | Necesario para mapear usuarios de prueba y soportar entrega real en dispositivo |
| Campos de contenido dinámico | Requeridos cuando el body o la lógica de link usan personalización |
| Campo de idioma/región | Requerido cuando links o copy cambian por mercado |
| Registros de tester confiables | Sin destinatarios de prueba confiables, el QA de push se vuelve poco confiable |

### 6.3 Configurar la actividad de push
Configura la actividad MobilePush en [[Journey Builder]]. Valida: el asset correcto está seleccionado, el comportamiento al abrir es correcto (ir a URL web, abrir app, u otro comportamiento aprobado), y existe la lógica de link/tracking requerida. Un comportamiento de apertura incorrecto es uno de los errores ocultos más dañinos: un push puede verse perfecto en texto y aun así enviar al usuario al destino equivocado.

### 6.4 Ejecutar la prueba en dispositivo real (obligatoria)
Usa uno o más testers internos con login de app confiable, opt-in de push y disponibilidad del dispositivo. Si el push no se recibe, no asumas inmediatamente que el journey está roto: primero revisa la cuenta del tester, el mapeo de MemberID, el estatus de login de la app, la configuración de notificaciones del dispositivo, y si otro tester confiable sí recibe el push. En otras palabras: **primero descarta problemas de contacto/dispositivo antes de declarar rota la lógica del journey.**

| Chequeo de QA de push | Qué validar |
|---|---|
| Asset seleccionado | El push elegido pertenece a la campaña/stage/idioma correctos |
| Campos disponibles | Todos los valores dinámicos usados por el push existen en la DE |
| Entrega ocurrida | La notificación llegó realmente al dispositivo |
| Renderizado | El texto del mensaje aparece como se esperaba |
| Destino del tap | El destino de app o URL es correcto tras tocar la notificación |
| Tracking/lógica adicional | El PushJobID o lógica de tracking de link funciona correctamente |

Relacionado: [[#Paso 7 Construir el Journey desde cero|Paso 7 · Build de Journey]] · [[#Paso 11 Diagnosticar las fallas más comunes|Paso 11 · Troubleshooting]]

---

## Paso 7: Construir el Journey desde cero

#journey #journey-builder #activacion #entry-source

El journey es donde ocurre la orquestación final, pero debe seguir siendo la capa más simple del build. El journey conecta una DE específica de stage con la actividad de canal correcta. Para LFC, el estándar recomendado es **no reconstruir la lógica de audiencia en Journey Builder** cuando el [[Data Team]] ya entregó la DE correcta del stage.

### 7.1 Confirmar el modelo operativo del journey
Los journeys LFC están basados en stages. En lugar de construir un árbol de lógica gigante para decidir si un usuario está en TR1, TR2, TB1 o TB2, cada stage debería entrar normalmente a través de la DE apropiada. Si existen stages separados, deben existir fuentes de entrada separadas también.

### 7.2 Configurar el Entry Source
La primera decisión crítica al construir el journey es la DE de [[Entry Source]] — es la selección más importante de todo el journey porque determina quién entra. Antes de continuar, verifica: nombre de la DE, stage de lifecycle, expectativas de idioma/mercado, existencia de campos requeridos, y si estás usando una DE de prueba o de producción. **Recuerda que para Life Cycle, la única DE válida como entry source de producción es la que vive en la carpeta "Final DE"** (ver [[#Paso 2 Ubicar dónde vive cada cosa (estructura de carpetas)|Paso 2.5]]). Muchos errores de lanzamiento ocurren no porque el path esté roto, sino porque quedó seleccionada la DE fuente equivocada.

### 7.3 Agregar la actividad de canal correcta
Después del Entry Source, agrega el send activity correspondiente: Email Activity para el build de email, MobilePush Activity para el de push. Luego selecciona el asset aprobado que pertenece al mismo stage y mercado de campaña. Un error de alineación muy común: entra una DE de TR1 pero el email o push seleccionado pertenece a TR2 o a otro idioma.

### 7.4 Mantener el canvas simple
Mientras más simple el canvas del journey, más seguro el lanzamiento. El path recomendado en la mayoría del trabajo LFC es un modelo limpio de **Entry Source → Activity → Exit**, con wait steps solo si el brief de campaña lo requiere explícitamente. Los decision splits solo deben usarse cuando la campaña específicamente lo requiere — si la lógica de audiencia ya está embebida en la DE, agregar splits crea lógica duplicada, dificulta el QA y aumenta el riesgo de contradecir la intención del Data Team.

| Patrón de journey recomendado | Cuándo usarlo | Razón |
|---|---|---|
| Entry DE → Email → Exit | Un solo stage de email | Estructura más limpia para stage solo-email |
| Entry DE → Push → Exit | Un solo stage de push | Estructura más limpia para stage solo-push |
| Entry DE → Email → Push → Exit | La misma audiencia debe recibir ambos en secuencia | Útil solo cuando el plan de campaña lo confirma explícitamente |
| Journeys separados o stages claramente separados | Existen múltiples stages de lifecycle | Facilita el QA y troubleshooting a nivel de stage |

### 7.5 Validar antes de activar
La validación de Journey Builder solo confirma que la configuración es técnicamente aceptable para la plataforma — **no confirma** que seleccionaste la DE, el asset o el stage correctos. La validación previa a la activación debe combinar validación de plataforma con QA manual.

| Validación pre-activación | Qué confirma | Qué NO confirma |
|---|---|---|
| Validación de plataforma | Que el setup técnico es aceptable | No confirma que la lógica de campaña sea correcta |
| QA del developer | Que DE, asset, campos y links están alineados | No reemplaza la aprobación de negocio |
| Aprobación de stakeholders | Que el contenido/timing de negocio están aprobados | No reemplaza la revisión técnica |
| Pruebas internas | Que los registros de muestra se comportaron como se esperaba | No garantiza que todo registro de producción sea correcto |

### 7.6 Activar y monitorear post-envío
Activa solo después de verificar que están seleccionadas las DEs y assets de producción. Después de activar, monitorea el estatus del journey, los conteos de entrada, la ejecución de actividades, los recibos internos y el comportamiento de link/tap. Que el journey muestre actividad **no significa automáticamente** que se usó la audiencia o la lógica de stage correctas.

Relacionado: [[#Paso 2 Ubicar dónde vive cada cosa (estructura de carpetas)|Paso 2 · Estructura de carpetas]] · [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8 · Data Extensions]] · [[#Paso 11 Diagnosticar las fallas más comunes|Paso 11 · Troubleshooting]]

---

## Paso 8: Aplicar las reglas compartidas de Data Extensions

#data-extensions #subscriberkey #memberid #data-cloud #gcp #automation-studio

La [[Data Extension|DE]] no es solo una lista de contactos: es el **contrato entre el Data Team y el Developer**. Si un campo no existe en la DE, o la DE no corresponde al stage previsto, el build no está listo — sin importar qué tan completo se vea el asset visual.

### 8.1 De dónde viene realmente la audiencia: el flujo completo

Entender solo "la DE llega lista" no es suficiente para diagnosticar problemas de audiencia. El flujo real, según el training del 7 de mayo, tiene cuatro etapas:

1. **[[Google Cloud Platform|GCP]] (la fuente)** — aquí viven las tablas base: **Member Master** (datos del miembro: ID, fecha de inscripción, cumpleaños, etc.), **tablas transaccionales** (datos de estadía: noches, gasto, propiedades) y **Contact History** (a quién se le envió cada campaña, usado para métricas). Estas tablas se actualizan mediante *data streams* con refresco diario (con un rezago típico de 3-4 horas, no es tiempo real).
2. **[[Data Cloud]] (segmentación)** — antes se llamaba CDP. Aquí el Data Team crea **segmentos** (filtros por región, comportamiento, atributos) usando las tablas de GCP, apoyándose en *calculated insights* cuando se necesita información transaccional resumida (ej. noches acumuladas). El calculated insight corre primero (por la mañana), y la segmentación corre después, una vez que el insight terminó.
3. **Activación y publicación** — el segmento se convierte en una **activación**, que se publica en una carpeta de **Customer 360** dentro de Marketing Cloud. Es en la activación donde también se pueden agregar atributos/campos dinámicos adicionales que el email necesitará.
4. **[[Automation Studio]] (el lado SFMC)** — desde Customer 360, Automation Studio hace la "masajeada" final de datos vía SQL: pasa por una carpeta de **staging**, hace el **contact history append** (registra que se envió), y deja el resultado en la carpeta **Final DE** — la única que debe usarse como entry source de un journey de producción (ver [[#Paso 2 Ubicar dónde vive cada cosa (estructura de carpetas)|Paso 2.5]]).

> [!note] Dato operativo clave
> Para Life Cycle, las Data Extensions finales se sobrescriben todos los días (no se recrean) — el pipeline corre de forma automatizada y programada. Si necesitas una personalización o campo adicional que no está llegando, puede añadirse en la etapa de activación (Data Cloud) o directamente en Marketing Cloud — el equipo de Data Team suele preferir hacerlo en Marketing Cloud porque es más rápido y cercano a tiempo real.

### 8.2 Cadencia de comunicación con el Data Team

- **Cualquier List Pull debe estar actualizado con al menos dos semanas de anticipación** al lanzamiento. El Data Team construye la audiencia exactamente según lo que dice el list pull, no según lo que se haya discutido verbalmente — si el list pull no refleja un cambio de criterio de audiencia, el Data Team seguirá usando el criterio viejo.
- Cuando hay un cambio de criterio de audiencia, la práctica recomendada es: enviar un correo a todo el equipo notificando el cambio, y pedir una **confirmación explícita por correo** de que el list pull ya fue actualizado antes de asumir que se puede avanzar. Saltarse esta confirmación ha causado en el pasado que se envíe la campaña equivocada.
- Cualquier cambio en nombres de email/campaña debe compartirse con el equipo de Data/Analytics con la misma anticipación — ver [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13]].

### 8.3 Reglas compartidas por campo

| Campo/característica de DE | Email | Push | Impacto en el journey |
|---|---|---|---|
| SubscriberKey | Requerido | Requerido | Identificador central para orquestación de envío |
| EmailAddress | Requerido | Opcional (útil para pruebas) | Necesario para proofs de entrega y verificación de contacto |
| MemberID o identificador de app | No requerido | Requerido/crítico | Necesario para pruebas reales de entrega de push |
| Código de idioma/mercado | Requerido si hay lógica localizada | Requerido si hay lógica localizada | Ayuda a asegurar la alineación entre asset y DE |
| Campos dinámicos | Requeridos si el asset usa personalización | Requeridos si el push usa personalización | Campos faltantes causan fallas de render o valores en blanco |
| Marcadores de stage/campaña | Recomendado | Recomendado | Útil para auditoría, troubleshooting y handoff |

Relacionado: [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]] · [[#Paso 6 Construir un Push Notification desde cero|Paso 6 · Build de Push]] · [[#Paso 7 Construir el Journey desde cero|Paso 7 · Build de Journey]] · [[#Paso 16 Aprender de los incidentes institucionales|Paso 16 · Troubleshooting a gran escala]]

---

## Paso 9: Ejecutar el proceso de traducción y localización

#localization #smartling #translations

Para campañas multilingües, la traducción es un workstream estructurado, no un extra opcional. El proceso típico es:

1. Crear una carpeta de [[Smartling]] en el área de la campaña.
2. Duplicar el asset fuente en esa carpeta.
3. Solicitar la traducción en Smartling.
4. Completar el formulario de solicitud de localización.
5. Recibir el contenido traducido.
6. Crear o poblar la DE de traducción.
7. Referenciar ese contenido localizado vía AMPscript en la plantilla del email.

**Dos lecciones clave:** primero, los assets traducidos pueden requerir actualizar explícitamente las propiedades de idioma/región del email, no solo el contenido. Segundo, la localización agrega otra capa de dependencia porque parte del contenido ya no está embebido directamente en el email, sino que se obtiene de filas de DE listas para traducción o de content blocks localizados — por lo que el QA debe incluir validación a nivel de idioma, no solo en inglés.

| Paso de localización | Responsabilidad del developer |
|---|---|
| Crear carpeta Smartling y duplicar asset | Preservar el naming y mantener el duplicado alineado a la fuente aprobada |
| Solicitar traducción | Elegir el asset correcto y los idiomas requeridos según la campaña |
| Completar formulario de solicitud | Proveer IDs, fecha límite, contexto de conteo de palabras y adjuntos |
| Recibir contenido traducido | Validar si el output vivirá en content blocks, duplicados de asset o DEs de traducción |
| Implementar contenido traducido | Renderizar valores traducidos vía AMPscript y actualizar propiedades de idioma donde corresponda |
| QA localizado | Validar render traducido, links y alineación de idioma/mercado |

Relacionado: [[#Paso 3 Aplicar la convención de nombres|Paso 3 · Convención de nombres]] · [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]]

---

## Paso 10: Reconocer los patrones reutilizables

#patrones-reutilizables #ampscript

Aunque familias de campaña como nurture, nearly, newly o milestone tienen objetivos de negocio distintos, los patrones técnicos se repiten. Reconocerlos acorta drásticamente el tiempo de onboarding.

| Patrón reutilizable | Cómo suele aparecer |
|---|---|
| Sección de declaración AMPscript | Variables se setean al inicio del asset desde la DE o bloques auxiliares |
| Branching por [[ContentID]] o status | Subject/preheader/body cambian según stage, tier o status |
| Content blocks compartidos | Formato de fecha, footer, legal, lógica de preheader o variables auxiliares centralizadas |
| Recuperación de contenido localizado | Valores específicos de idioma se obtienen con lógica de región/idioma |
| Módulos condicionales del body | Secciones específicas se muestran solo para un segmento, tipo de reward, tier o mercado |
| Alineación por DE específica de stage | El asset se construye una vez pero se lanza según la fuente de audiencia de cada stage |
| Migración de estático a dinámico | Varios emails casi idénticos (ej. "1 año", "5 años", "10 años" de aniversario) se consolidan en un solo email dinámico controlado por impression regions — reduce mantenimiento pero exige avisar a Analytics del cambio de nombre (ver [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13]]) |

Relacionado: [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]] · [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13 · Tracking y reporting]]

---

## Paso 11: Diagnosticar las fallas más comunes

#troubleshooting #fallas-comunes #qa

| Problema | Causa probable | Primeras cosas a revisar |
|---|---|---|
| Personalización en blanco en el email | Campo faltante o naming distinto entre AMPscript y DE | Comparar cada variable referenciada con los nombres reales de campo y valores de muestra de la DE |
| Audiencia equivocada entró al journey | DE de Entry Source incorrecta o desalineación de stage | Reconfirmar nombre de DE, stage y handoff del Data Team; confirmar que la DE vive en la carpeta Final DE |
| Push no recibido | Mismatch de MemberID, problema de dispositivo/app, tester inválido o falla de mapeo de contacto | Probar con un dispositivo/usuario confiable y validar disponibilidad de la app |
| Destino de link equivocado | URL antigua, comportamiento de apertura incorrecto, asset duplicado no actualizado del todo | Validar cada CTA y destino de tap contra la URL matrix final |
| El journey valida técnicamente pero sigue mal | Setup de plataforma correcto pero selecciones de negocio incorrectas | Revisar tipo de DE, versión de asset, alineación de stage y evidencia de aprobación |
| El journey de producción sigue usando la DE de prueba | Se olvidó el cambio final a la fuente de producción | Incluir la verificación de DE de producción en el checklist final de activación |
| Reportes muestran caída repentina en envíos que sí ocurrieron | Cambio de nombre de email/campaña no comunicado a Analytics | Ver [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13]]: confirmar si el nombre cambió y si se avisó con anticipación |
| Personalización rota en muchos emails de forma dispersa (no todos a la vez) | Posible cambio upstream en una fuente de datos ajena a SFMC | Ver [[#Paso 16 Aprender de los incidentes institucionales|Paso 16]] — no asumir que es un bug local de AMPscript |

Relacionado: [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]] · [[#Paso 6 Construir un Push Notification desde cero|Paso 6 · Build de Push]] · [[#Paso 7 Construir el Journey desde cero|Paso 7 · Build de Journey]] · [[#Paso 16 Aprender de los incidentes institucionales|Paso 16 · Troubleshooting a gran escala]]

---

## Paso 12: Verificar con los checklists finales

#checklist #qa

### 12.1 Checklist de build de Email
- [ ] Asset/plantilla base correcto identificado y duplicado si es necesario.
- [ ] Ubicación de carpeta y convención de nombres confirmadas (camelCase, sin espacios, formato de fecha AAAAMMDD).
- [ ] Todas las variables dinámicas requeridas declaradas.
- [ ] Lógica de subject y preheader construida y probada con registros realistas.
- [ ] Módulos del body actualizados con la lógica dinámica necesaria.
- [ ] Content blocks, footer, legal y regiones de impresión validados.
- [ ] Todos los campos requeridos de la DE confirmados contra la lógica del asset.
- [ ] Links, aliases y tracking validados (ver [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13]]).
- [ ] Alt text validado en todas las imágenes.
- [ ] Test Cases completados contra el Figma (ver [[#Paso 15 Aplicar la metodología de Test Cases|Paso 15]]).
- [ ] Internal Test enviado y aprobado; QA Test enviado y validado en la herramienta de tracking (ver [[#Paso 14 Diferenciar Internal Test y QA Test|Paso 14]]).
- [ ] Final production-ready asset version confirmada.
- [ ] Cambio de nombre (si aplica) comunicado a Analytics con al menos 2 semanas de anticipación.

### 12.2 Checklist de build de Push
- [ ] Asset de push correcto identificado para el stage previsto.
- [ ] SubscriberKey y MemberID/identificador de app confirmados en la DE de prueba.
- [ ] Comportamiento de apertura validado (app vs. web).
- [ ] Campos dinámicos confirmados y probados.
- [ ] Prueba en dispositivo real ejecutada con tester(s) internos confiables.
- [ ] Destino de tap y lógica de tracking revisados.
- [ ] Producción-ready asset confirmado antes de activar.

### 12.3 Checklist de build de Journey
- [ ] Carpeta correcta de Journey y convención de nombres confirmadas.
- [ ] Correcta DE de Entry Source (específica del stage) seleccionada, y confirmada que vive en la carpeta Final DE.
- [ ] Correcta actividad de Email o MobilePush seleccionada.
- [ ] Versión de asset e idioma correctos seleccionados.
- [ ] Sin decision splits innecesarios agregados.
- [ ] Wait steps alineados con requisitos explícitos de la campaña.
- [ ] Validación de plataforma completada exitosamente.
- [ ] QA manual completado (DE, asset, campos, stage, links, proof/prueba en dispositivo).
- [ ] DE de producción seleccionada, sin DE de prueba remanente.
- [ ] Evidencia de aprobación recibida antes de activar.
- [ ] List Pull confirmado con al menos 2 semanas de anticipación y confirmación por correo recibida del Data Team.

Relacionado: [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]] · [[#Paso 6 Construir un Push Notification desde cero|Paso 6 · Build de Push]] · [[#Paso 7 Construir el Journey desde cero|Paso 7 · Build de Journey]] · [[#Paso 14 Diferenciar Internal Test y QA Test|Paso 14 · Internal Test vs. QA Test]] · [[#Paso 15 Aplicar la metodología de Test Cases|Paso 15 · Test Cases]]

---

## Paso 13: Profundizar en tracking, tagging y reporting

#tracking #reporting #tagging #tableau

El naming y el tagging no son solo cuestión de organización — **alimentan directamente el reporting** que usan los equipos de Analytics y el negocio. Este paso conecta lo que ya viste en el [[#Paso 3 Aplicar la convención de nombres|Paso 3]] con el impacto real en los dashboards.

### 13.1 Tag Category y Tag Campaign
En las propiedades del email se configuran dos campos que se vuelven columnas directas del dashboard de Tableau:

| Campo en SFMC | Columna en el dashboard | Ejemplo |
|---|---|---|
| a-tag category | Category Name | `AWA` → Awareness, `B2B` → Business to Business, `CC` → Co-brand, `ES` → E-statement, `LFC` → Life Cycle |
| a-tag campaign | Campaign Name | El nombre de campaña tal cual se escribió en las propiedades del email |

Estos dos valores también se usan para construir la **URL tag** que permite rastrear visitas web/app, bookings y revenue generados desde el email.

### 13.2 Aliases: nombres amigables para cada link
Un **alias** reemplaza una URL larga por un nombre corto y descriptivo (ej. `header_logo`, `mod1_headline`, `mod2_cta`). Esto permite ver en el reporting **qué elemento** generó cada clic, en vez de una URL críptica.

- El **prefijo** del alias (todo antes del primer guion bajo, ej. `header`, `mod1`, `mod2`) se usa para agrupar el reporting por **módulo** del email.
- Si un elemento clickeable **no tiene alias**, aparecerá en el reporting como `null` u `other` — que es exactamente lo que se quiere evitar. **Todo elemento clickeable debe tener un alias.**

### 13.3 Impression Regions: cómo se reporta un email dinámico
Cuando un email es dinámico (por ejemplo, un email de aniversario que sirve para 1, 5, 10 o 20 años con el mismo asset), el reporting no puede diferenciar versiones solo con el ID del mailing — para eso existen los **impression region names**. Cada nombre de impression region identifica qué variante de contenido (ej. "10 year hero", "10 year body copy") se le mostró a cada contacto, y eso es lo que permite ver el performance **por versión**, no solo a nivel de mailing completo.

> [!warning] Impacto directo
> Si el impression region name no está bien configurado o no se envía como se espera, Analytics **no puede** desagregar el performance por versión — aunque el email técnicamente funcione bien.

### 13.4 Mapeo de fases de Life Cycle
El negocio mantiene una tabla de mapeo que asocia el **nombre del mailing** con la fase de Life Cycle a la que pertenece: **Educate, Engage, Nurture, Retain**. Este mapeo alimenta un dashboard de monitoreo que se envía diariamente al equipo de Life Cycle y de email — por eso, cuando se crea o renombra un mailing, hay que asegurarse de que ese mapeo se actualice también.

### 13.5 Por qué avisar con anticipación cuando cambian los nombres
Si el nombre de un email o de una campaña cambia (por ejemplo, al consolidar varios emails estáticos en uno dinámico, como pasó con el email de aniversario), y Analytics no se entera con anticipación, en el dashboard **la línea de tendencia de ese mailing cae a cero** — dando la falsa impresión de que se dejó de enviar la campaña, cuando en realidad solo cambió de nombre. La regla es la misma que para list pulls: **avisar con al menos 2 semanas de anticipación**.

### 13.6 Cómo se mide el desempeño
- Se prioriza el **UCTR (Unique Click-Through Rate)** sobre el open rate y sobre el click-through rate simple, porque el UCTR filtra clics repetidos de bots (un bot puede generar cientos de clics falsos; el UCTR solo cuenta si el contacto único hizo clic).
- El benchmark de comparación depende del tipo de campaña:
  - Si la campaña se repite (ej. una venta anual), se compara **año contra año** para la misma campaña.
  - Si no existe un histórico directo, se compara contra el **benchmark de la categoría** (ej. comparar un email de Life Cycle contra el promedio general de Life Cycle).
- Las pruebas de **Internal Test / QA Test** (ver [[#Paso 14 Diferenciar Internal Test y QA Test|Paso 14]]) deben excluirse del análisis de performance real — el QA Test se identifica y se filtra automáticamente gracias al texto `QA test` en el subject line.

Relacionado: [[#Paso 3 Aplicar la convención de nombres|Paso 3 · Convención de nombres]] · [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]] · [[#Paso 14 Diferenciar Internal Test y QA Test|Paso 14 · Internal Test vs. QA Test]]

---

## Paso 14: Diferenciar Internal Test y QA Test

#qa #testing #tracking

No todas las pruebas sirven para lo mismo. El flujo LFC completo tiene, en realidad, **cuatro tipos de prueba**, cada uno con un propósito distinto:

| | **Internal Test** (proof / seed) | **QA Test** | **Live Proofing** | **Seed List** |
|---|---|---|---|---|
| Qué es | El email final, enviado a un grupo pequeño de usuarios corporativos | Un **envío real** (deployment, no test) a un grupo pequeño de prueba | Preview del email directamente desde el journey, usando data real de clientes | Envío del email final a la lista de liderazgo, usando **datos dummy** provistos por el Data Team |
| Cómo se identifica | Texto `internal test` en el subject line | Texto `QA test` en el subject line | No aplica (es un preview, no un envío) | Texto `internal test` en el subject line (mismo prefijo que el Internal Test) |
| Propósito | Validar contenido/diseño antes del envío real | Validar que el tracking (aliases, impression regions) funciona con datos reales | Confirmar que un contacto calificado para cierto valor dinámico (ej. 5 noches) efectivamente lo recibe — comparación 1 a 1 entre lo que se previsualiza y el dato real del miembro | Que el liderazgo vea el contenido final antes del envío a producción |
| ¿Aparece en el reporting? | No | Sí, pero solo si se hace clic en los links | No aplica | No (usa datos dummy) |
| ¿Cuándo se hace en la secuencia? | 1º | En paralelo al Internal Test, antes de enviar a traducción | 2º (después de aprobado el Internal Test) | 3º y último, justo antes de producción |

### 14.1 El prefijo de subject line para pruebas
Todas las pruebas (excepto el Live Proofing, que no es un envío) llevan un **prefijo estandarizado** en el subject line, compuesto por: (1) qué ronda de proof es y si es cliente/interno, (2) el nombre del email (importante porque suele haber muchas campañas corriendo en paralelo), (3) el código de región/idioma, y (4) cualquier atributo dinámico relevante que ayude al equipo revisor a identificar qué variante está viendo.

### 14.2 Flujo del QA Test
1. Enviar el QA Test como un **envío real** ("Preview and Send", **no** "Preview and Test") a la lista de prueba, con `QA test` en el subject.
2. **Hacer clic en cada link** dentro del email recibido — si no se hace clic, no hay datos que revisar.
3. Al día siguiente (normalmente dentro de 24 horas, aunque a veces toma más), revisar en la herramienta interna de QA tracking que:
   - Cada alias aparece como el **nombre amigable** esperado (no como una URL completa ni como un alias genérico sin descripción).
   - El **impression region name** aparece poblado correctamente para cada elemento dinámico — si aparece como `null`, revisa la sintaxis de tu `Begin Impression Region` y el naming (ver el ejemplo de AMPscript en [[LFC_20260508_Lifecycle Email Build & Journey Setup]]).
4. Si algo no se ve como se esperaba, corregir y **enviar un nuevo QA Test**.
5. **Haz este paso antes de enviar a traducción**, no después — así evitas tener que repetir la validación en las 20+ versiones traducidas si algo estaba mal desde el email fuente.

Para que el QA Test funcione necesitas una DE mínima de una sola fila con tu propia dirección de correo (ver la sección de Data Extensions de prueba en [[LFC_20260508_Lifecycle Email Build & Journey Setup]]).

### 14.3 Live Proofing
El Live Proofing ocurre **desde el journey**, no desde Content Builder: se previsualiza el email usando la Data Extension real de producción, para confirmar que un contacto específico recibe exactamente el valor dinámico que le corresponde según su perfil real (ej. si un miembro Club califica para 5 noches de bono, el preview debe mostrar exactamente eso). Es la comprobación de que la lógica dinámica y la calificación real del miembro están perfectamente alineadas ("1 a 1").

### 14.4 Seed List
Una vez aprobado el Live Proofing, se envía el **Seed List**: el email va a una lista interna de liderazgo (provista por el Data Team), pero usando **datos dummy**, no los datos reales del Seed. La diferencia clave con el Internal Test es la audiencia (liderazgo específico) y que confirma que están viendo la versión más reciente y aprobada justo antes de ir a producción.

> [!tip] Por qué esto importa
> El **QA Test** es la **única forma disponible** dentro de Salesforce Marketing Cloud para validar que el tracking va a funcionar antes de que la campaña esté en vivo, y el **Live Proofing** es la única forma de confirmar que la calificación dinámica real del miembro coincide con lo que ve en el email. Saltarse cualquiera de los dos significa descubrir el problema después del lanzamiento.

Relacionado: [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]] · [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8 · Data Extensions]] · [[#Paso 13 Profundizar en tracking, tagging y reporting|Paso 13 · Tracking y reporting]] · [[#Paso 15 Aplicar la metodología de Test Cases|Paso 15 · Test Cases]]

---

## Paso 15: Aplicar la metodología de Test Cases

#qa #test-cases #figma

### 15.1 Por qué existen
Antes de esta metodología, todo lo que se probaba "detrás" de un proof era invisible para el negocio: el marketing manager solo veía el resultado final, sin saber qué combinaciones se habían validado. Los Test Cases existen para dar visibilidad de ese trabajo, permitir que el developer haga **self-QA** primero, y que un equipo de QA dé una validación exhaustiva antes de que el proof llegue al marketing manager — en vez de que el marketing manager tenga que revisar manualmente cientos de combinaciones posibles.

### 15.2 De dónde salen los Test Cases
El **Figma** es la fuente de verdad. Cada variante de subject line y preheader definida en el Figma se convierte en un conjunto de filas de test case. Por ejemplo, si el Figma define 7 variantes de subject line para una campaña, se generan test cases para cada una de esas 7 variantes.

### 15.3 Cómo se construye cada test case
Para cada campo de personalización presente en un subject/preheader/body (ej. first name, tier status, número de noches), se crean **escenarios con datos mock** que cubren los casos límite:

- Distintos valores posibles del campo (ej. tier = Silver, Platinum, Diamond).
- Formato del texto (ej. nombre en mayúsculas vs. minúsculas — ¿se normaliza correctamente con `ProperCase()`?).
- Singular vs. plural (ej. "1 night" vs. "5 nights" — un error clásico de concatenación).

Cada fila del test case registra: el escenario probado, el **resultado esperado**, el **resultado real obtenido**, y un status de **Pass** o **Fail**. Si falla, se corrige y se vuelve a probar antes de mandar el proof.

### 15.4 Contenido estático vs. dinámico
- Si un preheader o sección es **puramente estático** (sin variables), basta **un solo test case** de verificación.
- Si el contenido es **dinámico**, se necesitan **múltiples filas** — una por cada combinación relevante de variables que pueda darse en producción.

### 15.5 Validación del body y accesibilidad
Además de lo ya cubierto en el [[#Paso 5 Construir un Email desde cero|Paso 5.9]] (hero, módulos condicionales, CTAs, footer), los Test Cases agregan una validación explícita de **Alt Text**: cada imagen debe tener un texto alternativo validado, porque algunos clientes de correo (ej. Outlook) bloquean las imágenes por defecto y muestran el alt text en su lugar — esto es tanto un tema de accesibilidad como de experiencia de usuario cuando las imágenes no cargan.

### 15.6 Estructura resumida de un Test Case

| Send # | Elemento probado | Escenario (mock data) | Resultado esperado | Resultado real | Status |
|---|---|---|---|---|---|
| Send 1 | Subject line (first name + tier + noches) | first name="Tamara", tier="Silver", noches=1 | "Tamara, pre-regístrate — Silver — 1 night" | Coincide | Pass |
| Send 1 | Subject line | first name="OSCAR" (todo mayúsculas), tier="Platinum", noches=5 | "Oscar, pre-regístrate — Platinum — 5 nights" (ProperCase aplicado, plural correcto) | Coincide | Pass |
| Send 1 | Preheader (estático) | N/A | Texto fijo aprobado | Coincide | Pass |
| Send 2 | Imagen hero | N/A | Alt text describe la imagen correctamente | Coincide | Pass |

Relacionado: [[#Paso 5 Construir un Email desde cero|Paso 5 · Build de Email]] · [[#Paso 14 Diferenciar Internal Test y QA Test|Paso 14 · Internal Test vs. QA Test]] · [[#Paso 12 Verificar con los checklists finales|Paso 12 · Checklists]]

---

## Paso 16: Aprender de los incidentes institucionales

#troubleshooting #incident-management #data-cloud

Estos son patrones extraídos de incidentes reales compartidos en el training del 7 de mayo — útiles como referencia de troubleshooting a gran escala, más allá de un solo email o journey.

### 16.1 Cuando la personalización se rompe "en cascada" sin motivo aparente
En un caso real, muchos emails de Life Cycle empezaron a mostrar personalización rota (por ejemplo, el nombre saliendo como un valor genérico de error en vez del nombre real) — pero no todos a la vez, sino de forma dispersa a lo largo de varias semanas, lo que dificultó detectar el patrón.

**Causa raíz:** un cambio en un sistema de datos **upstream**, ajeno a Salesforce Marketing Cloud, que no fue comunicado al equipo de Data Team ni al equipo de email.

**Lección para troubleshooting:** si la personalización empieza a fallar en **múltiples emails no relacionados entre sí**, de forma dispersa en el tiempo, sospecha primero de un cambio upstream en la fuente de datos (ver el flujo completo en el [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8.1]]) antes de asumir que es un error de AMPscript local en cada email. La corrección en ese caso se hizo **por lotes** (unos cuantos emails corregidos por día) hasta cubrir todos los afectados.

### 16.2 Principio operativo: Life Cycle no se apaga
La política del equipo, incluso durante incidentes grandes, es **no detener por completo los envíos de Life Cycle**. En vez de eso, se corrige en producción de forma incremental (por lotes), priorizando mantener el programa activo mientras se resuelve el problema de fondo. Esto tiene una implicación directa para el developer: durante un incidente, la prioridad no es "apagar todo hasta arreglarlo", sino coordinar con el equipo qué lote de campañas se corrige primero y volver a correr QA sobre cada una antes de reactivarla.

### 16.3 Contexto de seguridad
Como resultado de un incidente de seguridad pasado relacionado con contraseñas débiles, las políticas de acceso a las bases de datos del equipo se volvieron considerablemente más estrictas (autenticación multifactor, requisitos de contraseña más largos y que cambian con frecuencia). No es un tema de AMPscript ni de builds, pero es contexto útil para entender por qué el acceso a ciertos sistemas puede sentirse más restrictivo que en otros entornos.

Relacionado: [[#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8 · Data Extensions y el flujo de datos]] · [[#Paso 11 Diagnosticar las fallas más comunes|Paso 11 · Troubleshooting]]

---

## Paso 18: Consultar los recursos y documentación de referencia

#documentation #sharepoint

Además de este manual, el equipo mantiene un ecosistema de documentos de referencia en SharePoint. Vale la pena conocer qué contiene cada uno para saber dónde buscar antes de preguntar.

| Documento | Qué contiene | Cuándo consultarlo |
|---|---|---|
| **Comms Plan** | El plan completo de comunicación de una campaña (en spreadsheet) | Para entender la secuencia completa de touch-points de una campaña multi-touch |
| **List Pull** | Criterios de audiencia, atributos, y fechas de vigencia | Antes de construir el journey — es la fuente de verdad para splits de idioma y fechas |
| **CRF** | Brief de campaña: naming, link/URL matrix, alt text, atributos dinámicos, impression regions | Durante todo el build de email — es la fuente de casi todos los valores de configuración |
| **Test Cases** | Matriz de pruebas derivada del Figma (ver [[#Paso 15 Aplicar la metodología de Test Cases|Paso 15]]) | Durante QA, antes de mandar el proof |
| **Deployment Plan** | Todo lo necesario para construir y lanzar el journey de una campaña específica | Antes de construir el journey |
| **Proofing Guide** | Proceso y estándares de proofing | Antes de la primera ronda de pruebas de una campaña nueva |
| **Lucid Charts** | Diagramas de flujo de datos, usados específicamente para campañas cuya audiencia viene de Data Cloud/Loyalty Cloud (no de CDP/List Pull) | Para visualizar el flujo de datos de una campaña específica |
| **LFC Journey and Email Database** | Un registro central que mapea cada journey con sus emails asociados, idiomas y la ruta de su Data Extension | Cuando necesitas ubicar rápidamente dónde vive el journey o la DE de una campaña ya existente |
| **Master Decks** | Un documento extenso por cada fase de Life Cycle (Educate, Engage, Nurture, Retain) con overview estratégico, user journey, overview de comunicaciones y el detalle de cada email | Para entender el contexto de negocio completo de una fase antes de trabajar en ella |
| **Feedback Tracker** | Documento donde el equipo de campaña registra retroalimentación sobre el rendering de los emails durante proofing | Durante la ronda de feedback con el marketing manager |
| **Blueprint / Auditoría de documentación** | Un audit que identifica qué documentación existe y cuál falta por campaña | Para saber si puedes confiar en que la documentación de una campaña específica está completa |

> [!note] Por qué importa esto para Obsidian
> Cada uno de estos documentos vive fuera de Obsidian (en SharePoint/Smartsheet), pero puedes crear una nota-índice en tu vault que enlace a cada uno por campaña — de forma que este manual siga siendo el punto de entrada, y desde aquí saltes directo al documento operativo correcto sin tener que recordar la estructura de carpetas de SharePoint.

Relacionado: [[#Paso 4 Confirmar que la campaña está lista para construir (Definition of Ready)|Paso 4 · Definition of Ready]] · [[#Paso 15 Aplicar la metodología de Test Cases|Paso 15 · Test Cases]]
