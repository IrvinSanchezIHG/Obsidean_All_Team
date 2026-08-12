---
date: 2026-05-08
tags:
  - lfc
  - sfmc
  - journey-builder
  - ampscript
  - decision-split
  - test-de
  - onboarding
  - meeting-notes
type: meeting-notes
related:
  - "[[LFC_20260507_Lifecycle Email Development & Data Integration]]"
created: 2026-08-10
status: Active
---

# LFC Training — Lifecycle Email Build & Journey Setup

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[LFC_20260508_Lifecycle Email Build & Journey Setup]]
> WHERE file.path != this.file.path
> ```

> [!info] Contexto
> Sesión de capacitación LFC del 8 de mayo de 2026: build real de un email Nurture con [[AMPscript]] y construcción a detalle de un [[Journey Builder|journey]]. Complementa [[LFC_20260507_Lifecycle Email Development & Data Integration]] (estructura de carpetas, naming, flujo de datos, tracking) — esa nota cubre el modelo general; esta cubre el build práctico paso a paso.

## 1. Build de Email — detalles prácticos

- **Localizar bloques del Figma en Content Builder**: el equipo de creative etiqueta cada bloque del Figma con el ID del componente en la librería de SFMC (ej. `10A`, `5P`, `10D`). Ten cuidado: a veces el Figma etiqueta el bloque incorrecto (dice `10C` cuando en realidad es `10D`) — ante la duda, compara visualmente contra la librería real, no solo contra la etiqueta.
- **El "Campaign Configuration File"**: las plantillas de Life Cycle traen un bloque AMPscript compartido y reutilizado por casi todos los emails (mapeo de `ContentID`, búsqueda contra la DE de traducciones, etc.). **No se edita ese bloque compartido** para resolver una necesidad de un solo email — es global. Si una variable necesita comportarse distinto solo en tu email, se **sobrescribe (override) esa variable específica** en la sección de declaración de tu propio email, después de donde se carga el bloque compartido.
- **Alias y link helper**: cada anchor tag lleva, además de la URL final, un **alias name** que sigue la convención del Link/URL Matrix del CRF (ej. `mod1_headlineBonus`) y, cuando aplica, un título legible al hover. Las URLs se arman con el **[[Link Matrix (LinkHelper)|link helper]]** compartido que resuelve automáticamente la variante correcta según el código de región/idioma — la misma referencia de link puede resolver a la página global en inglés o a la página en japonés sin mantener una URL distinta por idioma.
- **Emails en árabe**: las plantillas incluyen una variable dedicada que controla alineación y dirección de texto (derecha a izquierda) — confirmar que esté presente y configurada, no asumir que el layout se ajusta solo.
- **`ProperCase()` en el first name**: si la data trae el nombre en mayúsculas completas, `ProperCase()` lo normaliza antes de mostrarlo — sin esto, un email puede saludar "HOLA JUAN" en vez de "Hola Juan".
- **Regiones de impresión**: la convención de nombre es **posición del módulo + nombre del módulo** (ej. `Module3_AppDownload`). Ejemplo de condición no intuitiva: un módulo de "descarga la app" que solo debe mostrarse a quien **no** tiene la app — el campo `mobile_app = false` puede ser justo la señal para *mostrar* el módulo, no para ocultarlo. Siempre valida el significado real del campo antes de escribir la condición.
- **Preview incremental**: revisar el email a la mitad del build (no solo al final) hace mucho más fácil ubicar en qué bloque está el error — una condicional sin `THEN`, una variable no declarada, un typo en el nombre de campo.

Relacionado: [[AMPscript]] · [[Content ID]] · [[Shared Content Blocks]]

---

## 2. Journey — el patrón de Decision Splits

#decision-split

Casi todos los journeys de Life Cycle en producción siguen el mismo patrón, en este orden:

1. **Split de frescura de datos ("Mailing Date")** — el primer split de casi cualquier journey compara un atributo de la DE (`Mailing Date`) contra la fecha de hoy, porque la DE se refresca automáticamente cada día vía la automation del Data Team. Este split confirma que el journey usa la versión más reciente de la data. Solo se ajusta en casos excepcionales (el refresh no se completó a tiempo).
2. **Split de idioma/región** — Life Cycle maneja ~28 códigos de idioma/región; crear un split individual por cada uno desde el inicio satura el canvas. Patrón recomendado:
   - Primer split: separar "no inglés" del resto.
   - Segundo split (rama inglés): agrupar variantes que comparten el mismo email (ej. `USEN` + `MSEN`, porque EE. UU./Canadá/México comparten asset en inglés).
   - Splits adicionales, uno por cada idioma con asset traducido propio (ej. `AMJP` para Japón, `EUDE` para Alemania).
   - Siempre verificar contra el **List Pull** qué idiomas aplican — no toda campaña tiene los 28; agregar splits de idiomas que no aplican solo genera limpieza extra después.

> [!note] Caso especial — Canadá
> Por decisión de negocio, los miembros de Canadá reciben la versión de **inglés global**, no la de EE. UU. — vale la pena recordarlo al armar los splits.

> [!note] Qué significan TR y TB
> `TR` = etapa de registro (trigger/registration); `TB` = etapa de booking. El número (`TR1`, `TR2`… `TB1`, `TB2`…) identifica el touch-point específico dentro de esa etapa.

Relacionado: [[Journey Builder]] · [[Entry Source]]

---

## 3. Journey — un journey por touch-point

Para campañas multi-touch (anuncio → recordatorio de registro → recordatorio de booking → completion), la tentación es un solo journey con varios wait steps. **En Life Cycle casi nunca es así**: el Data Team entrega una Data Extension separada por touch-point, así que lo habitual es **un journey independiente por touch-point**, no una única secuencia. La forma más rápida y segura de construir uno nuevo es **copiar un journey anterior similar** (ej. el Nurture del trimestre pasado) y actualizar Entry Source, splits de idioma y fechas — no partir de cero cada vez.

---

## 4. Journey — reentrada, envíos grandes y criterios de salida

- **Reentrada:** para un envío único que no debe repetirse (ej. el anuncio inicial de registro), usar **"No re-entry"**. Para touch-points recurrentes dentro de la misma secuencia (ej. recordatorios de booking, donde quien no calificó para el primero podría calificar para el segundo o tercero), usar **"Allow re-entry"** — si no, alguien que no recibió el primer recordatorio queda bloqueado de los siguientes.
- **Envíos grandes:** con volúmenes del orden de millones de contactos, existe una configuración específica del journey para optimizar velocidad de envío — activarla en esos casos.
- **Exit criteria:** el más común es `SubscriberKey is not null` (a veces se ha usado `EmailAddress is not null`) — **confirmar el estándar vigente con el lead** antes de asumir uno u otro, porque ha cambiado en el pasado.
- **Fecha de fin:** se toma del List Pull, pero por diferencias de zona horaria entre mercados, la práctica estándar es **agregar un día extra** a la fecha de fin del List Pull, para que todos los contactos —sin importar su zona horaria— alcancen a recibir el envío del último día antes de que el journey se detenga.

---

## 5. Nombrar cada actividad dentro del journey

Al agregar una actividad de Email o Push al canvas, **actualizar siempre su nombre/descripción** para que sea legible (ej. `AMJP — Booking Reminder B2`), en vez de dejar el código largo que Journey Builder genera automáticamente. Ese nombre es el que aparece en **Interactions** — cuando algo falla y hay que identificar rápido qué envío específico tuvo el problema, un nombre descriptivo ahorra minutos de troubleshooting frente a un código ilegible.

---

## 6. Data Extensions de prueba

#test-de

**Regla no negociable: nunca se edita la Data Extension de producción (live).** Todo el trabajo de preview/QA ocurre en una DE de prueba.

1. **Reutiliza cuando puedas** — si ya existe una DE de una campaña anterior similar con los mismos campos/atributos, úsala directamente.
2. **Si necesitas campos nuevos**, duplica la DE existente más parecida, agrega los campos adicionales, **exporta**, edita localmente con los valores de prueba necesarios (cubriendo todas las combinaciones relevantes: cada tier, cada idioma, cada variante de ContentID), y **vuelve a importar** a esa misma DE de prueba.
3. **Ya no existe una "DE maestra" única** de la que se copian todas las pruebas — se dejó de sostener por la cantidad de cambios de naming a través del tiempo. La práctica actual es copiar la DE de la campaña anterior más parecida.
4. Para cobertura completa de QA, la DE de prueba idealmente tiene **un registro por cada combinación relevante** (idioma/región × tier × variante de ContentID × valor de noches, etc.), de forma que un solo envío de prueba ejercite todas las ramas dinámicas del email.

Relacionado: [[Data Layer]] · [[QA Process]]

---

## 7. Nota sobre traducciones: la DE maestra de tokens

Las traducciones de textos frecuentes (nombres de tier, "noche/noches", frases de footer recurrentes) **ya viven en una Data Extension maestra compartida** (a veces llamada la DE de *"live translation tokens"*), incluida por default en el campaign configuration file de las plantillas. **No es necesario solicitar traducción de estos textos por separado** — solo se envían a traducción los elementos verdaderamente nuevos o específicos de la campaña. El proceso de traducción **no** traduce automáticamente el contenido que vive dentro de una declaración de variable AMPscript — eso debe entregarse aparte, normalmente en una hoja de cálculo, junto con el resto del contenido a traducir.

Relacionado: [[Translation Workflow]] · [[Smartling]]

---

## 8. AMPscript en la práctica — ejemplo real de build

#ampscript

> [!warning] Nota sobre este código
> El siguiente AMPscript es una **reconstrucción ilustrativa** de los patrones descritos en esta sesión (build en vivo de un email Nurture de "booking reminder"), escrita con nombres de campo genéricos. No es una copia literal del código mostrado en pantalla — úsalo como referencia de sintaxis y estructura, no como snippet para copiar/pegar sin adaptar a tu campaña real.

### 8.1 Declarar las variables base desde la DE

Al inicio del email se declaran las variables que vienen directamente de la Data Extension. Existen dos formas equivalentes de hacerlo — el equipo usa principalmente la primera por costumbre:

```
%%[
  /* Forma 1: corchetes cuadrados (shorthand) - busca el campo directo en la DE de envio */
  SET @ContentID = [ContentID]
  SET @first_name = [first_name]
  SET @region_language_code = [region_language_code]
  SET @Custom1Num = [Custom1Num]
  SET @Custom1Str = [Custom1Str]
  SET @Custom1Date = [Custom1Date]

  /* Forma 2: AttributeValue() - funcionalmente igual para campos que si estan en la DE */
  SET @first_name = AttributeValue("first_name")
]%%
```

> [!note] ¿Cuándo usar cada forma?
> Ambas formas obtienen el valor del campo **directo de la DE de envío**. La diferencia práctica aparece con valores que **no** vienen directamente de la DE, sino que se calculan o se traen de un content block (por ejemplo, una fecha ya formateada): esos casos no se pueden resolver con corchetes, porque los corchetes solo buscan campos en la DE — para esos, la variable se arma con lógica (`SET`) o se recibe desde el content block, como se muestra en 8.4.

### 8.2 Excepción por idioma — colocarla ANTES de usarla

Ciertos mercados requieren una regla especial. En el ejemplo, los emails en japonés deben mostrar el apellido en vez del nombre. **Esta condición debe ir antes de cualquier lógica que use `@first_name`** — de lo contrario, el subject/preheader ya se habrá armado con el valor incorrecto:

```
%%[
  IF @region_language_code == "AMJP" THEN
    SET @first_name = [last_name]
  ENDIF
]%%
```

Este patrón — una excepción de idioma resuelta con una condición temprana en la declaración de variables, sin tocar la lógica principal — se repite en otras campañas cuando un mercado específico necesita una regla especial.

### 8.3 Branching de Subject Line y Preheader por ContentID

```
%%[
  IF @ContentID == "B1" THEN
    SET @subjectLine = Concat("Ready to earn bonus elite nights, ", ProperCase(@first_name))
    SET @preheader = Concat("Stay up to ", @Custom1Num, " nights to earn it twice")
  ELSEIF @ContentID == "B2" THEN
    SET @subjectLine = Concat(ProperCase(@first_name), ", stay ", @Custom1Num, " nights to secure your status")
    SET @preheader = "Don't miss this opportunity to secure your status"
  ELSEIF @ContentID == "B3" THEN
    SET @subjectLine = "Ready to log in? Your status is waiting"
    SET @preheader = "Static content"
  ENDIF
]%%
```

Nota el `THEN` después de cada condición — **olvidarlo es el error de sintaxis más común** al construir estas cadenas.

### 8.4 Singular/plural y traducción de tier

```
%%[
  /* Palabra en vez de numero, usada en terminos y condiciones */
  IF @Custom1Num == 5 THEN
    SET @NightsWord = "five"
  ELSE
    SET @NightsWord = "ten"
  ENDIF

  /* Traduccion de tier: cubre variaciones de como llega el dato crudo */
  IF @Custom1Str == "Silver Elite" OR @Custom1Str == "Silver" OR @Custom1Str == "SLVR" THEN
    SET @Custom1Trans = Lookup("LiveTranslationTokens","trans_tier_name",
                                "region_language_code",@region_language_code,
                                "tier_key","club")
  ELSEIF @Custom1Str == "Gold Elite" OR @Custom1Str == "Gold" THEN
    SET @Custom1Trans = Lookup("LiveTranslationTokens","trans_tier_name",
                                "region_language_code",@region_language_code,
                                "tier_key","gold")
  ENDIF
]%%
```

Este patrón — cubrir varias variaciones posibles del mismo valor crudo (`"Silver Elite"`, `"Silver"`, `"SLVR"`) — existe porque la data de origen no siempre es 100% consistente; es más seguro contemplar las variantes conocidas que asumir un único formato.

### 8.5 Formato de fecha vía content block compartido

```
%%[
  SET @dateFormatBlock = ContentBlockByKey("date-number-format-logic")
]%%
%%=v(@C1DateLong)=%%
```

Existen dos formatos de fecha reutilizables en la librería de content blocks: **corto** (`DD/MMM/YYYY`) y **largo** (fecha en palabras, ej. "Sunday, May 31st"). El formato correcto a usar depende de lo que pida el Figma para esa sección específica.

### 8.6 Módulo condicional con región de impresión

```
%%[ IF @mobile_app == "false" THEN ]%%
%%[Begin Impression Region Module3_AppDownload]%%
  <!-- HTML del modulo de descarga de la app -->
%%[End Impression Region]%%
%%[ ENDIF ]%%
```

> [!warning] Cuidado con la semántica invertida
> En este ejemplo, `@mobile_app == "false"` es la condición para **mostrar** el módulo (porque el miembro **no** tiene la app instalada) — es fácil interpretarlo al revés. Siempre confirma con el List Pull o el CRF qué significa realmente cada valor del campo antes de escribir la condición.

### 8.7 Checklist rápido para depurar un email que no previsualiza

1. ¿Cada `IF` tiene su `THEN`? ¿Cada bloque `IF` cierra con `ENDIF`?
2. ¿El nombre del campo coincide **exactamente** con el de la DE (mayúsculas, guiones bajos, sin espacios)?
3. ¿La variable se declaró **antes** del punto donde se usa por primera vez?
4. ¿La excepción de idioma (si aplica) está **antes** de la sección de subject/preheader?
5. ¿Faltó algún espacio dentro de un `Concat()` (revisar cada coma con datos reales en preview)?
6. ¿El content block se está llamando con el ID/Key correcto?

Relacionado: [[AMPscript]] · [[Content ID]] · [[Translation Workflow]]

---

## 9. Troubleshooting específico de este build

| Problema | Causa probable | Primeras cosas a revisar |
|---|---|---|
| Error de AMPscript al hacer preview (ej. "expected THEN") | Sintaxis incompleta en un IF/ELSEIF, variable referenciada antes de declararse | Revisar cada IF por un `THEN` faltante; confirmar que toda variable se declaró antes del punto donde se usa (ver [[#8 AMPscript en la práctica — ejemplo real de build|sección 8]]) |
| Falta un espacio o la puntuación se ve rota en subject/preheader concatenado | Error de concatenación (falta un espacio literal entre variables) | Revisar cada `Concat()` cuadro por cuadro contra el resultado esperado en preview |
| Contacto de Japón recibe el nombre en vez del apellido | La condición de excepción por idioma se colocó después de usar la variable, no antes | Confirmar que la regla `region_language_code == "AMJP"` esté declarada **antes** de la sección de subject/preheader, no después (ver 8.2) |

---

## 10. Checklist de Journey (adicional al general)

- [ ] Decision split de frescura de datos (Mailing Date == hoy) presente al inicio del canvas.
- [ ] Decision splits de idioma alineados exactamente con el List Pull (ni de más ni de menos).
- [ ] Cada actividad de email/push tiene un nombre descriptivo (no el código autogenerado).
- [ ] Configuración de reentrada correcta según el tipo de touch-point (única vez vs. recurrente).
- [ ] Exit criteria confirmado con el lead.
- [ ] Fecha de fin del journey ajustada (+1 día sobre el List Pull) para cubrir zonas horarias.

## Relacionado

[[LFC_20260507_Lifecycle Email Development & Data Integration]]
[[Journey Builder]]
[[AMPscript]]
[[Data Layer]]
[[QA Process]]
