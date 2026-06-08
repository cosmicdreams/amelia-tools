---
name: make-study-aids
description: >
  Build a Google NotebookLM study notebook from Amelia's course materials and turn them
  into study aids she can keep. Use when she wants to generate an artifact from her own
  readings, lecture slides, or notes — a written study guide, an audio overview to listen
  to, a set of flashcards, a printable practice quiz, or a mind map. Trigger phrases:
  "make a study guide from these", "turn my readings into a podcast", "make me a practice
  quiz from this", "make flashcards for this class", "build a notebook for my course",
  "create an audio overview", "mind map these concepts". This runs the Google NotebookLM
  command-line tool, whose command name is notebooklm. Do not use it to extract deadlines
  or requirements from a syllabus or assignment sheet — that is capture-course. Do not use
  it to look up how a course works or to ask a grounded question about her materials — that
  is check-syllabus. Do not use it to understand a concept conversationally — that
  is coach-me. Do not use it to run an interactive check of whether she understands
  something — that is quiz-me; this skill only produces a static quiz to study from.
allowed-tools: Read, Write, Bash
---

# Make Study Aids

Build a Google NotebookLM notebook from Amelia's own course materials and generate study aids from them. This runs the Google NotebookLM command-line tool, whose command is `notebooklm`.

This skill builds study *aids* — guides, audio overviews, quizzes, flashcards, mind maps — from sources Amelia provides. It does not produce graded work for her; what it makes is hers to study from. Her materials and everything generated are hers. See the [consent model](../../references/consent-model.md).

## One-time setup

If the command is missing or not signed in, tell Amelia to run, in a terminal:

```bash
pip install notebooklm-py   # install the tool
notebooklm login            # sign in through the browser with her Google account
```

Then confirm it is ready:

```bash
notebooklm status           # should show "Authenticated as: ..."
```

If `status` fails, have her run `notebooklm login` again.

## Build a notebook for a course or topic

Create the notebook, then add her sources. Use the notebook identifier returned by `create` on the later commands with `--notebook <identifier>`, rather than relying on saved context.

```bash
notebooklm create "Biology 101 — Midterm"
notebooklm source add ./lecture-slides.pdf
notebooklm source add ./reading.pdf
notebooklm source add "https://www.youtube.com/..."    # a recorded lecture, if she has one
notebooklm source list                                  # confirm everything finished processing
```

Add her syllabus, readings, lecture slides, and her own notes as sources. Files, web links, and recorded-lecture links all work.

## Generate study aids (confirm first)

These take a while and write results, so tell her what you are about to generate and let her say yes. Generate from all sources, or target specific ones with `-s <source identifier>`.

```bash
notebooklm generate report --format study-guide   # a written study guide
notebooklm generate audio "Focus on the midterm topics"   # an audio overview she can listen to
notebooklm generate quiz                          # a practice quiz
notebooklm generate report --format briefing-doc  # a short briefing
```

NotebookLM can also make flashcards and a mind map. Check progress with `notebooklm artifact list`.

## Ask her sources a question

Grounded in only her materials, with citations:

```bash
notebooklm ask "What does the rubric say the lab report needs?"
```

## Download what it made (confirm first — this writes files)

Save anything to her own data root, never into this repository:

```bash
notebooklm download report ./study-guide.md
notebooklm download audio ./overview.mp3
notebooklm download quiz --format markdown ./quiz.md
notebooklm download flashcards --format markdown ./flashcards.md
```

## What runs automatically versus what to confirm

- Run without asking: `status`, `list`, `source list`, `artifact list`, `create`, `source add`, `ask` (without saving a note).
- Ask her first: every `generate` command (they are slow), every `download` (they write files), and anything that deletes — deletion is permanent.
