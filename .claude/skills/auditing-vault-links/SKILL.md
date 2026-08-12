---
name: auditing-vault-links
description: Audits this Obsidian vault for dangling wikilinks (links pointing to notes that don't exist), orphaned notes (no incoming links), and inconsistent tag formatting. Use when the user asks to check vault health, find broken or missing links, find orphan/unlinked notes, clean up tags, or asks what's missing or undocumented in the vault.
---

# Auditing vault links

## Run the audit

```powershell
powershell -ExecutionPolicy Bypass -File .claude/skills/auditing-vault-links/scripts/audit-links.ps1
```

This walks every `.md` file (skipping `.obsidian/`, `.claude/`), extracts wikilink targets, and prints:

- **Dangling wikilinks**: `[[Target]]` references with no matching note title, grouped by target. In this vault these are mostly intentional — dangling links are how the onboarding notes track "concepts to write up later" (e.g. `[[Journey Builder]]`, `[[Data Extensions]]`) — so don't treat the count as a problem to eliminate.
- **Orphaned notes**: notes no other note links to. These are worth surfacing because an unlinked note is easy to forget exists.

Pass `-VaultPath <path>` only if running the script from outside its default location; it defaults to the vault root four levels above the script.

## Deciding what to do with results

1. **High-value dangling links** (referenced from 2+ places, or clearly a core concept like `[[AMPscript]]`, `[[Data Extensions]]`): flag these to the user as candidates for a real note, and offer to create a stub (H1 + one-line description + `### Relacionado` back to the notes that reference it) using the `creating-vault-notes` conventions. Don't create stubs unprompted for one-off or clearly minor targets.
2. **Orphaned notes**: check whether it's a legitimate entry point (e.g. `00 - Marketing Cloud Onboarding.md` is meant to be a starting point, not something else links to it) before flagging it as a gap. For anything else, suggest which existing note should link to it.
3. Report duplicate-looking targets that likely mean the same concept (e.g. `Ampscript` vs `AMPscript`, `SFMC` vs `Salesforce Marketing Cloud`) so links converge on one spelling — Obsidian link resolution is exact-match on title, so these currently point to different (non-existent) notes.

## Tag consistency check

This vault currently mixes three tag styles across notes:
- YAML frontmatter list with `#` prefix (non-standard — Obsidian's documented convention is bare words in frontmatter)
- YAML frontmatter list without `#` (correct form, used going forward per `creating-vault-notes`)
- A plain `Tags:` line in the note body with inline `#tag`s (works, but isn't queryable as a frontmatter property)

To audit: grep for `^tags:` and `^Tags:` across the vault, and separately for inline `#\w[\w/-]*` outside frontmatter. Group the results by normalized tag name (case-insensitive, ignoring `#`) and flag near-duplicates (`#SFMC`, `#SalesforceMarketingCloud`) to the user. Don't rewrite existing notes' tags without asking — only apply the clean convention going forward.
