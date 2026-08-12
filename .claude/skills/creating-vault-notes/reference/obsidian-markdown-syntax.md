# Obsidian Flavored Markdown syntax reference

## Contents
- Wikilinks
- Embeds
- Callouts
- Tags
- Highlighting, comments, math, footnotes

## Wikilinks

- Basic: `[[Note Name]]`
- Custom display text: `[[Note Name|Display Text]]`
- Heading in another note: `[[Note Name#Heading]]`
- Block reference: `[[Note Name#^block-id]]` (define the block with a trailing `^block-id` on its own line)
- Heading in the same note: `[[#Heading in same note]]`

Link resolution ignores folder path — `[[Data Extensions]]` resolves to any file named `Data Extensions.md` regardless of which folder it's in, so avoid creating two notes with the same title in different folders.

## Embeds

Prefix a wikilink with `!` to embed the target inline instead of linking to it:

- Full note: `![[Note Name]]`
- Section only: `![[Note Name#Heading]]`
- Image: `![[image.png]]`, resized: `![[image.png|300]]`
- PDF page: `![[document.pdf#page=3]]`

## Callouts

```markdown
> [!note]
> Content here.
```

Common types: `note`, `tip`, `warning`, `info`, `example`, `quote`, `bug`, `danger`, `success`. Add `-` after the type to collapse by default, `+` to expand: `> [!warning]- Collapsed by default`. A custom title goes after the type: `> [!bug] Known issue in DE join`.

## Tags

- Inline in body text: `#tag`, nested: `#parent/child`.
- In frontmatter, no `#` prefix — see the frontmatter section in [SKILL.md](../SKILL.md).
- Valid characters: letters, numbers (not as the first character), underscores, hyphens, forward slashes.

## Other syntax

- Highlight: `==text==`
- Hidden comment (invisible in reading view): `%%text%%`
- Inline math: `$LaTeX$`; block math: `$$LaTeX$$`
- Footnote: `[^1]` with a `[^1]: definition` elsewhere, or inline `^[definition]`
- Mermaid diagrams: fenced ` ```mermaid ` blocks; `class NodeName internal-link;` makes a diagram node a clickable link to the note of that name
