---
name: capture-course
description: "Use when Amelia drops in or photographs a syllabus, assignment sheet, rubric, or course page and wants it understood — extract deadlines, requirements, weights, and what the professor expects, organized into course memory."
---

# Capture Course

Turn a pasted or photographed course document into quiet, internal course memory, then immediately answer the real question Amelia almost always has when she shares one: what is coming due. This skill reads what she hands it, organizes the durable facts into files in her own data root, and shows her her next deadlines — never a report bragging that it created files.

## What this skill is for

Amelia shares a syllabus, an assignment sheet, a grading rubric, a course web page, or a photograph of any of those, and says little or nothing structured. This skill:

- reads the document silently;
- pulls out the durable facts — deadlines, grade weights, requirements, professor expectations, and anything ambiguous;
- writes them into her course memory, preserving where each fact came from;
- marks anything unclear as an open question instead of guessing;
- and shows her, as the very first thing, the answer to "what is coming up" — her next deadlines.

## What this skill must never do

- Never create anything outside her own data root. Everything written goes under the directory she controls (see "Where everything is written" below). Nothing is ever written into this plugin, into the builder's repository, vault, git history, or sync.
- Never create an external task, a calendar event, an email, or anything that leaves her machine. This skill only reads what she pasted and writes plain files she owns.
- Never invent a fact to fill a gap. If the document does not state a due date, a weight, or a requirement, record an open question — do not estimate.
- Never fabricate a source. Every fact carries the document it came from; if a fact has no source, it does not get written as a fact.
- Never lead with bookkeeping. The first thing Amelia sees is her next deadlines, not a confirmation that files were made. The course-memory files are an invisible byproduct she is never asked to look at or fill in.

## Where everything is written

All output is written to Amelia's own data root — the directory she alone controls, learned only from the variable she sets. Read it from the environment variable `AMELIA_DATA_ROOT`. If that variable is not set, do not guess a path and do not write into this plugin or any nearby repository: tell her in one short sentence that her data root is not set yet and stop. This is the structural guarantee that her course life never lands in anyone else's space.

Within her data root, one folder per course:

```text
<AMELIA_DATA_ROOT>/
  courses/
    <course-slug>/
      course-memory.md
      assignments.md
      source-index.md
      sources/
        <captured-source-files>
```

The exact field layout for each of these files is in the reference, which is the single source of truth for the schema:

- [references/course-memory-schema.md](references/course-memory-schema.md)

The privacy and academic-integrity posture this skill operates under is shared across the whole plugin and lives in one place; read it if any judgment call about ownership or boundaries comes up:

- [../../references/coaching-contract.md](../../references/coaching-contract.md)
- [../../references/consent-model.md](../../references/consent-model.md)

## Decision procedure

Work through these steps in order. Keep everything quiet until the final step, where the only visible output is her next deadlines.

### Step 1 — Confirm the data root before touching anything

Read `AMELIA_DATA_ROOT`. If it is missing or empty, stop and say, in one plain sentence, that she needs to set her data-root path first. Do not write a single file outside it. Do not fall back to a default location.

### Step 2 — Read what she shared

Read every document she handed over — pasted text, an attached file, or a photograph. For a photograph, transcribe the visible text faithfully. Read the whole thing before extracting anything; a weight on page three changes how you read page one.

If part of an image is unreadable — a blurry table cell, a cut-off line, a column that ran off the edge of the photo — do not guess what it said. Note exactly which part could not be read; it becomes an open question in Step 5.

### Step 3 — Identify the course and find or create its folder

Determine which course this document belongs to from the document itself (course title, course number, department, professor, term). Form a short, readable course slug from that — for example, a recognizable short name plus the term.

- If a folder for this course already exists under `courses/`, you are adding to existing memory, not starting over. Merge: keep what is still true, update what changed, and never silently overwrite a fact that has a different source — record both and flag the conflict as an open question.
- If no folder exists, create `courses/<course-slug>/` and its `sources/` subfolder.

If you genuinely cannot tell which course a document belongs to, ask her one short question rather than filing it under a guess.

### Step 4 — Extract the durable facts

Pull these out of the document, and only what the document actually supports:

- **Deadlines** — every dated thing she must do: assignments, exams, quizzes, drafts, presentations, readings with a due date. Capture the title, the due date (and time if stated), and what kind of thing it is.
- **Grade weights** — how much each item or category is worth, if stated.
- **Requirements** — what each deliverable must contain: length, format, sources required, submission method, allowed and disallowed tools, group versus individual.
- **Professor expectations and policies** — late policy, attendance policy, academic-integrity policy, office hours, contact preference, participation expectations, anything that tells her how this professor wants to be worked with.

Record each fact with the source it came from. A fact with no traceable source does not get written as a fact — it becomes an open question.

### Step 5 — Mark ambiguity instead of resolving it

Anything the document leaves unclear, contradictory, or unreadable becomes an explicit open question, not a guess:

- a deadline given as "end of week" with no date;
- a weight that does not add up to one hundred percent;
- a requirement that could be read two ways;
- a table cell or line the photo could not show;
- a conflict between this document and something already in memory.

Write each as an open question in `course-memory.md` per the schema. The honest answer "the document does not say" is always better than a confident wrong date.

### Step 6 — Write the memory, quietly

Write or update `course-memory.md`, `assignments.md`, `source-index.md`, and save a copy of each captured source under `sources/`, all per [references/course-memory-schema.md](references/course-memory-schema.md). Preserve provenance: every assignment and every fact points back to the source file and, where possible, the place within it. This is bookkeeping; do not narrate it to her.

### Step 7 — Show her the real answer first

The only thing she sees is the answer to the question she actually had: her next deadlines. Pull the soonest-due items across this course (and, if she has other courses already captured, across all of them) and show a short, ranked list — roughly her next three to five deadlines, soonest first, each with what it is, the course, and when it is due.

Keep it short and in plain language. No wall of text, no table of everything you parsed, no count of files written. If something important was ambiguous — a major deliverable with no clear date — surface that as a single honest line ("one thing was unclear: the midterm date is not stated — want me to flag it?"), not as a report.

If she has clearly asked a different question than "what is due" (for example, "how much is the final worth?" or "when are office hours?"), answer that question first instead, grounded in what you just captured. This holds only for questions about how the course works — deadlines, weights, policies, requirements, office hours, submission method. If she instead asks for the substance being graded — an answer to an assigned problem, a draft of an essay, a worked solution, anything she could submit — do not answer it here. Say in one short line that this skill captures the course and that the `coach-me` skill will help her actually work through it, and hand off to coaching.

## After capture

Once the document is in memory, her ongoing questions are served by the other skills, which read the same files:

- "What does my week look like?" → the `plan-week` skill reads these deadlines and her review ledger.
- "How does this course work / what does this rubric want?" → the `check-syllabus` skill answers from these same source-grounded files.
- "Help me understand / quiz me / prep for office hours" → the `coach-me` skill, which runs inside the coaching boundary.

This skill's only job is to make those possible silently and to hand her, on the spot, the one answer she came for.
