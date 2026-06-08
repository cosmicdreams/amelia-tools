# amelia-tools

A private collection of personal Claude Code plugins. Its first and only plugin so far is **amelia-student** — a study assistant a college sophomore owns and controls.

This document is written first for the father who builds it, and then for the daughter who owns it. Read it in that order.

## What this is

**amelia-tools** is a private Claude Code marketplace. A marketplace is simply a place Claude Code can install plugins from; this one is private, hosted in a repository that only invited collaborators can read.

**amelia-student** is the first plugin in that marketplace. It is a study assistant. It reads the course materials she hands it, helps her see what her week actually looks like, and coaches her toward understanding her coursework. It is hers: she installs it, she turns it on, and her data lives somewhere only she can read.

## The posture, in one paragraph

amelia-student coaches understanding and planning. It deliberately does not do her work. When she asks it to help with something graded, it will ask what she already knows, walk her up a ladder of hints one step at a time, give her feedback on her own draft, quiz her, and help her prepare questions for office hours — but it will not hand her a finished essay, a full worked solution to an assigned problem, a filled-in answer to a graded question, or code that satisfies an assignment. The test it applies is simple: if deleting her own draft would make its output useless, that output is feedback and it is allowed; if deleting her draft and pasting its output would improve her grade, it did the assignment and it refuses. It holds that line across the whole conversation, not just one message at a time, so it will not reconstruct a submittable draft piece by piece across many turns. It is built to be more useful than cheating, never to police her. She owns it, and she owns her data: her course materials, her review ledger, her plans, and her notes live in a data root she controls, never in this repository and never in anyone else's vault. There is no parent-facing view, and she can stop using it at any time.

## Install (private marketplace)

This marketplace lives in a private repository, so installing it takes two one-time setup steps before the usual plugin commands.

1. **Get read access.** She needs collaborator read access to the `cosmicdreams/amelia-tools` repository. The repository owner grants this once.

2. **Authenticate with GitHub once.** Because the repository is private, Claude Code has to prove it is allowed to read it. In a terminal, run the GitHub command-line tool's login command one time:

   ```
   gh auth login
   ```

   Follow the prompts (choose GitHub.com, then sign in through the browser). This stores credentials so Claude Code can reach the private repository.

3. **Add the marketplace, then install the plugin.** Inside Claude Code, run these two slash commands:

   ```
   /plugin marketplace add cosmicdreams/amelia-tools
   /plugin install amelia-student@amelia-tools
   ```

   The first time the plugin is installed, Claude Code shows a one-time trust prompt asking whether to trust this marketplace and plugin. Accept it to finish the installation.

## Turn on tutor mode

Installing the plugin makes the study assistant available; turning on tutor mode is what reshapes a whole session into coaching posture.

Inside Claude Code:

1. Open `/config`.
2. Choose **Output style**.
3. Pick **tutor**.

An output style rewrites the system prompt for the entire session. Choosing **tutor** means the whole session is now in coaching posture: it will coach understanding, planning, and exam preparation, and it will not produce work she would hand in as her own. The choice persists across sessions until she changes it back.

Two related ways to get the same posture:

- **For a single task, invoke the agent.** Instead of changing her whole session, she can call the **amelia-coach** agent for one task. The agent carries the same coaching contract, and its tools are restricted so it physically cannot send mail, edit a calendar, submit anything, or save a finished assignment. Use this when she wants the firmest version of the boundary for one piece of work.
- **The study-coach skill always coaches.** Whenever the **study-coach** skill runs — for coached understanding, self-testing, or office-hours preparation — it runs inside the coaching agent's boundary automatically, even in an ordinary session where tutor mode is not turned on.

A plain caveat, worth saying out loud: the tutor output style holds the coaching posture by instruction, not by force. In a normal session with full tools she can still ask for a direct answer and get one. The hard, tool-enforced boundary holds only inside the amelia-coach agent. This is intentional. Coaching mode is a mode she chooses for herself when she actually wants to learn — not a cage, and not something anyone else can force her into.

## Connect Google Workspace (calendar and email), if she wants it

This step is optional and entirely hers. Once connected, the **calendar** and **email** skills can read her Google Calendar and Gmail and — with her confirmation each time — write: add an event, send a message. The boundary is set by the permissions she grants Google, not by an artificially limited tool.

1. **Install the Google Workspace command-line tool.** Its command name is `gws`. In a terminal:

   ```
   npm install -g @googleworkspace/cli
   ```

2. **Authenticate and choose permissions.** The first time:

   ```
   gws auth setup   # creates a Google Cloud project and turns on the needed services
   gws auth login   # signs in
   ```

   During setup Google asks her to approve permissions. To get the full value of the skills, she grants read-and-write for both Google Calendar and Gmail. She can grant less; the assistant will simply be unable to do the rest and will say so plainly.

3. **Use it.** She can now say things like "what's on my calendar today", "am I free Thursday afternoon", "block two hours to study", "check my email", or "draft a reply to my professor". Reading never asks first; sending a message or creating an event always shows her the exact details and waits for her yes — there is no silent write and no undo on a sent message.

An honest note worth saying plainly: a permission to read mail covers her *whole* mailbox, and a permission to send can send as her. "Just school email" is a filter applied afterward, not a wall the provider enforces. That trade is hers to make with her eyes open, and she can change or withdraw any permission at any time from her Google Account permissions page, which immediately revokes access.

## Updates

When a new version of the plugin is published, she updates the marketplace from inside Claude Code:

```
/plugin marketplace update amelia-tools
```

Manual update with that command is the recommended default.

Two things to know about updates:

- **Fully automatic update at startup needs a token for a private repository.** Claude Code can update plugins automatically when it starts, but for a private repository that additionally requires a GitHub authentication token to be present in the environment variable named `GITHUB_TOKEN`. Without that token, automatic startup updates for this private marketplace will not succeed — which is exactly why manual update is the recommended default.
- **The version number must go up for an update to register.** Each release must increase the `version` field in the plugin and marketplace manifests. If the version field is not increased, Claude Code does not see a new version and will not update.

## Ownership and her data

This is the part that matters most.

- **The plugin is code only — never data.** This repository holds the study assistant's instructions and skills. It never holds her course materials.
- **Her materials live in a data root she controls.** Her syllabi, her review ledger, her weekly plans, and her notes live in a directory only she can read — her own machine or her own account. The plugin learns that path only from a variable she sets. Nothing the system writes ever lands inside anyone else's vault, git history, or sync.
- **There is no parent-facing view.** There is no background monitoring, no hidden reporting, and no automatic sharing with anyone. No school-facing or parent-facing reporting is ever built.
- **She can stop at any time.** She can turn tutor mode off, uninstall the plugin, or walk away entirely, on her own, without anyone else's involvement.

There is also an explicit transfer-of-control step. The father builds and tests Version One against the throwaway demonstration fixtures only — never against real course data. She sets her own data-root path and, if she wants, takes the repository under her own account. The father then removes his access to her data root and confirms there is no remaining read path. From that point he cannot read her course life, and she can verify it.

## What is in Version One

Version One is deliberately small — about a dozen files, installable in an afternoon, useful in five minutes with no account to connect.

- **One coaching agent — amelia-coach.** The enforceable core of the coaching posture, with a restricted tool set so it cannot produce and save submittable work.
- **One everyday output style — tutor.** Reshapes a whole Claude Code session into coaching posture.
- **Six skills:**
  - **course-capture** — silently turns a pasted or photographed syllabus, assignment sheet, or rubric into internal course memory (deadlines, weights, requirements, what the professor expects), keeping track of where each fact came from. She never has to look at the files it makes.
  - **week-look** — the Sunday-evening ritual. She asks "What does my week look like?" and gets a short, ranked answer: the few things that matter this week, the one to start first and why, and any concepts due for review.
  - **course-grounded-answer** — answers questions about how a course works (policies, deadlines, what a rubric asks for), grounded in her own materials, with citations or an honest "the material does not say." Questions about the substance being graded are routed to coaching rather than answered.
  - **study-coach** — one skill with three modes: coached understanding (the hint ladder), self-testing (predict, reveal, compare, and record on a spaced-review schedule), and office-hours preparation (refining questions she drafts).
  - **calendar** — reads her Google Calendar and, with her confirmation, adds or changes events. Needs the optional Google Workspace connection above.
  - **email** — reads her Gmail and, with her confirmation, sends or replies. Needs the optional Google Workspace connection above.
- **One shared consent document and the coaching contract**, written once and used everywhere so the privacy and integrity rules never drift between surfaces.
- **Two demonstration fixtures** — a fake syllabus and a fake assignment — so the whole thing can be built and tested with no real course data.

**Google Workspace (calendar and email)** is included as an optional connection — see the section above. The core weekly loop still works with nothing connected; the calendar and email skills simply add capability for her if she chooses to authenticate.

**Deliberately deferred to a later phase:** a connection to a college Learning Management System (the school's online course platform, such as Canvas or Moodle). These depend on fragile, school-controlled access rules, so that integration comes only later, only if she wants it, and only when the core loop has earned its place.

## Assumptions to verify with her before the real pilot

The persona above was written from reasonable guesses, not from confirmed facts. Before any real pilot with her, the following assumptions must be checked with her directly. Each of these is still to be confirmed:

- **Her major** — assumed unknown; her actual field of study shapes what coaching and grounding look like.
- **Her courses** — assumed unknown; the real set of courses, their formats, and their grading styles are not yet confirmed.
- **Her current tools** — assumed unknown; whether she already uses Claude Code, another assistant, a calendar, or a note system is not yet confirmed.
- **Her comfort level** — assumed unknown; her comfort with a command-line interface, with installing software, and with the whole idea of an assistant her father built is not yet confirmed.

Nothing in this plan should be treated as settled about her until she has confirmed it herself. She owns this. She also gets the first and final word on whether the assumptions behind it are right, and she is free to rename the whole thing to whatever she wants on first run.
