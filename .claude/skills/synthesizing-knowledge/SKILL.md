---
name: synthesizing-knowledge
description: Processes source material (meeting notes, transcripts, documentation, Slack/Teams threads, raw notes) into interconnected notes in this Obsidian vault, and answers questions against what's already documented. Use when the user pastes or shares raw notes/a meeting summary/a document and asks to add it to the vault, update the knowledge base, or when they ask a question that should be answered from prior notes.
---

# Synthesizing knowledge

This vault works as a compounding personal wiki for onboarding into Salesforce Marketing Cloud / Lifecycle Marketing at IHG: each new source should make existing notes better connected, not just add another disconnected page. Three operations: **ingest**, **query**, **lint**.

## Ingest

Given a new source (meeting notes, a transcript, a doc dump):

1. Identify the concepts, processes, and entities it touches.
2. For each one, check whether a note already exists (Glob/Grep by title, including as a dangling wikilink target — a concept already referenced elsewhere but not yet written up is a strong signal it belongs in `02.02 - Referencia Técnica LFC/`).
3. **Existing note covering this** → extend it: add the new information in the right section, don't append a redundant duplicate section. If the source contradicts what's already written, don't silently overwrite — call it out to the user and ask which is current.
4. **No existing note** → create one using `creating-vault-notes` conventions, in the folder that matches the concept (technical SFMC concept → `02.02 - Referencia Técnica LFC/`; process → `02.03 - Proceso/`; campaign → `02.01 - Campaigns/`; a defect the source describes → use `logging-bugs` instead of this workflow).
5. Cross-link: add wikilinks both from the new/updated note to related concepts, and check whether related existing notes should now link back (a `### Relacionado` addition).
6. If the source describes an end-to-end flow, check whether `02.02 - Referencia Técnica LFC/19 - End-to-End Flow.md` needs updating to reflect it.

## Query

When asked a question that prior notes should answer:

1. Grep across the vault for the relevant terms rather than answering from general knowledge.
2. Answer with citations to the specific note (and section/heading if long) the claim came from.
3. If the answer required pulling together several notes and is likely to be asked again, offer to save it as a new note (or a section in the most relevant existing one) rather than letting the synthesis be lost in conversation.

## Lint

Periodic health pass — run when asked to "clean up" or "check" the vault, or proactively after a large ingest:

1. Run the `auditing-vault-links` skill's script for dangling links and orphans.
2. Scan for stale claims: notes with a `created` date but content that reads as time-sensitive (a specific status, a "current" process that may have since changed) — flag these to the user rather than assuming they're still accurate.
3. Look for concepts mentioned in 2+ notes that still have no note of their own — these are the highest-value stubs to propose.

## Philosophy

Act as a guide, not an enforcer: this vault's structure (numbering, tags, frontmatter) has emerged organically and is intentionally light. Co-evolve format with the user rather than imposing rigid schema — if a source doesn't fit the existing patterns well, ask rather than forcing it.
