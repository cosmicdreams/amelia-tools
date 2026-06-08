# Review Ledger Schema

This file defines the spaced-retrieval review ledger that the self-testing mode writes to. The self-test loop in [tutoring modes](tutoring-modes.md#mode-two-self-testing-predict-reveal-compare) records its outcomes here; the weekly planning loop reads from here to surface concepts due for review alongside her deadlines. That one shared file is what turns a pile of one-off study sessions into a system that compounds — spaced retrieval has the strongest evidence base in all of learning science.

The ledger is hers. It lives in her own data root, one ledger per course, and it is never written anywhere the builder can read. It is her honest private model of what she knows, and it surveils no one. The [consent model](../../../references/consent-model.md) describes why the data root is hers alone; the [coaching contract](../../../references/coaching-contract.md) is the source of the expanding-interval rule restated below.

---

## Where it lives and what it is called

One Markdown file per course, named `review-ledger.md`, inside that course's folder in her data root. You learn the data-root path only from the variable she sets — never default to any location, and if you do not know it, ask her. You may write to this file and to her own study notes, and to nothing else.

If a course has no ledger yet, create it with the header row below the first time the self-test needs to record a miss. Do not create empty ledgers preemptively; the file appears the first moment it has something real to hold.

---

## The table

The ledger is a single Markdown table with exactly these eight columns, in this order:

```markdown
| Concept | Source | Last seen | Times correct | Times missed | Next due | Confidence (self) | Confidence (demonstrated) |
|---|---|---|---|---|---|---|---|
```

Column by column:

- **Concept** — a short, plain name for the idea being tracked, in her register, specific enough that future-her knows exactly what it means. "Why confidence intervals narrow with sample size," not "stats stuff."
- **Source** — where the concept comes from in *her* materials: the reading, the lecture, the chapter, the section of the syllabus. This is what lets the micro-review step pull the right source through the grounded-answer behavior. Never fabricate a source; if the material does not pin it down, write what you honestly can and mark it uncertain.
- **Last seen** — the date she was last tested on this concept, written as four-digit year, two-digit month, two-digit day (for example, 2026-09-01). Update it every time the concept comes up in a self-test, hit or miss.
- **Times correct** — a running count of correct answers on this concept across all sessions. Increment on a correct (re-)test.
- **Times missed** — a running count of misses. Increment on a miss.
- **Next due** — the date the weekly loop should resurface this concept for review, in the same four-digit-year, two-digit-month, two-digit-day form. Set by the expanding-interval rule below.
- **Confidence (self)** — her own most recent self-reported confidence on this concept, from the predict step: `guessing`, `fairly sure`, or `certain`.
- **Confidence (demonstrated)** — what she actually showed: `correct` or `missed` on the most recent test. The gap between this column and the previous one is the calibration signal — a `certain` paired with a `missed` is the highest-value row in the whole ledger.

---

## The expanding-interval rule for `Next due`

When she misses an item, write the concept into the ledger (or update its existing row) and set `Next due` using a spaced, *expanding* interval measured from the date of the test:

- **First time correct after entering the ledger:** set `Next due` to **two days** out.
- **Correct again on the next review:** push `Next due` to **seven days** out.
- **Correct again after that:** push `Next due` to **twenty-one days** out.
- **Correct after twenty-one days:** the concept is well learned; you may push it further out at your judgment (for example, the next interval beyond twenty-one) or, if she is confidently and demonstrably solid, mark it as retired from active review — but never delete its history.

The ladder of intervals is: **two days, then seven days, then twenty-one days.** Each correct re-test moves the concept up one rung of the interval ladder.

**Any miss resets the interval all the way back to two days,** no matter how far along the ladder the concept had climbed. A concept she missed today is due again in two days, full stop. Resetting on a miss is what guarantees that the things she does not know come back fast, while the things she does know fade quietly into the background.

### Worked example of a row over time

1. Self-test on 2026-09-01. She is `certain` but misses "Why confidence intervals narrow with sample size." Row created: `Times missed` = 1, `Confidence (self)` = certain, `Confidence (demonstrated)` = missed, `Last seen` = 2026-09-01, `Next due` = 2026-09-03 (two days).
2. Re-test on 2026-09-03 with a fresh item; she gets it. `Times correct` = 1, `Last seen` = 2026-09-03, `Confidence (demonstrated)` = correct, `Next due` = 2026-09-10 (seven days).
3. Review on 2026-09-10; correct again. `Times correct` = 2, `Last seen` = 2026-09-10, `Next due` = 2026-10-01 (twenty-one days).
4. If she had missed it on 2026-09-10 instead, `Times missed` would go to 2, `Confidence (demonstrated)` to missed, and `Next due` would reset to 2026-09-12 (two days).

---

## How the close-the-loop step writes to the ledger

The self-test does not record a miss and walk away — that would be an open loop. Following the close-the-loop cycle, you only finalize a row after the full sequence: detect the gap, micro-review only that gap, re-test with *fresh* items, and then record. So a single self-test session typically writes a row twice: once when the miss is first detected, and again after the fresh-item re-test updates the counts, the demonstrated confidence, and the `Next due` interval. Always write the *re-test* result, never just the initial miss, so the ledger reflects where she actually ended the session.

## What the weekly loop expects from this file

The weekly "What does my week look like?" loop reads every course's `review-ledger.md`, finds rows whose `Next due` is on or before the current date, and surfaces them as "concepts due for review" beside her deadlines. For that to work, keep `Next due` accurate and in the four-digit-year, two-digit-month, two-digit-day form on every row. The weekly loop only reads; this skill is the only writer.
