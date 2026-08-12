---
aliases:
  - "Link Matrix (LinkHelper)"
  - "Link Matrix"
  - "LinkHelper"
  - "Link Helper"
  - "Link Data Extension"
tags:
  - sfmc
  - ampscript
  - links
  - localization
  - lfc
created: 2026-08-12
status: Active
---

# Link Matrix (LinkHelper)

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[22 - Link Matrix (LinkHelper)]]
> WHERE file.path != this.file.path
> ```

> [!abstract]- Resumen
> Data Extension compartida, una por campaña, que centraliza el AMPscript de cada link/CTA del email para que resuelva automáticamente a la URL correcta según el **Region Language Code** del contacto. El "link helper" es el mecanismo/variable AMPscript que hace esa resolución; el "Link Matrix" es la DE que lo alimenta.

## Origen del contenido

El contenido del **URL matrix** (qué URL final corresponde a cada mercado/idioma) lo entrega el **Campaign Team de IHG** — quien lidere esa campaña específica — según explicó [[Aruni Patel]] en [[LFC_20260812_GALE Training - Translation Project Walkthrough]]. Esto se integra al [[CRF]] (que arma el Business Analyst) como parte de su matriz de links/tracking.

La **implementación técnica** de esa matriz como Data Extension en SFMC la construye el **equipo [[GALE]]**, no el [[Data Team]] — es una práctica del equipo de desarrollo para optimizar el contenido dinámico, no un entregable del lado de datos.

## Estructura de la Data Extension

- **Ubicación**: `Shared Items > Shared Data Extensions > 01_LFC_DE > [Año] > [Categoría de campaña] > [Sub-campaña]`
- **Convención de nombre**: `LinkMatrix_[Campaña]_[Año]`
- **Ejemplo real**: `LinkMatrix_Enrolment_Booking_2026`, en `.../01_LFC_DE/2025/Digital Enrollment/Booking Reminder/`

Columnas: una fila por `language` ([[Region Language Codes|código región+idioma]]), y una columna por cada link/CTA distinto del email (ej. `book`, `Footer_Textcta_TC1`). Cada celda contiene el snippet de AMPscript completo para ese link:

```
%%=RedirectTo(Concat('https://www.ihg.com/hotels/',@linkhelper_rgn_lang,'/reservation?offerId=DE046&',@track_param))=%%
```

```
%%=RedirectTo(Concat('https://www.ihg.com/content/',@linkhelper_rgn_lang,'/customer-care/member-tc?',@track_param))=%%
```

El único valor que varía entre mercados dentro de esa fórmula es `@linkhelper_rgn_lang` — el resto de la composición del link (URL base + `@track_param`) es constante. Ver también la composición general del link documentada en `02.03 - Proceso/Proceso Global de Creación de Correos Electrónicos IHG 2024` (sección 5, Enlaces y tracking).

## Uso en el build del email

Cada anchor tag lleva, además de la URL final, un **alias name** que sigue la convención del Link/URL Matrix del CRF (ej. `mod1_headlineBonus`). El `@linkhelper_rgn_lang` resuelve automáticamente la variante correcta según el Region Language Code del contacto — la misma referencia de link puede apuntar a la página global en inglés o a la página en japonés sin mantener una URL distinta escrita a mano por idioma. Detalle práctico de build en [[LFC_20260508_Lifecycle Email Build & Journey Setup]].

## Validación en QA

Al recibir traducciones, se revisan los links usando el Link Matrix/LinkHelper para confirmar que sean **dinámicos** (no URLs estáticas hardcodeadas) — si el Region Language Code configurado no coincide con la región real del contacto, el link puede redirigir a una versión incorrecta (ej. cae por default a `USEN`). Ver [[LFC_20260812_GALE Training - Translation Project Walkthrough]].

## Relacionado

[[CRF]]
[[Region Language Codes]]
[[Translation Workflow]]
[[Email Properties]]
[[GALE]]
[[LFC_20260812_GALE Training - Translation Project Walkthrough]]
[[LFC_20260508_Lifecycle Email Build & Journey Setup]]
