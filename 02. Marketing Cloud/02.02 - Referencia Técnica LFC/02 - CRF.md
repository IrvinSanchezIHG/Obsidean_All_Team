---
aliases:
  - "CRF"
tags:
  - crf
  - requirements
  - lfc
  - sfmc
created: 2026-08-07
status: Active
---

# CRF (Campaign Requirements File)  

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[02 - CRF]]
> WHERE file.path != this.file.path
> ```

  

## Fuente de Verdad  

  

Todo comienza en el CRF.  

  

Contiene:  

  

- Email Details  

- Subject Line  

- Preheader  

- MRM ID  

- Content ID  

- Assets  

- Tracking Requirements  

- Traducciones  

- Business Requirements  

  

## Email Name  

  

Origen:  

  

CRF  

↓  

Email Details  

↓  

Email Name  

  

Debe copiarse exactamente.  

  

## Link/URL Matrix

El contenido del URL matrix (qué URL corresponde a cada mercado/idioma) lo entrega el **Campaign Team de IHG**, según explicó [[Aruni Patel]] — se integra al CRF que arma el Business Analyst. La implementación técnica como Data Extension en SFMC vive en [[Link Matrix (LinkHelper)]].

## Relacionado  

  

[[Email Build Process]]  

[[Email Properties]]  

[[Content ID]]  

[[Translation Workflow]]  

[[Link Matrix (LinkHelper)]]  

[[2026-08-11|Dudas de Estudio — CRF y List Pull]]  

[[Ronica]]  

  

`#crf #requirements #lfc #sfmc`