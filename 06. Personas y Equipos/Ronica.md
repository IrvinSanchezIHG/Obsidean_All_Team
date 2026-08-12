---
aliases: []
tags:
  - persona
role: Data / GT
org: IHG
created: 2026-08-11
status: Active
---

# Ronica

Del [[Data Team]] en IHG, trabaja con GT (General Technology). Provee el archivo de audiencia (list pull) — ~75-80% de los emails usan datos de CDP vía Ronica. Valida el list pull antes de entregarlo al Business Analyst para armar el CRF; refresca la data extension con data en vivo antes de cada deployment.

## Relacionado

- [[Data Team]]
- [[02 - CRF]]
- [[LFC_20260505_Lifecycle Campaign Execution]]
- [[2026-08-11]]

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Ronica]]
> WHERE file.path != this.file.path
> ```
