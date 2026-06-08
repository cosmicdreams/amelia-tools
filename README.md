# amelia-student

## 1. Install

Ask your dad for read access to the repository (one time). Then:

In a terminal:

```
gh auth login
```

In Claude Code:

```
/plugin marketplace add cosmicdreams/amelia-tools
/plugin install amelia-student@amelia-tools
```

Turn on coaching mode: `/config` → **Output style** → **tutor**.

Optional, to use your Google Calendar and Gmail — in a terminal:

```
npm install -g @googleworkspace/cli
gws auth setup
gws auth login
```

## 2. Use

Talk to it:

- "What does my week look like?"
- Paste a syllabus or a photo of one — it finds your deadlines.
- "Help me understand this." — hints and quizzes, not answers.
- "When is the paper due? What does the rubric want?"
- "What's on my calendar today?" / "Check my email." (needs the optional setup)

Or call one directly with a slash command (type `/` and it autocompletes):

- `/amelia-student:week-look` — your ranked week
- `/amelia-student:study-coach` — coach me through something
- `/amelia-student:course-capture` — pull a syllabus into your courses
- `/amelia-student:course-grounded-answer` — answer from your course materials
- `/amelia-student:calendar` — your Google Calendar
- `/amelia-student:email` — your Gmail

You can add what you want right after it, for example `/amelia-student:calendar what's on today`.

## 3. Update

```
/plugin marketplace update amelia-tools
```

## This grows with you

This is just the start. If something would make your school life easier — a new skill, a different way of working, anything — you do not have to know how to build it. You just have to know what you want. Ask, and it gets built.
