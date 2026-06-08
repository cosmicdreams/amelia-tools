---
name: calendar
description: >
  Read and manage Amelia's Google Calendar through the Google Workspace command-line
  tool, whose command is `gws`. Use when she asks what is on her calendar, about
  upcoming events or classes, her schedule, whether she is free at a time, or wants
  to add or block time. Trigger phrases: "what's on my calendar", "what do I have
  today", "am I free", "check my availability", "do I have any conflicts", "when is
  my next class", "what's on my calendar this week", "add this to my
  calendar", "block study time", "schedule this". Do not trigger for mail tasks —
  use the email skill for those. Do not trigger for ranking coursework or deciding
  what to work on — including "what does my week look like" asked as a planning
  question — use the week-look skill for that.
---

# Calendar

Read and manage Amelia's Google Calendar through the Google Workspace command-line tool, whose command name is `gws`.

How much this skill can do is set by the permissions Amelia granted and her confirmation in the moment. Reading her calendar never needs confirmation; creating, changing, or deleting an event always does. The full rules are in the [consent model](../../references/consent-model.md), and the authentication and error handling are in [working with Google Workspace from the command line](../../references/google-workspace-command-line.md).

## Preflight

Before the first `gws` command in a session, run the health check:

```bash
"${CLAUDE_PLUGIN_ROOT}/scripts/check-integration.sh" gws
```

If it exits non-zero, stop and show the message from standard error word for word. Do not continue.

## Read upcoming events

```bash
gws +agenda
```

For a specific window, fill in the start time as a full date-and-time stamp, for example `2026-09-14T08:00:00-05:00`:

```bash
gws calendar events list --params '{"calendarId": "primary", "maxResults": 20, "orderBy": "startTime", "singleEvents": true, "timeMin": "START"}'
```

Present the result as a time-sorted list grouped by day, with event titles in bold and the duration shown:

```
## Today — Monday, September 14
- 9:00–10:00 in the morning · **Biology lecture**

## Tomorrow — Tuesday, September 15
- 11:00–12:00 · **Writing seminar**
```

## Check whether she is free

```bash
gws calendar freebusy query --json '{"timeMin": "START", "timeMax": "END", "items": [{"id": "primary"}]}'
```

Turn the busy blocks into the free windows between them, and show those.

## Create an event (requires her confirmation)

Creating, changing, or deleting an event is a write. Before you run it, show Amelia the exact details — title, date, start and end time, and any guests — and wait for her to confirm. Convert any plain-language time she gives you into a full date-and-time stamp. If the time zone is unclear, ask before proceeding.

```bash
gws calendar events insert --params '{"calendarId": "primary"}' \
  --json '{"summary": "TITLE", "start": {"dateTime": "START", "timeZone": "America/Chicago"}, "end": {"dateTime": "END", "timeZone": "America/Chicago"}}'
```

If the command returns a permission error, it means write permission for the calendar was not granted. Tell her plainly, and point her to re-running `gws auth setup` if she wants to allow it.
