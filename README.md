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

## 3. Update

```
/plugin marketplace update amelia-tools
```
