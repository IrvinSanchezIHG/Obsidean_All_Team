---
aliases:
  - "QA Process"
  - "LFC - QA Test Cases y Proofing Process"
  - "QA"
tags:
  - qa
  - preview
  - validation
created: 2026-08-07
status: Active
---

# QA Process  

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[15 - QA Process]]
> WHERE file.path != this.file.path
> ```

  

## Step 1 - Preview  

  

Utilizando:  

  

- Test Lists  

- Set Lists  

  

Sin realizar envíos.  

  

## Se valida  

  

- Variables  

- Subject  

- Preheader  

- Content ID  

- Dynamic Content  

- Traducciones  

- Layout  

- Tracking  

## Rounds — email antes que journey

Confirmado en [[LFC_20260814_La agencia Training - Nearly & Anniversary#5. QA — dos rounds|sesión Nearly & Anniversary]]: el Journey **no** debe ser la primera validación.

1. **Round 1** — QA del email con la primera versión, **antes** de recibir las traducciones (layout, dynamic content, personalización).
2. **Round 2** — QA del email ya con las traducciones recibidas (idioma, traducciones correctas).
3. **Final** — QA integrado con el Journey completo (routing, decision splits, entry criteria, emails asociados) — ver [[Journey Builder#Prueba de Decision Splits (cuando existen)]].

Idealmente no se prueba el Journey hasta tener inglés + todos los idiomas requeridos, para no rehacer validaciones por cambios posteriores.

## Relacionado  

  

[[Internal Send]]  

[[Deployment Plan]]  

[[Tracking]]  
[[Journey Builder]]  
[[LFC_20260814_La agencia Training - Nearly & Anniversary]]  

  

`#qa #preview #validation`