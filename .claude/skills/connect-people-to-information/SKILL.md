---
name: connect-people-to-information
description: "Use this skill whenever the user wants to turn meeting transcripts (or recorded/spoken discussions) into a bridge between people and the information they need. Triggers include: 'who said X', 'who owns this', 'who knows about Y', 'who do I talk to about Z', 'what did we decide', 'find the expert', 'route this to the right person', extracting decisions/action items/owners from a transcript, building a who-knows-what map, or connecting a question to the person who has the answer. Use when the raw material is a transcript and the goal is to link a person to a fact, a fact to an owner, or a question to an expert. Do NOT use for generic meeting summaries with no people-routing intent, or for creating the transcript itself."
license: Proprietary
---

# Connect People to Information with Transcripts

## Overview

A transcript is a record of **who said what, when**. That structure makes it the single best source for answering three recurring questions:

1. **Person → Information**: "What does *this person* know / own / need?"
2. **Information → Person**: "Who said this? Who owns this? Who do I route this to?"
3. **Question → Expert**: "I have a question about X — who is the right person to ask?"

The job of this skill is to move from *raw dialogue* to a *routable answer*: a named person, an attributable statement, and a clear next step — always traceable back to a specific moment in the transcript.

## Quick Reference

| Intent | What to extract | What to deliver |
|--------|-----------------|-----------------|
| Who said X | Speaker + verbatim/paraphrase + timestamp | Attributed quote with source |
| Who owns X | Speaker who accepted the task + due date | Owner + deadline + dependency |
| Who knows about X | Speakers who spoke with authority on the topic | Ranked shortlist of experts |
| What did we decide | Decision statement + who made/agreed to it | Decision log entry with owner |
| Who do I ask | Topic → mapped person → contact path | Routing recommendation |

## Core Principles

1. **Always attribute.** Never surface a fact without naming the speaker and pointing to where it was said. An unattributed claim is not "connected" — it's just floating text.
2. **Distinguish signal types.** A transcript contains four different things; keep them separate:
   - **Statements of fact** ("The vendor delivered on the 12th.")
   - **Decisions** ("We'll route APAC hotel names to human review.")
   - **Commitments / action items** ("I'll send the glossary by Friday." — owned by the speaker.)
   - **Open questions** ("Not sure who confirms the style guide.")
3. **Ownership follows the voice.** The person who *says* "I'll do X" owns X. Do not assign ownership to people who were merely mentioned or invited — only to speakers who accepted.
4. **Expertise = who spoke with authority.** Rank someone as a topic expert when they answered questions, made calls, or corrected others on that topic — not just because the keyword appears near their name.
5. **Preserve uncertainty.** If a speaker hedged ("I think", "not confirmed"), carry that hedge forward. Don't harden a maybe into a fact.
6. **Never infer beyond the transcript.** If who-owns-what or who-decided is genuinely unclear, say so and flag it as an open item to resolve — do not guess.

## Workflow

### Step 1 — Frame the question
Decide which of the three connection types the user needs (Person→Info, Info→Person, Question→Expert). This determines what you extract.

### Step 2 — Pull the transcript(s)
Search the **transcripts** domain first, and pair it with a **meetings** domain search for context (attendees, date, purpose). If multiple meetings are relevant, gather them before answering so nothing is missed.

### Step 3 — Extract into a people-anchored structure
Parse the dialogue into rows anchored on a **person**, not on a topic:

```
Speaker | What they said (topic) | Type (fact/decision/commitment/question) | Timestamp
```

### Step 4 — Map information to people
Build the connection the user asked for:
- **Who-knows-what map**: topic → person(s) who spoke authoritatively.
- **Ownership log**: commitment → owner → due date → dependency.
- **Decision log**: decision → who agreed → when.

### Step 5 — Deliver a routable answer
Give the user a **named person + attributed evidence + next step**, e.g.:
> *For APAC hotel-name conventions, talk to **Karen Tostado** — in the Aug 10 sync she confirmed ANA Crowne Plaza Chiryu keeps the brand name untranslated (`~14:20`). Open question she raised: the style guide hasn't been formally updated.*

Then, when useful, offer to draft the outreach (email/chat) to that person.

## Output Formats

Match the format to the intent (keep it lean and scannable):

- **Routing answer** — short prose: person, why them, evidence, one next step.
- **Who-knows-what map** — table: `Topic | Go-to person | Backup | Evidence`.
- **Action items** — grouped **by owner** with due dates (the default for commitments).
- **Decision log** — table: `Decision | Owner | Agreed by | Date/timestamp`.

## Quality Bar (self-check before answering)

- [ ] Every fact is attributed to a named speaker.
- [ ] Every commitment has an owner who actually accepted it out loud.
- [ ] Experts are ranked on demonstrated authority, not keyword proximity.
- [ ] Hedges and open questions are preserved, not hardened.
- [ ] Unclear ownership/decisions are flagged, not invented.
- [ ] The user ends with a person to contact and a clear next step.

## Common Pitfalls

- **Confusing "mentioned" with "owns."** Being named ≠ being responsible. Only the accepting speaker owns it.
- **Confusing "attended" with "said."** Invitee lists don't prove participation — attribute only to actual speakers in the transcript.
- **Flattening the room into consensus.** Note disagreement and dissent; the person who *objected* is often the right one to route to.
- **Dropping the timestamp.** Without a locator, the connection isn't verifiable.

## Do NOT use this skill to
- Evaluate, rank, or judge a person's performance, competence, or contribution. This skill maps *who knows/owns what*, not *who is good at their job*.
