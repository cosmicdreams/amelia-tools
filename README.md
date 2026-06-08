# college

## 1. Install

Ask your dad for read access to the repository (one time). Then:

In a terminal:

```
gh auth login
```

In Claude Code:

```
/plugin marketplace add cosmicdreams/amelia-tools
/plugin install college@amelia-tools
```

Turn on coaching mode: `/config` → **Output style** → **tutor**. This puts your whole session in coaching mode — it helps you understand and plan, and will not hand you finished work. It stays on across sessions until you set the style back to **Default**. When you just want a straight answer, switch it back or ask in a normal session — coaching is your choice.

Optional, to use your Google Calendar and Gmail — in a terminal:

```
npm install -g @googleworkspace/cli
gws auth setup
gws auth login
```

Optional, to make study guides, quizzes, and audio overviews from your readings — in a terminal:

```
pip install notebooklm-py
notebooklm login
```

## 2. Use

Talk to it:

- "What does my week look like?"
- Paste a syllabus or a photo of one — it finds your deadlines.
- "Help me understand this." — hints and quizzes, not answers.
- "When is the paper due? What does the rubric want?"
- "What's on my calendar today?" / "Check my email." (needs the optional setup)
- "Make me a study guide, a quiz, or an audio overview from these readings." (needs the optional setup)
- "Quiz me — am I ready for the exam?"

Or call one directly with a slash command (type `/` and it autocompletes):

- `/college:plan-week` — your ranked week
- `/college:coach-me` — coach me through something
- `/college:capture-course` — pull a syllabus into your courses
- `/college:check-syllabus` — answer from your course materials
- `/college:manage-calendar` — your Google Calendar
- `/college:manage-email` — your Gmail
- `/college:make-study-aids` — study guides, quizzes, and audio overviews from your materials
- `/college:quiz-me` — prove you understand it before a test

You can add what you want right after it, for example `/college:manage-calendar what's on today`.

## 3. Update

```
/plugin marketplace update amelia-tools
```

## This grows with you

This is just the start. If something would make your school life easier — a new skill, a different way of working, anything that comes up.  We can build it.
