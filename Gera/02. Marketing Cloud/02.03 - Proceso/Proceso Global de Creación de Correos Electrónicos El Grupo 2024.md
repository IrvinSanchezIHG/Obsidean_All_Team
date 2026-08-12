---
tags:
  - sfmc
  - email-marketing
  - el-grupo
  - la-agencia
  - documentation
created: 2026-08-07
status: Active
---

# Proceso Global de Creación de Correos Electrónicos El Grupo 2024

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Proceso Global de Creación de Correos Electrónicos El Grupo 2024]]
> WHERE file.path != this.file.path
> ```

Nota resumen del documento de capacitación de Gale/El Grupo sobre el proceso de creación de correos en [[Salesforce Marketing Cloud]] (#sfmc), desde el diseño en [[Figma]] hasta el envío final.

## 1. Nomenclatura y estructura

#naming-convention #content-builder **Responsable:** [[Desarrollador de Correo]] (Email Developer) — el documento no asigna un dueño explícito para este paso; se infiere del rol que ejecuta la carga en [[Content Builder]].

- Estructura de carpetas: categoría > región > año > mes > carpeta del correo.
- Convenciones de nombre para [[Correo Electrónico]], [[DataExtension]] y [[Push Message]].
- No usar guiones bajos dentro del nombre de campaña; sí guiones medios.
- Pestaña de propiedades: tabla de categorías (ACCT, LFC, PTR, REV, etc.).

Relacionado: [[Pestaña de Propiedades]] · [[Componentes SFMC]]

## 2. Diseño en Figma

#figma #diseño **Responsable:** [[Equipo Creativo]] — provee el enlace y el diseño en Figma. La descarga de bloques/imágenes hacia SFMC queda a cargo del [[Desarrollador de Correo]].

- Acceso al archivo de Figma provisto por el equipo creativo.
- Identificación de bloques/módulos (mismos nombres que en [[SFMC]]).
- Descarga de imágenes en resolución 2x para su uso en [[Content Builder]].

Relacionado: [[Componentes SFMC]] · [[Actualización de Imágenes]]

## 3. Creación del correo en SFMC

#content-builder #plantillas **Responsable:** [[Desarrollador de Correo]] (Email Developer) — construye el correo en Content Builder a partir de las plantillas y el diseño de Figma. No especificado explícitamente en el documento.

- Plantillas maestras: `Gale_Master_Adhoc_Template` y `Gale_Master_Template_LFC`.
- Cada plantilla trae preconstruidos: [[Header]], [[Footer]], [[Tier Status]] y el bloque de [[Configuración de Campaña]].
- Flujo: Content Builder → seleccionar plantilla → definir propiedades → arrastrar módulos → actualizar imágenes/contenido copiado de [[Figma]].
- [[Espaciadores]] (Spacers) para controlar el padding entre módulos.
- Integración con [[Movable Ink]] (parámetros de tracking en imágenes y enlaces).

Relacionado: [[Bloque de Configuración de Campaña]] · [[Ampscript]]

## 4. Personalización dinámica

#ampscript #personalization **Responsable:** [[Desarrollador de Correo]] (Email Developer) — escribe la lógica de Ampscript. No especificado explícitamente en el documento.

- Líneas de asunto y preencabezados: personalización simple, condiciones IF/ELSE, y combinaciones con variables.
- [[Bloques Dinámicos]]: lógica de mostrar/no mostrar contenido y contenido variable según condiciones (`memlvl`, `contentid`, etc.).

Relacionado: [[Ampscript]] · [[Content Builder]]

## 5. Enlaces y tracking

#enlaces #tracking **Responsable:** [[Desarrollador de Correo]] (Email Developer) — arma los enlaces y etiquetas alias. La revisión final ("click test") queda a cargo de la audiencia/partes interesadas, según el paso de QA.

- Composición del enlace: url base + atributo de idioma/región (`@linkhelper_rgn_lang`) + url de extensión. Detalle de la Data Extension que alimenta esta variable en [[Link Matrix (LinkHelper)]].
- Parámetro combinado `@track_param` (aa_tag_base, aa_tag_version, SENDURLID, parámetro de [[Movable Ink]]).
- Convenciones de nomenclatura para etiquetas **alias** (header, footer, módulos, regiones de impresión).
- Cómo agregar alias en editor WYSIWYG y en editor HTML.
- [[Píxeles de Seguimiento]]: Marketing Cloud, Movable Ink, Inbox Monster.

Relacionado: [[Regiones de Impresión]] · [[Ampscript]]

## 6. QA y localización

#qa #localization #smartling **Responsables (múltiples, mencionados en el documento):**

- [[Equipo de Analítica]] — define el uso de palabras como TEST/SEED/PROOF para diferenciar pruebas de envíos reales.
- [[Equipo de Efectividad de Medios Propios]] (Owned Media Effectiveness) — punto de contacto para dudas sobre regiones de impresión.
- Audiencia / partes interesadas (stakeholders) — hacen clic en todos los componentes como parte del QA de alias.
- Smartling (herramienta/proveedor de traducción) — gestiona la localización del contenido.
- Notas adicionales: símbolos ® / ™, superíndices, palabras obligatorias en asuntos de prueba (TEST/SEED/PROOF), comillas rectas vs. tipográficas.
- [[Regiones de Impresión]]: medición de rendimiento por bloque con `BeginImpressionRegion` / `EndImpressionRegion`.
- [[Envío a Smartling]]: elegir "Content Builder Email" como tipo de activo.
- [[Formato de Fecha y Número]]: bloque global que ajusta el formato según el locale/región del destinatario.

Relacionado: [[Ampscript]] · [[Content Builder]]

## 7. Mensajes push

#push #mobile **Responsable:** [[Desarrollador de Correo]] (Email Developer) — construye la plantilla dinámica y configura el PushJobID. No especificado explícitamente en el documento.

- [[Push Message]] dinámico: plantilla que obtiene copy y urls según el idioma/región del miembro.
- Extensión de datos de contenido de push (similar a Content Matrix).
- [[PushJobID]]: nuevo identificador para vincular el rendimiento del push con visitas, reservas e ingresos.

Relacionado: [[Enlaces y Tracking]] · [[Nomenclatura y Estructura]]

---

## Mapa de relaciones

`[[Nomenclatura y Estructura]] → [[Diseño en Figma]] → [[Content Builder]] → [[Personalización Dinámica]] → [[Enlaces y Tracking]] → [[QA y Localización]] → [[Push Message]]`

## Tabla de responsables

#roles

|Etapa|Responsable|¿Explícito en el documento?|
|---|---|---|
|Nomenclatura y estructura|[[Desarrollador de Correo]]|No — inferido|
|Diseño en Figma|[[Equipo Creativo]]|Sí|
|Creación en SFMC|[[Desarrollador de Correo]]|No — inferido|
|Personalización dinámica|[[Desarrollador de Correo]]|No — inferido|
|Enlaces y tracking|[[Desarrollador de Correo]] + audiencia/stakeholders (QA)|Parcial|
|QA y localización|[[Equipo de Analítica]], [[Equipo de Efectividad de Medios Propios]], stakeholders, Smartling|Sí|
|Mensajes push|[[Desarrollador de Correo]]|No — inferido|

> [!note] El documento fuente solo nombra explícitamente al **equipo creativo**, al **equipo de analítica** y al **equipo de efectividad de medios propios**. Los demás roles se infieren del contexto (quien ejecuta cada acción), no de una asignación formal documentada.
![[proceso_ihg_con_responsables.png]]
#resumen #proceso #el-grupo
