---
aliases:
  - "AMPscript"
  - "Ampscript"
tags:
  - ampscript
  - dynamic-content
  - sfmc
  - functions-reference
  - personalization
created: 2026-08-07
status: Active
---

# AMPscript

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[10 - AMPscript]]
> WHERE file.path != this.file.path
> ```

> [!info] Qué es
> AMPscript es el lenguaje de scripting propietario de Salesforce Marketing Cloud para personalizar contenido dentro de emails, SMS, push, landing pages (CloudPages) y Content Builder. Se ejecuta **del lado del servidor, en el momento del envío o de la vista** (no en el navegador del destinatario) — por eso puede leer Data Extensions, hacer llamadas HTTP y decidir qué HTML renderizar antes de que el mensaje llegue a la bandeja de entrada.

## Reglas fundamentales

- **Se ejecuta de arriba hacia abajo**, en el orden exacto en que aparece en el documento. Una variable debe **declararse antes** del primer punto donde se usa — este es el error de debugging más común (ver el [[LFC_20260508_Lifecycle Email Build & Journey Setup#8.7 Checklist rápido para depurar un email que no previsualiza|checklist de depuración]]).
- **Bloque de lógica**: `%%[ ... ]%%` — todo lo que va adentro no se imprime directamente en el HTML.
- **Salida inline**: `%%=v(@variable)=%%` — imprime el valor de una variable directamente donde se coloca, fuera de un bloque de lógica.
- **Toda variable lleva `@`** al referenciarse (`SET @nombre = ...`, luego `%%=v(@nombre)=%%`) — omitirlo es la causa más común de "la variable no existe" al hacer preview.
- **Orden recomendado dentro de un bloque de declaración**: `VAR` (si se declara sin asignar valor todavía) → `SET` → `IF`/lógica condicional → salida/render.
- **Codificación defensiva**: cubrir variantes conocidas del mismo dato crudo (ej. un tier que puede llegar como `"Gold"`, `"Gold Elite"` o `"GOLD"`) y validar con `Empty()`/`IsNull()` antes de usar un valor que podría no venir en la Data Extension — evita que el email truene en preview por un dato faltante.

## Funciones más usadas — para qué sirven y casos de uso

### Cadenas de texto (String)

| Función                       | Para qué sirve                                                                   | Caso de uso típico en LFC                                                                                                                                                                                                                      |
| ----------------------------- | -------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Concat()`                    | Une varios strings/variables en un solo string                                   | Armar subject line y preheader dinámicos combinando nombre, tier y noches — ver [[LFC_20260508_Lifecycle Email Build & Journey Setup#8.3 Branching de Subject Line y Preheader por ContentID\|ejemplo real]]                                   |
| `ProperCase()`                | Convierte texto a Formato De Título (primera letra de cada palabra en mayúscula) | Normalizar el `first_name` cuando la data llega en mayúsculas completas, para no saludar "HOLA JUAN" — ver [[LFC_20260511_Tier Translation Logic & Dynamic Content QA#2. ProperCase() en el first name del subject line\|nota de esta sesión]] |
| `Uppercase()` / `Lowercase()` | Fuerza mayúsculas o minúsculas                                                   | Normalizar códigos de comparación (`region_language_code`) antes de un `IF` para que la comparación no falle por diferencia de mayúsculas                                                                                                      |
| `Trim()`                      | Quita espacios en blanco al inicio y al final de un string                       | Limpiar valores importados de un CSV que a veces traen espacios extra y rompen una comparación exacta en `IF`                                                                                                                                  |
| `Substring()`                 | Extrae una porción del string a partir de una posición                           | Recortar un código o ID a un largo fijo antes de usarlo como parte de un campaign tag                                                                                                                                                          |
| `Replace()`                   | Reemplaza todas las ocurrencias de un substring por otro                         | Sustituir un placeholder de plantilla por el valor real cuando el content block no lo resuelve automáticamente                                                                                                                                 |
| `IndexOf()`                   | Devuelve la posición de un substring dentro de otro string                       | Detectar si un valor contiene cierto patrón antes de decidir una rama condicional                                                                                                                                                              |
| `Length()`                    | Devuelve el número de caracteres de un string                                    | Validar que un campo no exceda el límite de caracteres de un subject line antes de enviarlo                                                                                                                                                    |

### Datos y Data Extensions

| Función | Para qué sirve | Caso de uso típico en LFC |
|---|---|---|
| `Lookup()` | Devuelve un valor único de una Data Extension, dado un campo de búsqueda | Traducir el nombre de un tier contra la DE maestra de tokens (`LiveTranslationTokens`) — ver [[LFC_20260511_Tier Translation Logic & Dynamic Content QA#1. Traducción dinámica de tier — tier actual y siguiente tier\|ejemplo real]] |
| `LookupRows()` | Devuelve **varias** filas que cumplen una condición (no solo un valor) | Recuperar todas las combinaciones de idioma disponibles para un mismo tier antes de construir un bloque dinámico con varias variantes |
| `AttributeValue()` | Devuelve el valor de un atributo del subscriber/contacto en el contexto del envío | Forma alterna a los corchetes `[Campo]` para leer un campo de la DE de envío — funcionalmente equivalente para campos directos, ver [[LFC_20260508_Lifecycle Email Build & Journey Setup#8.1 Declarar las variables base desde la DE\|nota comparativa]] |
| `Field()` | Devuelve un campo específico de una fila de datos ya obtenida (ej. con `LookupRows` o `Row`) | Leer un campo puntual dentro de un loop sobre las filas devueltas por `LookupRows()` |
| `InsertData()` / `UpdateData()` / `UpsertData()` | Escriben, actualizan o insertan/actualizan filas en una Data Extension | Registrar en una DE de tracking que un contacto hizo clic en un link específico de una CloudPage |
| `DeleteData()` | Elimina filas de una Data Extension | Limpiar registros de prueba de una DE temporal después de una ronda de QA |

### Contenido dinámico (Content Builder)

| Función | Para qué sirve | Caso de uso típico en LFC |
|---|---|---|
| `ContentBlockByKey()` / `ContentBlockById()` / `ContentBlockByName()` | Inserta el contenido de un [[Shared Content Blocks\|content block compartido]] de Content Builder dentro del email | Reutilizar el bloque de formato de fecha (`date-number-format-logic`) sin copiar/pegar el mismo código en cada campaña — ver [[LFC_20260508_Lifecycle Email Build & Journey Setup#8.5 Formato de fecha vía content block compartido\|ejemplo real]] |
| `TreatAsContent()` | Evalúa un string como si fuera código AMPscript/HTML embebido, en vez de mostrarlo como texto literal | Renderizar contenido que viene de una Data Extension (ej. un párrafo con variables dentro) como HTML real, no como texto plano con llaves visibles |
| `TreatAsContentArea()` | Igual que `TreatAsContent()`, pero apuntando a una Classic Content Area por nombre | Migraciones o campañas heredadas que todavía usan Classic Content en vez de Content Builder |

Relacionado: [[TreatAsContent]] · [[Shared Content Blocks]] · [[Dynamic Date Block]]

### Fecha y hora

| Función | Para qué sirve | Caso de uso típico en LFC |
|---|---|---|
| `Now()` | Devuelve la fecha/hora actual del sistema | Comparar contra `Mailing Date` de la DE en el primer decision split de un journey (frescura de datos) |
| `DateAdd()` | Suma (o resta) una cantidad de tiempo a una fecha | Calcular la fecha de fin de un journey agregando un día extra sobre la fecha del List Pull, para cubrir zonas horarias |
| `DateDiff()` | Calcula la diferencia entre dos fechas | Determinar cuántos días faltan para que expire una oferta y mostrar ese número en el body copy |
| `FormatDate()` / `Format()` | Da formato a una fecha o número según un patrón específico | Mostrar la fecha en formato corto (`DD/MMM/YYYY`) o largo ("Sunday, May 31st") según lo que pida el Figma — ver [[LFC_20260508_Lifecycle Email Build & Journey Setup#8.5 Formato de fecha vía content block compartido\|ejemplo real]] |

### Condicionales y utilidades

| Función | Para qué sirve | Caso de uso típico en LFC |
|---|---|---|
| `IIF()` | Condicional en una sola línea: devuelve un valor u otro según una condición booleana, sin necesidad de `IF`/`ENDIF` completo | Elegir entre `"night"` y `"nights"` en una sola línea cuando la lógica es simple, en vez de un bloque `IF`/`ELSE`/`ENDIF` completo |
| `Empty()` | Verifica si una variable no tiene valor asignado | Confirmar que un campo opcional de la DE (ej. `Custom2Str`) sí trae dato antes de intentar traducirlo, evitando un error de Lookup contra un valor vacío |
| `IsNull()` | Verifica si el valor de una variable o función es nulo | Mismo propósito que `Empty()`, usado como chequeo defensivo antes de una comparación en `IF` |
| `GUID()` | Genera un identificador único | Crear un ID de tracking único por envío cuando se necesita correlacionar un clic con un registro específico |
| `RequestParameter()` | Lee un parámetro recibido en la URL (típico en CloudPages) | Leer un parámetro de query string en una landing page para personalizar el contenido según de qué link vino el clic |
| `Output()` / `OutputLine()` | Fuerza la impresión del resultado de una función directamente en el HTML | Alternativa a `%%=v(@var)=%%` cuando se necesita imprimir el resultado de una función sin pasar por una variable intermedia |
| `RaiseError()` | Detiene la ejecución y muestra un mensaje de error personalizado | Bloquear el envío/preview intencionalmente si una validación crítica falla (ej. falta un campo obligatorio), en vez de dejar que el email se vea roto |

### Math

| Función | Para qué sirve | Caso de uso típico en LFC |
|---|---|---|
| `Add()` / `Subtract()` / `Multiply()` / `Divide()` | Operaciones aritméticas básicas | Calcular cuántas noches faltan para el siguiente tier restando noches actuales del umbral del siguiente nivel |

### HTTP / integraciones externas

| Función | Para qué sirve | Caso de uso típico en LFC |
|---|---|---|
| `HTTPGet()` | Hace una petición GET a una URL externa y devuelve el resultado | Consultar un endpoint externo para enriquecer contenido en una CloudPage (uso poco común en emails estándar de LFC, más frecuente en microsites) |
| `HTTPPost()` | Envía datos a una URL externa vía POST | Enviar datos de un formulario de CloudPage a un sistema externo |

## Sintaxis especial: regiones de impresión

No son funciones en el sentido estricto, pero son sintaxis AMPscript central para cualquier módulo dinámico:

```
%%[ IF @condicion THEN ]%%
%%[Begin Impression Region NombreDelModulo]%%
  <!-- HTML del modulo -->
%%[End Impression Region]%%
%%[ ENDIF ]%%
```

- `Begin Impression Region` / `End Impression Region` marcan qué bloque de HTML cuenta como **una impresión** para efectos de reporting — van **fuera** del `IF`/`ENDIF`, no anidados dentro, aunque envuelvan un módulo condicional completo.
- La convención de nombre es **posición del módulo + nombre del módulo** (ej. `Module4_ChaseCard`).
- Hay un bug histórico documentado en el equipo: cerrar la región con el parámetro `1` en vez de `0` provoca que nunca cierre correctamente en el reporting — ver la nota al respecto en [[LFC_20260511_Tier Translation Logic & Dynamic Content QA#4. Módulo condicional dinámico — ejemplo "Chase Card"|sección 4 de esta sesión]].

## Ejemplos reales de uso en este vault

Los patrones de arriba, aplicados en builds reales documentados en las sesiones de onboarding:

- [[LFC_20260508_Lifecycle Email Build & Journey Setup#8 AMPscript en la práctica — ejemplo real de build|Declaración de variables, excepción por idioma, branching por ContentID, singular/plural, formato de fecha, módulo condicional]]
- [[LFC_20260511_Tier Translation Logic & Dynamic Content QA|Traducción de tier actual/siguiente, ProperCase en subject, módulo Chase Card completo]]

## Relacionado

[[Content ID]]
[[Data Layer]]
[[Shared Content Blocks]]
[[Dynamic Date Block]]
[[TreatAsContent]]
[[Translation Workflow]]
[[QA Process]]

> [!note]- Fuentes
> Referencia de funciones consultada en la [documentación oficial de AMPscript de Salesforce Developers](https://developer.salesforce.com/docs/marketing/marketing-cloud-ampscript/references/mc-ampscript-references/mc-ampscript-references-index.html) y en [ampscript.guide](https://ampscript.guide/introduction/), agosto 2026.
