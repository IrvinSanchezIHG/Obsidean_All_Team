---
aliases:
  - "Translation Workflow"
tags:
  - translations
  - smartling
  - localization
  - lfc
created: 2026-08-07
status: Active
---

# Translation Workflow  

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[06 - Translation Workflow]]
> WHERE file.path != this.file.path
> ```

  

## Build Inicial  

  

Todo inicia en:  

  

USEN  

  

## Smartling  

  

USEN Build  

↓  

[[Smartling]]  

↓  

Traducciones  

↓  

Translation Folder  

  

## Smartling Traduce  

  

- Body Content  

- Assets  

- Legal Copy  

- Content Modules  

  

## Regla de Timing: Cuándo Solicitar Traducción

**No** enviar a traducción inmediatamente después de terminar el desarrollo. Flujo correcto:

`Desarrollo USEN → QA → Aprobación interna → Aprobación del Campaign Team/cliente → Solicitud de traducción a Smartling`

**Motivo**: si USEN se modifica después de haberse enviado a traducción, los cambios no se propagan automáticamente a los demás idiomas — hay que replicarlos manualmente en cada uno. Ver [[LFC_20260812_La agencia Training - Translation Project Walkthrough]].

## Al Recibir las Traducciones

1. **Duplicar** el correo USEN aprobado.
2. Los emails regresan de Smartling con el idioma agregado **entre paréntesis** al nombre — renombrar según la convención interna de naming.
3. Actualizar el campo de idioma en las [[Email Properties]] (ej. `USEN` → `EUFR`).
4. Pegar manualmente el contenido que Smartling no traduce (fuera del HTML): subject line, preheader, variables AMPscript — ver [[Subject & Preheader Localization]].
5. Revisar links dinámicos vía [[Link Matrix (LinkHelper)]].

## Excepción: Regla USCN

Cualquier cambio en la versión **USCN** del email requiere un **reenvío completo** del mail (no parcial) y **rehacer la solicitud de traducción desde cero**.

## Relacionado  

  

[[Smartling]]  

[[Subject & Preheader Localization]]  

[[Localization]]  

[[Figma Assets]]  

  

`#translations #smartling #localization #lfc`