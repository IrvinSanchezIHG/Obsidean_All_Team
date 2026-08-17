---
aliases:
  - "Dynamic Attributes"
  - "Atributos Dinámicos"
  - "Variables Dinámicas"
tags:
  - dynamic-content
  - ampscript
  - personalization
  - data-extensions
created: 2026-08-13
status: Active
---

# Dynamic Attributes

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[23 - Dynamic Attributes]]
> WHERE file.path != this.file.path
> ```

> [!abstract]- Resumen
> Catálogo de los atributos/variables dinámicas concretas (`ContentID`, `first_name`, `Custom1Num`, `Custom1Str`, `Custom1Date`, `region_language_code`, `mobile_app`, `Custom1Trans`) usadas en un build real de email Nurture (booking reminder), con cita **precisa del momento de la grabación** donde cada una se declaró, se explicó o se depuró. Fuente: sesión de training *LFC Training — 2026-05-08* (build de email + journey setup), complementada por [[LFC_20260508_Lifecycle Email Build & Journey Setup]], que documenta el mismo build sin marcas de tiempo.

## Qué es un "dynamic attribute" en este contexto

Un campo o variable [[AMPscript]] cuyo valor cambia por contacto/registro, a diferencia del contenido estático de la plantilla. Tiene dos orígenes posibles:

- **Directo de la Data Extension** — se lee con corchetes `[Campo]` o `AttributeValue("Campo")` (ver [[LFC_20260508_Lifecycle Email Build & Journey Setup#8.1 Declarar las variables base desde la DE]]).
- **Derivado con lógica** — se calcula con `SET`/`IF` a partir de uno o más campos de la DE, o se obtiene de un content block compartido (ej. formato de fecha).

## Catálogo — atributos vistos en el build (Nurture booking reminder)

| Atributo | Controla | Origen | Gotcha principal |
|---|---|---|---|
| `ContentID` | Qué subject/preheader se arma (`B1`/`B2`/`B3`) | Directo de DE | Un mismo email sale varias veces con distinto `ContentID` |
| `first_name` | Nombre en subject/body | Directo de DE (excepto Japón) | El campo real es `first_name`, no `first name`; requiere `ProperCase()` |
| `Custom1Num` | Número de noches (5 o 10) | Directo de DE | Se traduce a palabra ("five"/"ten") para T&Cs |
| `Custom1Str` | Tier actual o siguiente | Directo de DE + `Lookup()` a DE maestra | Debe cubrir variantes crudas (`Silver`, `Silver Elite`, `SLVR`, etc.) |
| `Custom1Date` | Fecha mostrada en el body | Directo de DE + content block de formato | Requiere declarar el content block de fecha antes de usarla |
| `region_language_code` | Idioma/mercado — link helper, excepción de nombre JP, splits del journey | Directo de DE | No es lo mismo que la *propiedad* "language" del email (ambas existen, en capas distintas) |
| `mobile_app` | Visibilidad del módulo de descarga de app | Directo de DE | Lógica invertida: `false` = **mostrar** el módulo (no lo oculta) |
| `Custom1Trans` | Tier ya traducido al idioma del contacto | `Lookup()` contra la DE maestra `LiveTranslationTokens` | No se declara solo — depende de que `Custom1Str` ya esté seteado |

---

### `ContentID`

Determina qué variante de subject line/preheader se arma (ver también [[Content ID]] y [[Subject & Preheader Localization]]).

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **00:31:17–00:31:32** — "So if I were to build a subject line, I would set a variable, declare a variable..."
> - **00:32:03–00:32:16** — "...all the those dynamic stuff is calculated is pulled in from the content ID which is B1B2B3."
> - **00:32:16–00:32:44** — confirma contra el CRF que el atributo que dispara subject/preheader sigue siendo `content ID`.
> - **00:32:44–00:33:01** — declara `IF @ContentID == "B1" THEN...`.
> - **00:44:16–00:44:23** — "The content ID always remains for the content that is driving the different subject lines and pre headers."
> - **00:53:08–00:53:25** — mismo email enviado varias veces, cambia solo el `ContentID` ("they get the variables").

### `first_name`

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **00:33:54–00:34:14** — se declara junto con `ContentID` para el subject line.
> - **00:44:24–00:44:40** — excepción de Japón: "for Japanese emails, they don't use first name and instead the last name."
> - **00:44:58–00:45:39** — código de la excepción: `IF @region_language_code == "AMJP" THEN SET @first_name = [last_name] ENDIF`, colocado **antes** de armar subject/preheader.
> - **01:00:34–01:00:58** — se envuelve en `ProperCase()` por si la data llega en mayúsculas ("HOLA JUAN" → "Hola Juan").
> - **01:10:06–01:10:14** — corrección en vivo: "It's not first name, it's first_name in the data" (guion bajo, sin espacio).

### `Custom1Num` (número de noches)

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **00:34:27–00:34:46** — "...it's pulling different nights so members might get five nights or 10 nights."
> - **00:34:48–00:35:12** — declara la variable como "custom one NUM".
> - **00:35:14–00:35:45** — "we are using custom one NUM from the data which... will be pulling different nights 5 or 10... based on members value."
> - **00:39:21–00:39:35** — nota de traducción: el valor en **palabra** ("five"/"ten") no se traduce solo, hay que enviarlo aparte (ver [[06 - Translation Workflow|Translation Workflow]]).
> - **00:42:19–00:43:01** — declara `@NightsWord`: `IF @Custom1Num == 5 THEN "five" ELSE "ten"`, usado en términos y condiciones.
> - **00:53:59–00:54:15** — recordatorio de declararla antes de usarla en el body.
> - **01:18:24–01:18:53** — demo en vivo: explica por qué el test DE actual solo trae `5` (no hay registro con `10` cargado).

### `Custom1Str` (tier actual / siguiente)

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **00:37:11–00:37:19** — "we have a tier status which will pull in the members either current or the next year."
> - **00:37:29–00:37:44** — la traducción del tier sale del "master DE called translate translation DE" (ver `Custom1Trans` abajo).
> - **00:48:34–00:49:49** — enumera las variantes crudas a cubrir: Silver Elite/Silver/SLVR, Gold Elite/Gold, Platinum (3 variantes), Diamond (varias, incluye nombre anterior).
> - **01:17:15–01:17:31** — bug en vivo: "Amscript doesn't know what custom one string is because I never set the variable up here."
> - **01:17:47–01:18:09** — corrige el bug y confirma que ahora sí resuelve "Silver Elite"; cambia el registro de prueba y ve "Platinum Elite" actualizarse.
> - **03:31:11–03:35:14** — (sesión de la tarde, tras el almuerzo) Oscar retoma la pregunta sobre la DE de traducción de tier; se muestra la DE maestra `LiveTranslationTokens` con las ~20 traducciones disponibles — ver también [[06 - Translation Workflow]].

### `Custom1Date`

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **00:54:15–00:54:24** — "the dates always come from the data which is dynamic and we have to format it for each region language code."
> - **00:55:09–00:55:24** — se identifica como "the custom numbers for that e-mail" (fecha dinámica dentro del email).
> - **00:55:51–00:56:00** — confirma contra el list pull: el atributo es `custom 1 date`.
> - **00:56:07–00:56:22** — declara el content block de formato: `ContentBlockByKey("date-number-format-logic")` → variable `C1DateLong` (ver [[13 - Dynamic Date Block|Dynamic Date Block]]).
> - **01:16:00–01:16:11** — demo: la fecha se muestra como "Sunday, May 31st" jalada de la data.
> - **01:20:00–01:20:32** — reformatea a formato corto (mes/día/año, luego ajusta a `MMM`).
> - **01:23:42–01:24:17** — bug: una variable de formato duplicada impedía que la fecha se imprimiera; al quitarla, funciona.

### `region_language_code`

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **00:21:57–00:22:11** — controla el [[22 - Link Matrix (LinkHelper)|link helper]]: "if it was a global English page so it would go to Gben page... dynamic so you don't have to update in each translated languages."
> - **00:44:58–00:45:39** — dispara la excepción de nombre en Japón (ver `first_name`).
> - **01:19:06–01:19:25** — demo cambiando a francés: solo el tier se traduce porque la **propiedad** "language" del email (no el campo de la DE) sigue fija en `USEN` — distinción explícita entre ambas capas.
> - **03:44:42–03:48:44** — (sesión de journey con Alex) base de los decision splits de idioma: separar "no inglés" del resto, agrupar `USEN`+`MSEN`, y un split por cada idioma con asset propio (`AMJP`, `EUDE`, etc.).

### `mobile_app`

Controla el módulo condicional de descarga de app — ejemplo ya documentado en [[LFC_20260508_Lifecycle Email Build & Journey Setup#8.6 Módulo condicional con región de impresión]].

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **03:08:39–03:08:58** — aclara la lógica invertida: "When it says false we show them the module because false says they do not have the app."
> - **03:09:14–03:09:47** — declara la variable y agrega `Begin Impression Region Module3_AppDownload`.

### `Custom1Trans` / DE maestra `LiveTranslationTokens`

Ver nota dedicada: [[07 - Subject & Preheader Localization|Subject & Preheader Localization]] y [[06 - Translation Workflow|Translation Workflow]].

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **00:37:29–00:37:44** — primera mención, durante el build: "pulled in from the master DE called translate translation DE which has all the translations."
> - **00:38:35–00:38:52** — aclara que ya está incluida por default en el campaign configuration file, no hace falta pedir traducción de esos textos.
> - **00:39:35–00:40:09** — contraste importante: el contenido **dentro de una declaración AMPscript** (como los subject/preheader dinámicos) NO se traduce automático — debe entregarse aparte en spreadsheet.
> - **03:33:03–03:35:14** — demo directa de la DE: se confirma el nombre "live translation tokens", se muestra su contenido (ej. "IG rewards, credit card offers and promotion") y se confirma que cubre las ~20 traducciones/idiomas del programa.

---

## Reglas generales de declaración (aplican a todos los atributos de arriba)

### Override del campaign configuration file, no edición directa

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **00:50:00–00:50:05** — Oscar pregunta si el campaign configuration file también está "definido" en algún lado.
> - **00:50:22–00:51:46** — respuesta: si una variable necesita comportarse distinto en un solo email, se **sobrescribe** esa variable en la sección de declaración de ese email — nunca se edita el bloque compartido, porque es global a todos los emails.

### Corchetes `[Campo]` vs. `AttributeValue()`

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **03:28:08–03:28:23** — Oscar pregunta por qué se declaran las variables con corchetes en vez de `AttributeValue()`/`GetValue()`.
> - **03:28:55–03:29:16** — respuesta: para campos directos de la DE ambas formas son funcionalmente equivalentes; es cuestión de costumbre del equipo.
> - **03:29:57–03:30:11** — matiz clave: cuando el valor **no** viene directo de la DE sino de un content block (ej. `C1DateLong`), los corchetes no sirven — ahí se necesita la variable ya calculada, no un lookup a la DE.

### "Ya no hay una DE maestra de prueba única" (distinto de la DE de traducciones)

> [!quote]- Mencionado en la grabación (2026-05-08)
> - **03:21:08–03:21:21** — Oscar pide entender el flujo variable ↔ Data Extension desde cero.
> - **03:22:23–03:22:42** — aclaración: todas las variables de declaración vienen de la DE que se está usando para preview (o de la que entregue el Data Team) — no de una "master database" fija.
> - **03:27:14–03:27:49** — se aclara que sí existió en algún momento una DE maestra de prueba de la que se copiaba todo, pero se dejó de mantener por los cambios de naming (detalle ya cubierto en [[LFC_20260508_Lifecycle Email Build & Journey Setup#6 Data Extensions de prueba|punto 3 de esa nota]]) — **no confundir con la DE `LiveTranslationTokens`**, que sí sigue viva y se usa activamente.

---

## Checkpoints donde se usa literalmente la frase "dynamic attribute(s)" / "dynamic variable(s)"

Para referencia rápida al recording, estos son los momentos exactos donde el instructor hace una pausa explícita sobre el tema:

- **00:49:52–00:49:59** — "OK, any questions on any of this dynamic attributes here?"
- **01:09:25–01:09:47** — "Looks like we have bunch of errors going on in the dynamic attribute which I need to check."
- **01:11:52–01:12:04** — "I would just like to go through all the dynamic variables and ensure that they are pulling in correctly."
- **01:12:15–01:12:23** — "The important part is the dynamic variable."

## Continúa en sesiones posteriores

El tema de traducción de tier, `ProperCase()`, singular/plural y un módulo condicional adicional ("Chase Card") se profundiza en una sesión posterior — grabación distinta a la del 8 de mayo, por lo que **no se incluyen marcas de tiempo aquí** (esta nota solo cita la grabación 2026-05-08):

- [[LFC_20260511_Tier Translation Logic & Dynamic Content QA]]

## Relacionado

[[Content ID]]
[[Dynamic Date Block]]
[[AMPscript]]
[[Subject & Preheader Localization]]
[[Translation Workflow]]
[[Data Layer]]
[[Shared Content Blocks]]
[[LFC_20260508_Lifecycle Email Build & Journey Setup]]
[[LFC_20260511_Tier Translation Logic & Dynamic Content QA]]

`#dynamic-content #ampscript #personalization #data-extensions`
