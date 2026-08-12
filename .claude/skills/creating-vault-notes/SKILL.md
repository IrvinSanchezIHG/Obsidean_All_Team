---
name: creating-vault-notes
description: Creates new notes and adds structured content to this Obsidian vault following its folder layout, frontmatter, and wikilink conventions. Use when the user asks to create a note, document a process/concept/meeting/campaign, write up something they learned, or file new content into the vault.
---

# Creating vault notes

## Vault map

| Folder | Contents |
|---|---|
| `00. Sistema/Plantillas/` | Templater templates (e.g. `Nota Estándar.md`) — not vault content |
| `00. Sistema/Adjuntos/` | Images/PDFs embedded from notes |
| `01. Personal/` | Personal: goals, performance, career notes |
| `02. Marketing Cloud/02.01 - Campaigns/` | Individual campaign write-ups (one note per campaign) |
| `02. Marketing Cloud/02.02 - Referencia Técnica LFC/` | Sequential SFMC/LFC technical reference topics, files named `NN - Topic.md` (00-20 so far, one concept each) |
| `02. Marketing Cloud/02.03 - Proceso/` | End-to-end process documentation |
| `03. Onboarding/` | Broader onboarding: HR, role-level master notes, dated session notes (`LFC_YYYYMMDD_Topic.md`) |
| `04. Bugs bank/` | Bug/defect entries — use the `logging-bugs` skill for these, not this one |
| `05. Glosario/` | What a third-party app/tool/concept *is* (vendor, product, general capabilities) — independent of any one process. See `05. Glosario/00 - Índice de Glosario.md`. Don't confuse with `02.02 - Referencia Técnica LFC/`, which documents how a tool is used *within* the LFC workflow specifically; a tool can have a note in both places (e.g. `Smartling` here, `Translation Workflow` there) |
| `06. Personas y Equipos/` | People, teams, and roles involved in the LFC process. Flat folder, no subfolders. Person notes carry `role` and `org: IHG\|GALE` in frontmatter. Gerardo and his team ([[Guadalajara Email Marketing Team]], alias GDL) are **IHG-internal** — IHG is in-sourcing the Lifecycle email marketing service that the agency **GALE** used to run; GALE is transferring process knowledge (via Anu, Kapil) before discontinuing it. Don't assume GALE = Gerardo's employer, that was true historically but not currently. Team/role notes use `aliases` to converge ES/EN spelling variants (e.g. `Creative Services` ↔ `Equipo Creativo`) onto one note. See `00 - Índice de Personas y Equipos.md` |

Folder names carry no meaning to Obsidian's own link resolution (wikilinks match by filename/alias, not path), so moving a note between these folders never breaks a link — only renaming the note itself does.

When the target folder isn't obvious, ask which of these fits, or default to the folder of the most closely related existing note.

## Before creating a note

1. Glob `**/*.md` and check whether a note with the same or a very similar title already exists (including as a dangling wikilink target — see `auditing-vault-links`). Prefer extending an existing note over creating a near-duplicate.
2. Pick the folder using the map above.
3. Pick a filename matching the convention already used in that folder:
   - `02.02 - Referencia Técnica LFC/`: next sequential number, e.g. `21 - New Topic.md`
   - `03. Onboarding/` dated sessions: `LFC_YYYYMMDD_Topic.md`
   - Everywhere else: `Title Case.md` matching the note's H1

## Frontmatter

Every new note follows `00. Sistema/Plantillas/Nota Estándar.md` (the Templater template). When creating a note by hand rather than via Templater, match its shape:

```yaml
---
aliases: []
tags:
  - topic-one
  - topic-two
created: 2026-08-09
status: Draft
---
```

- `aliases`: only add entries other notes actually link to (check `auditing-vault-links`'s dangling-link output) — not speculative alternate names. This is the fix for the vault's numbered files (`NN - Topic.md`): the alias holds the clean concept name so `[[Topic]]` resolves from anywhere.
- `tags`: no `#` prefix inside frontmatter — Obsidian strips it but the clean form is bare words. Use existing tags from other notes where the concept overlaps (grep for `tags:` blocks first) rather than inventing synonyms.
- `created`: today's date, ISO `YYYY-MM-DD`.
- `status`: `Draft`, `Active`, or `Done` (matches the one existing convention in this vault).

## Body structure

- Start with an H1 matching the filename.
- Optionally follow with a collapsed `> [!abstract]- Resumen` callout (one or two sentences) for longer/reference notes — skip it for short glossary-style notes where the H1 already says everything.
- For technical/process topics, close with a `## Relacionado` (or `## Related`) section linking connected concepts — this vault already uses that pattern.
- End with the auto-updating backlinks block used across the vault (Dataview must be installed):
  ````
  > [!info]- 🔗 Enlaces entrantes
  > ```dataview
  > LIST
  > FROM [[<exact filename, no extension>]]
  > WHERE file.path != this.file.path
  > ```
  ````
  Use the literal filename (with any numeric prefix), not an alias — it's what Dataview needs to match.
- Prefer tables for metrics/success-criteria style content when the source note nearby does the same (see `01. Personal/Gerardo Aviña - FY2026 Goals.md` for the pattern).
- Content in this vault is a Spanish/English mix — match the language of the folder/section you're writing into rather than forcing one language.

## Wikilinks, not plain text

Any time you write the name of a concept, process, tool, or person that has (or should have) its own note, link it: `[[Concept Name]]`. Don't repeat the same phrase as plain text in one note and as a link in another — check existing notes for how a concept is already titled/linked before introducing a new spelling.

It's fine to link to a concept that doesn't have a note yet (a dangling link) — that's how this vault tracks what needs writing up next. Don't feel obligated to create a stub for every link; that's a periodic `auditing-vault-links` job, not something to do on every edit.

For full Obsidian Flavored Markdown syntax (embeds, callouts, block references, etc.), see [reference/obsidian-markdown-syntax.md](reference/obsidian-markdown-syntax.md).
