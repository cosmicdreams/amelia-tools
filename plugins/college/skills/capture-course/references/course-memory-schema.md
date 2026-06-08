# Course Memory Schema

This is the single source of truth for the file layout that the `capture-course` skill writes. Every file described here is written to Amelia's own data root — the directory she alone controls, learned only from the environment variable `AMELIA_DATA_ROOT`. Nothing described here is ever written into this plugin, into the builder's repository, vault, git history, or sync. If the data root is not set, none of these files are created.

These files are an internal byproduct. Amelia is never asked to fill them in or even look at them; the skill reads what she pastes and shows her her next deadlines. The structure below exists so that the other skills — `plan-week`, `check-syllabus`, and `coach-me` — can read the same memory reliably.

## Folder layout

One folder per course, under the data root:

```text
<AMELIA_DATA_ROOT>/
  courses/
    <course-slug>/
      course-memory.md      # the durable facts: weights, policies, expectations, open questions
      assignments.md        # every dated deliverable, one row each, with provenance
      source-index.md       # every document captured, with a stable identifier and where it lives
      sources/              # a saved copy of each captured document
        <source-id>.<file-extension>
```

### Course slug

A short, readable folder name formed from the course itself — a recognizable short course name plus the term. It must be stable: when a second document for the same course arrives, the skill finds this existing folder and merges into it rather than creating a duplicate. Use only lowercase letters, digits, and hyphens so the name is safe on any filesystem. For example: `organic-chemistry-fall-2026`.

### Source identifier

Every captured document gets a short, stable source identifier, used to link a fact back to where it came from. It is referenced from `assignments.md` and `course-memory.md`, defined once in `source-index.md`, and used as the filename of the saved copy in `sources/`. Keep it short and human-readable, for example `syllabus`, `rubric-essay-1`, `assignment-3`, `course-page-2026-09-02`.

---

## `course-memory.md`

Holds the durable, mostly-undated facts about how the course works, plus the running list of open questions. Plain Markdown with a small front-matter block and labelled sections.

```markdown
---
course: "Organic Chemistry"
course_number: "CHEM 210"
term: "Fall 2026"
professor: "Dr. Ramirez"
captured_at: 2026-09-02
last_updated: 2026-09-02
---

# Organic Chemistry (CHEM 210) — Course Memory

## Grade weights

| Component | Weight | Source |
|---|---|---|
| Problem sets | 20% | syllabus |
| Midterm exam | 25% | syllabus |
| Final exam | 35% | syllabus |
| Laboratory reports | 20% | syllabus |

## Requirements and expectations

| Topic | What it says | Source |
|---|---|---|
| Late policy | Ten percent off per day, no work accepted after five days late | syllabus |
| Academic integrity | Individual work only on problem sets; collaboration allowed on lab prep | syllabus |
| Office hours | Tuesday and Thursday, two to four in the afternoon, room 414 | syllabus |
| Contact preference | Email; allow one business day for a reply | syllabus |
| Submission method | Uploaded to the course web page as a single document | rubric-essay-1 |

## Open questions

Anything the documents do not settle. Never resolved by guessing — surfaced for Amelia to confirm.

| Question | Why it is open | Source | Status |
|---|---|---|---|
| What date is the midterm? | Syllabus says "mid-October" with no specific date | syllabus | unresolved |
| Do the weights total one hundred percent? | Listed components sum to one hundred percent, but a "participation" line has no weight | syllabus | unresolved |
| What was in the cut-off table cell? | Photograph cropped the right column of the grading table | syllabus | unreadable in source |
```

Rules for this file:

- Every fact row carries a **Source** column naming the source identifier it came from. A fact with no traceable source is not written here as a fact — it becomes an open question.
- When new material updates an existing fact, update the row and set `last_updated`. When new material **conflicts** with an existing fact from a different source, do not overwrite — keep both and add an open question recording the conflict.
- The **Open questions** section is never empty by convention; if everything is clear, the section header remains with a single line stating that nothing is currently ambiguous.

---

## `assignments.md`

Holds every dated deliverable, one row each, so the `plan-week` skill can rank by date and the `check-syllabus` skill can answer "what does this assignment require." Plain Markdown table.

```markdown
---
course: "Organic Chemistry"
course_number: "CHEM 210"
term: "Fall 2026"
last_updated: 2026-09-02
---

# Organic Chemistry (CHEM 210) — Assignments

| Identifier | Title | Type | Due date | Due time | Weight | Requirements | Source | Status |
|---|---|---|---|---|---|---|---|---|
| ps-1 | Problem Set 1 | problem set | 2026-09-12 | 11:59 pm | 4% | Chapters one and two, show all work | syllabus | open |
| lab-1 | Laboratory Report 1 | lab report | 2026-09-19 | in class | 5% | Maximum five pages, results and discussion sections required | syllabus | open |
| essay-1 | Reaction Mechanism Essay | essay | 2026-10-03 | 11:59 pm | 10% | 1500 words, at least three peer-reviewed sources, individual work | rubric-essay-1 | open |
| midterm | Midterm Exam | exam | unknown | unknown | 25% | Covers chapters one through six | syllabus | date unknown |
```

Column meanings:

- **Identifier** — a short stable handle for the deliverable, unique within the course; other skills and the review ledger may reference it.
- **Type** — the kind of deliverable: `problem set`, `essay`, `exam`, `quiz`, `lab report`, `presentation`, `reading`, `draft`, or similar.
- **Due date** / **Due time** — written as a specific date and clock time when the document states them. When the document does not, write `unknown` (never an estimate) and ensure a matching open question exists in `course-memory.md`.
- **Weight** — this item's share of the grade, if stated; otherwise leave blank.
- **Requirements** — the short version of what the deliverable must contain; the full detail lives in the source.
- **Source** — the source identifier the row was extracted from. Required for every row.
- **Status** — `open`, `done`, `date unknown`, or `submitted`. The capture skill sets the initial status; it never marks anything done on its own.

Rules for this file:

- One row per dated deliverable. A deliverable with no date still gets a row, with `Due date` set to `unknown` and `Status` set to `date unknown`, so it is not lost.
- Never invent a date. An assumed deadline is worse than an acknowledged unknown.
- When the same deliverable appears in a second document (for example, a syllabus line later detailed by a rubric), merge into the existing row and add the new source — do not create a duplicate row.

---

## `source-index.md`

The provenance registry: every document ever captured for this course, so any fact can be traced back to a real source and the saved copy can be found. Plain Markdown table.

```markdown
---
course: "Organic Chemistry"
course_number: "CHEM 210"
term: "Fall 2026"
last_updated: 2026-09-02
---

# Organic Chemistry (CHEM 210) — Source Index

| Source identifier | Kind | Captured on | Original form | Saved copy | Notes |
|---|---|---|---|---|---|
| syllabus | syllabus | 2026-09-02 | photograph | sources/syllabus.txt | Right column of grading table cropped off |
| rubric-essay-1 | rubric | 2026-09-02 | pasted text | sources/rubric-essay-1.md | Complete |
| assignment-3 | assignment sheet | 2026-09-15 | uploaded file | sources/assignment-3.pdf | Complete |
```

Column meanings:

- **Source identifier** — the short stable handle referenced by `assignments.md` and `course-memory.md`. Unique within the course.
- **Kind** — `syllabus`, `assignment sheet`, `rubric`, `course page`, or `other`.
- **Captured on** — the date the document was brought into memory.
- **Original form** — `pasted text`, `uploaded file`, or `photograph`.
- **Saved copy** — the relative path to the preserved copy under `sources/`.
- **Notes** — quality notes that matter for trust, especially anything unreadable in a photograph or any part transcribed with low confidence.

### The `sources/` folder

A preserved copy of each captured document, named by its source identifier. For pasted text or a transcribed photograph, save the faithful text as `<source-id>.txt` or `<source-id>.md`. For an uploaded file, save it under its source identifier with its original extension. This is what makes every cited fact verifiable later: the other skills, and Amelia herself, can open the exact material a fact came from. These copies live only in her data root.

---

## Provenance and honesty rules that apply to every file here

- Every stated course fact traces to a source identifier that exists in `source-index.md`. No orphan facts.
- A citation is never fabricated. If there is no source, there is no fact — there is an open question.
- Ambiguity is recorded, never resolved by guessing. "The document does not say" is a valid and preferred outcome.
- A conflict between sources is preserved as a conflict, not silently overwritten.
- Nothing here is ever an external task, a calendar event, or a message. These are plain files in Amelia's own data root, and they are hers.
