---
aliases:
  - "Subject & Preheader Localization"
tags:
  - subject-line
  - preheader
  - localization
  - translation-de
created: 2026-08-07
status: Active
---

# Subject & Preheader Localization  

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[07 - Subject & Preheader Localization]]
> WHERE file.path != this.file.path
> ```

  

## Excepción  

  

Smartling NO traduce:  

  

- Subject Line  

- Preheader  

  

## Flujo  

  

Subject + Preheader  

↓  

Translation Request Form  

↓  

Translation Team  

↓  

Approved Translation  

  

## Translation DE  

  

Almacena:  

  

- Content ID  

- Locale  

- Subject  

- Preheader  

  

## Variantes por Content ID

Un mismo email puede tener varios subject lines/preheaders controlados por [[Content ID]] (ej. `B1`, `B2`, `A1`, `A2`). Para traducir cada variante: Smartling llena el documento de traducciones → el desarrollador identifica el Content ID correspondiente → copia manualmente esa traducción al AMPscript. Ver [[LFC_20260812_La agencia Training - Translation Project Walkthrough]].

## Relacionado  

  

[[Translation Workflow]]  

[[Content ID]]  

[[AMPscript]]  

[[TreatAsContent]]  

  

`#subject-line #preheader #localization #translation-de`