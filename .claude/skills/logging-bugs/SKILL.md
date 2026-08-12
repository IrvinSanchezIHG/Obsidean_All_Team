---
name: logging-bugs
description: Creates structured bug/defect entries in the '04. Bugs bank' folder for issues found in Salesforce Marketing Cloud builds, QA, journeys, or campaign delivery. Use when the user reports a bug, defect, QA finding, or wants to log something broken in an email build, journey, Data Extension, or automation.
---

# Logging bugs

## File

Path: `04. Bugs bank/BUG_YYYYMMDD_short-title.md` — dated prefix matches this vault's existing `LFC_YYYYMMDD_Topic.md` convention used in `03. Onboarding/`. Use today's date and a short kebab/Title-Case slug of the bug.

## Template

```markdown
---
tags:
  - bug
  - <relevant-area, e.g. sfmc, ampscript, data-extension, journey-builder>
created: YYYY-MM-DD
status: Open
severity: <Low | Medium | High | Critical>
---

# <Short bug title>

## Summary
One or two sentences: what's broken and its impact.

## Environment
- **Business Unit / Journey:** 
- **Email / Asset:** 
- **Related process:** [[wikilink to the onboarding/process note this touches, if any]]

## Steps to Reproduce
1. 
2. 

## Expected vs Actual
- **Expected:** 
- **Actual:** 

## Root Cause
(Fill in once known; leave as "Investigating" otherwise.)

## Fix / Workaround


## Related
[[link related bugs, processes, or components]]
```

`severity` guide: **Critical** = production send blocked or wrong content/data sent to guests; **High** = incorrect behavior likely to reach production without a fix; **Medium** = QA-caught defect with a workaround; **Low** = cosmetic or edge-case.

## Workflow

1. Confirm the bug doesn't already have an entry — Glob `04. Bugs bank/*.md` and check titles/summaries first.
2. Fill in every section you have information for; leave placeholders explicit (e.g. `_TBD_`) rather than deleting empty sections, so gaps are visible later.
3. Link the bug to whichever `02.02 - Referencia Técnica LFC/` or `02.03 - Proceso/` note documents the affected process or component — this is what makes the bug bank useful as a pattern log, not just a ticket dump.
4. When a bug is resolved, update `status: Resolved` and fill in **Root Cause** and **Fix / Workaround** rather than deleting the entry — resolved bugs are the most useful ones to search later.

## Board

`04. Bugs bank/Tablero de Bugs.md` is an obsidian-kanban board (Open / In Progress / Resolved). When logging a bug, add a card there linking to the new note: `- [ ] [[BUG_YYYYMMDD_short-title]]`. When resolving one, move its card to the Resolved column instead of deleting it — don't hand-edit the board's `kanban-plugin: board` frontmatter or lane structure beyond adding/moving cards.
