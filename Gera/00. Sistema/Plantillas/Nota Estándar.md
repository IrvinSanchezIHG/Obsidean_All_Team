---
aliases: []
tags: []
created: <% tp.date.now("YYYY-MM-DD") %>
status: Draft
---

# <% tp.file.title %>

> [!abstract]- Resumen
> _Una o dos frases: de qué trata esta nota y por qué importa._

## 

## Relacionado



> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[<% tp.file.title %>]]
> WHERE file.path != this.file.path
> ```
