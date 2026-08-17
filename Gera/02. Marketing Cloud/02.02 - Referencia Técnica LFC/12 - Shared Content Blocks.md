---
aliases:
  - "Shared Content Blocks"
  - "Shared Content"
tags:
  - content-blocks
  - reusable-components
  - localization
created: 2026-08-07
status: Active
---

# Shared Content Blocks  

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[12 - Shared Content Blocks]]
> WHERE file.path != this.file.path
> ```

  

## Filosofía  

  

Antes de desarrollar:  

  

Buscar si ya existe.  

  

## Ejemplos  

  

- Header  

- Footer  

- Legal Copy  

- Dynamic Dates  

- Translation Components  

## Referencia by Key vs. by ID

En el journey `Nearly_Elite_Silver_Deployment_2026` (ver [[LFC_20260814_La agencia Training - Nearly & Anniversary]]) se observó que los content blocks del contenido se referencian a veces **by Key** y a veces **by ID** dentro del mismo build — inconsistencia existente, no un patrón intencional. No se definió en sesión cuál es el estándar a seguir; queda pendiente de confirmar con el equipo.

## Content blocks críticos observados (Nearly)

Ejemplos reales vistos en build, con lógica de la que depende texto dinámico por idioma — validar su impacto antes de modificarlos o eliminar referencias, porque pueden romper múltiples idiomas a la vez:

- `Subject_Preheader_Nearly_LFC` (emails)
- `EDS_Logic_LEV_20220228`
- `Campaign_Configuration_File`

Contienen traducciones, cálculo de noches, cálculo de puntos y texto dinámico por idioma.

## Master Template vs. content blocks nuevos

Recomendación de Alex Wilkinson-Sanchez ([[LFC_20260814_La agencia Training - Nearly & Anniversary#4. Recomendación reforzada — content blocks nuevos, no modificados|detalle]]): al implementar un template nuevo, **crear content blocks nuevos** en vez de modificar los existentes que ya están en producción — evita romper campañas que dependen de los content blocks compartidos actuales. Mismo criterio que para Master Templates: si el cambio es exclusivo de una campaña, no se toca lo compartido, se crea una variante nueva.

## Beneficios  

  

- Reutilización  

- Escalabilidad  

- Consistencia  

  

## Relacionado  

  

[[Dynamic Date Block]]  

[[Email Properties]]  
[[LFC_20260814_La agencia Training - Nearly & Anniversary]]

  

`#content-blocks #reusable-components #localization`