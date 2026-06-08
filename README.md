# amelia-student

Your study assistant. It helps you see what your week looks like, understand your coursework, and stay on top of deadlines — and it will not do your work for you. It is yours: you install it, you turn it on, and your information stays somewhere only you can read.

## Install

You need read access to the `cosmicdreams/amelia-tools` repository (ask the owner once).

1. Sign in to GitHub one time, in a terminal:

   ```
   gh auth login
   ```

   Choose GitHub.com and sign in through the browser.

2. In Claude Code, add the marketplace and install the plugin:

   ```
   /plugin marketplace add cosmicdreams/amelia-tools
   /plugin install amelia-student@amelia-tools
   ```

   Accept the one-time trust prompt.

## Turn on tutor mode

In Claude Code: open `/config`, choose **Output style**, pick **tutor**.

That puts the whole session in coaching mode — it helps you understand and plan, and will not hand you finished work. Switch it back the same way any time. (For a single task instead of the whole session, just ask for the **amelia-coach** agent.)

## What you can say

- **"What does my week look like?"** — a short, ranked list of what matters this week and what to start first.
- **Drop in a syllabus** (or a photo of one) — it pulls out your deadlines and what each professor expects.
- **"Help me understand this."** — it coaches you with hints, quizzes you, and helps you prepare questions for office hours.
- **"When is the paper due? What does the rubric want?"** — answered from your own course materials.

## Optional: connect your Google Calendar and Gmail

Only if you want it. Once connected, it can read your calendar and mail and — after asking you first, every single time — add events or send messages.

```
npm install -g @googleworkspace/cli
gws auth setup
gws auth login
```

Grant read-and-write for Calendar and Gmail to get the full value. You can change or remove that any time from your Google Account permissions page.

## Updating

When there is a new version:

```
/plugin marketplace update amelia-tools
```

## It is yours

Your courses, plans, and notes live in a place only you can read — never in this repository, never in anyone else's files. There is no parent view, no monitoring, and no reports to anyone. Turn it off or uninstall it whenever you like.
