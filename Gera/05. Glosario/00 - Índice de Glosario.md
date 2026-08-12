---
aliases:
  - "Glosario"
  - "Índice de Glosario"
tags:
  - glosario
  - index
  - moc
created: 2026-08-10
status: Active
---

# Índice de Glosario

Referencia de apps, herramientas y conceptos que se mencionan en varias notas del vault pero no pertenecen a un solo proceso — a diferencia de [[00 - Marketing Cloud Onboarding|02.02 - Referencia Técnica LFC]], que documenta *cómo* se usan las cosas dentro del flujo LFC, esta carpeta documenta *qué son* las cosas en sí (el proveedor, su producto, sus capacidades generales).

## Cuándo usar esta carpeta vs. la Referencia Técnica

- **Aquí**: la herramienta/concepto existe independientemente del proceso LFC (quién la hace, qué ofrece en general, otros clientes).
- **En `02.02 - Referencia Técnica LFC`**: cómo usamos esa herramienta específicamente dentro del flujo de campañas (pasos, reglas, convenciones propias).

Un concepto puede tener una nota en cada lugar — por ejemplo [[Smartling]] (qué es, aquí) y [[Translation Workflow]] (cómo la usamos, en Referencia Técnica).

## Entradas

```dataview
TABLE tags AS "Tags", status AS "Estado"
FROM "05. Glosario"
WHERE file.name != this.file.name
SORT file.name ASC
```
