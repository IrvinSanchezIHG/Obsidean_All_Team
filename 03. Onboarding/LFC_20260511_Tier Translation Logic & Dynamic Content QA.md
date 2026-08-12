---
date: 2026-05-11
tags:
  - lfc
  - sfmc
  - ampscript
  - dynamic-content
  - content-id
  - test-de
  - qa
  - onboarding
  - meeting-notes
type: meeting-notes
related:
  - "[[LFC_20260508_Lifecycle Email Build & Journey Setup]]"
  - "[[LFC_20260507_Lifecycle Email Development & Data Integration]]"
created: 2026-08-10
status: Active
---

# LFC Training — Tier Translation Logic & Dynamic Content QA

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[LFC_20260511_Tier Translation Logic & Dynamic Content QA]]
> WHERE file.path != this.file.path
> ```

> [!info] Contexto
> Sesión de capacitación LFC del 11 de mayo de 2026: continuación práctica del build de email iniciado en [[LFC_20260508_Lifecycle Email Build & Journey Setup]]. Oscar construye en vivo, guiado por Kamaria, con Alex y Aruni observando/asistiendo. El foco de esta sesión es lógica AMPscript de traducción dinámica de tier, singular/plural, un módulo condicional completo (Chase Card) y una ronda extensa de QA visual sobre HTML/CSS. Cierra con el plan de la siguiente sesión: walkthrough de traducciones y luego build de journey.

> [!warning] Nota sobre la fuente
> Esta nota se sintetizó a partir de la transcripción automática (closed captions) de la grabación de la sesión. El audio original tiene errores de transcripción y jerga hablada muy suelta; el contenido de abajo reconstruye la intención técnica real, no es una cita literal del transcript.

## 1. Traducción dinámica de tier — tier actual y siguiente tier

#ampscript

El email necesitaba mostrar **dos** valores de tier traducidos en el mismo bloque: el tier actual del miembro y el siguiente tier al que puede aspirar. La lógica de traducción del tier actual (`Custom1Str` → `Custom1Trans`) ya existía de una sesión anterior; el trabajo de este bloque fue **replicar el mismo patrón para el siguiente tier**, usando el segundo par de variables de la Data Extension (`Custom2Str` → `Custom2Trans`):

```
%%[
  /* Tier actual - ya existente */
  SET @Custom1Trans = Lookup("LiveTranslationTokens","trans_tier_name",
                              "region_language_code",@region_language_code,
                              "tier_key",@Custom1Str)

  /* Siguiente tier - nuevo, mismo patron con las variables de Custom2 */
  SET @Custom2Trans = Lookup("LiveTranslationTokens","trans_tier_name",
                              "region_language_code",@region_language_code,
                              "tier_key",@Custom2Str)
]%%
```

- La variable recién creada (`@Custom2Trans`) se usa luego en el subject line y el preheader, igual que `@Custom1Trans`.
- Error recurrente durante el build: olvidar el símbolo `@` antes del nombre de la variable al referenciarla fuera de la declaración — AMPscript no la reconoce sin él.

Relacionado: [[AMPscript]] · [[Translation Workflow]]

---

## 2. `ProperCase()` en el first name del subject line

Mismo patrón que en [[LFC_20260508_Lifecycle Email Build & Journey Setup#8.3 Branching de Subject Line y Preheader por ContentID|la sesión anterior]], pero esta vez faltaba aplicarlo específicamente en el **subject line** (ya estaba aplicado en el body copy): la variable del nombre debe envolverse en `ProperCase()` justo donde se concatena, no solo donde se declara — si solo se corrige en la declaración, el subject sigue mostrando el nombre tal cual venga de la data (a veces en mayúsculas completas).

```
SET @subjectLine = Concat(ProperCase(@first_name), ", ready to earn bonus elite nights?")
```

---

## 3. Singular/plural dinámico — noches y créditos

Patrón para pluralizar una palabra según un valor numérico que viene de la DE, aplicado dos veces en el mismo email (una para "night/nights", otra para "credit/credits"):

```
%%[
  IF @Custom1Num == 1 THEN
    SET @NightWord = "night"
  ELSE
    SET @NightWord = "nights"
  ENDIF

  IF @Custom1Num == 1 THEN
    SET @CreditWord = "credit"
  ELSE
    SET @CreditWord = "credits"
  ENDIF
]%%
```

> [!warning] Custom1 y Custom2 son independientes
> El milestone rewards module de este email usa **`Custom2Num`**, no `Custom1Num` — es un valor distinto (ej. `Custom1Num = 1` pero `Custom2Num = 2`). Copiar/pegar la condición de singular/plural de una sección a otra sin actualizar qué variable se evalúa produce un plural incorrecto. Cada sección dinámica necesita su propia condición evaluando la variable que realmente le corresponde.

---

## 4. Módulo condicional dinámico — ejemplo "Chase Card"

#ampscript

Módulo completo que solo debe mostrarse a un segmento específico: miembros de tier `T2`, región `USEN`, que **no** tienen ya la tarjeta de crédito co-branded. Ejemplo end-to-end de cómo se arma un módulo 100% dinámico:

```
%%[
  /* Declaraciones necesarias para las condiciones de este modulo */
  SET @ContentID = [ContentID]
  SET @RegionLangCode = [region_language_code]
  SET @ChaseCard = [ChaseCard]

  IF @ContentID == "T2" AND @RegionLangCode == "USEN" AND @ChaseCard == "N" THEN
]%%
%%[Begin Impression Region Module4_ChaseCard]%%
  <!-- HTML del modulo Chase Card -->
%%[End Impression Region]%%
%%[
  ENDIF
]%%
```

- El campo `ChaseCard` en la Data Extension es de tipo **texto (string), no booleano** — el valor de prueba correcto es `"N"` (o `"Y"`), **no** `"false"`/`"true"`. Confundir el tipo de dato provocó que la condición nunca se cumpliera durante las pruebas iniciales.
- `@RegionLangCode` (la variable de región/idioma) tenía que **declararse explícitamente en la sección dinámica del módulo** — se estaba usando sin declarar ahí, y por eso el módulo no jalaba el valor aunque la variable sí existiera en otra parte del email.
- `Begin Impression Region` / `End Impression Region` van **fuera** del `IF`/`ENDIF` (todo el módulo, condición incluida, cuenta como una sola impresión), no anidados dentro.

> [!note] Bug histórico de referencia
> En una campaña anterior, el `End Impression Region` se cerró usando el parámetro `1` en vez de `0`, lo que provocaba que la región de impresión nunca cerrara correctamente en el reporting. Vale la pena recordarlo si un módulo dinámico reporta impresiones de forma inconsistente.

Relacionado: [[AMPscript]] · [[Content ID]] · [[Data Layer]]

---

## 5. Convención de Content ID y campaign tag — registro vs. booking

- **Prefijo de Content ID**: `A1`–`A7` están reservados para los emails de **registro** y sus recordatorios. Los emails de **booking** usan prefijo `B` (`B1`, `B2`…) — son namespaces separados, no una continuación numérica del mismo prefijo.
- **Campaign tag**: al Booking le corresponde agregar el sufijo `book` al final del campaign tag (ej. termina en `...book`), mientras que Registration no lleva ese sufijo. Esta distinción es la que permite separar los envíos de registro de los de booking cuando el **List Pull** jala el tag para reporting — sin el sufijo, ambos flujos se mezclarían en el mismo tag y el reporting no podría diferenciarlos.
- Para confirmar el Content ID y el campaign tag exactos de una campaña, la fuente de verdad es el **CRF**, no asumir por convención.

---

## 6. QA de HTML/CSS — hallazgos de esta sesión

Ronda de QA visual sobre los tres emails construidos (registro, booking, completion). Tabla de hallazgos y su causa/fix:

| Hallazgo | Causa | Fix |
|---|---|---|
| `font-weight` no se aplicaba visualmente | Typo en el nombre de la propiedad CSS (escrita como `weigd`/`GHD` en vez de `weight`) | Corregir el nombre de la propiedad |
| Espacio extra visible entre "night" y el siguiente texto | Un `&nbsp;` combinado con un espacio literal, ambos presentes al mismo tiempo | Revisar el HTML editor directamente — el espacio de más no siempre es visible en el editor visual |
| Body copy centrado en vez de alineado a la izquierda | Estilo heredado de otro módulo copiado como base | Forzar `text-align: left` explícito en la celda |
| Padding extra debajo de la sección de terms & conditions | `padding-bottom` de 30px en una celda que debía ser 0 | Ajustar el padding en la celda específica, no en el CTA |
| Espaciado entre CTA y el texto de terms | El padding estaba aplicado al `<td>` del botón CTA | Mover el padding al `<td>` del texto de terms, no al del CTA — así el espaciado no depende del tamaño del botón |
| Título en dos líneas ("Congrats" / "you earned it") no se veía consistente entre clientes de correo | Salto de línea manual dentro de la misma celda | Usar dos `<tr>` separados en vez de un salto de línea manual, para que el line-height sea consistente |
| Montserrat se veía distinto en Windows | Fallback de fuente del sistema operativo, no un bug del build | Confirmar contra el HTML fuente que la fuente declarada es correcta antes de "arreglar" nada — es un tema de renderizado local, no del código |

> [!tip] Exportar íconos individuales desde Figma
> Si el ícono no se exporta solo sino que descarga la carpeta/grupo completo, normalmente es porque esa capa específica no está marcada individualmente como exportable dentro de Figma — hay que revisar cómo está armada la jerarquía de capas del componente, no es un problema del lado de Content Builder.

---

## 7. Flujo de importación a la Data Extension de prueba

Mismo principio que en [[LFC_20260508_Lifecycle Email Build & Journey Setup#6 Data Extensions de prueba|la sesión anterior]] (nunca editar la DE de producción), con el detalle operativo del proceso de import usado en esta sesión:

1. Exportar la DE de prueba a CSV, editar los valores localmente.
2. En el import wizard de la DE, seleccionar el archivo y elegir **Overwrite** (no append) para reemplazar los datos existentes.
3. Si el mapeo automático **"by header row"** no alinea bien las columnas, cambiar a **"map by ordinal"** y verificar campo por campo que cada columna caiga en el atributo correcto.
4. Errores comunes al importar:
   - **"Invalid field count"** — normalmente causado por una coma suelta dentro de un valor de texto que rompe la estructura del CSV.
   - Valores booleanos mal tipados — confirmar si el campo espera `true`/`false` real o un string tipo `"Y"`/`"N"` (ver [[#4 Módulo condicional dinámico — ejemplo Chase Card|sección 4]]).
5. Al completar el import exitosamente llega un correo de confirmación — hasta entonces no tiene caso volver a hacer preview del email, porque los datos nuevos aún no están disponibles.
6. Después de la confirmación: volver a Content Builder, guardar el contenido y volver a buscar/previsualizar para ver los valores actualizados.

Relacionado: [[Data Layer]] · [[QA Process]]

---

## 8. Cierre de sesión y próximos pasos

- Los tres emails de esta campaña (registro, booking, completion) quedaron completos al cierre de la sesión.
- Plan para la siguiente sesión: walkthrough del proceso de **envío a traducción** (se salta proofing ese día para ir directo a esa parte con Alex), y después continuar con el **build del journey**.
- Aruni se integraría específicamente para la parte de traducciones — ver [[LFC_20260812_GALE Training - Translation Project Walkthrough]].
- Regla general reforzada varias veces en la sesión: **cambiar una sola cosa a la vez** al depurar un error — cuando se cambian varias cosas simultáneamente y el error desaparece, no queda claro cuál cambio fue el que realmente lo resolvió.

## Relacionado

[[LFC_20260508_Lifecycle Email Build & Journey Setup]]
[[LFC_20260507_Lifecycle Email Development & Data Integration]]
[[AMPscript]]
[[Content ID]]
[[Data Layer]]
[[QA Process]]
[[Translation Workflow]]
