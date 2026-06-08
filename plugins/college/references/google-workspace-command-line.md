# Working With Google Workspace From The Command Line

This reference explains how the assistant talks to Google Workspace — Amelia's Google Calendar and her Gmail — through a command-line tool whose command name is `gws` (short for Google Workspace). It is shared by the `manage-calendar` and `manage-email` skills.

Read this together with the [consent model](consent-model.md). The consent model is the rule book; this file is the how-to. Where the two ever seem to disagree, the consent model wins.

## The one rule that governs everything here

Amelia decides how much this tool can do, and she decides it in two places:

1. **The permission scopes she grants when she authenticates.** When she runs the authentication step below, Google asks her to approve specific permissions — for example, reading her calendar, changing her calendar, reading her mail, sending mail. The assistant can only ever do what those granted permissions allow. If she grants read-only permission, no command can write, no matter what anyone types. This is the real boundary, enforced by Google itself, not by this plugin.
2. **Her in-the-moment confirmation before any change.** Even when she has granted write permission, the assistant always shows her exactly what it is about to send, create, or change, and waits for her to say yes, one action at a time. There is no blanket approval and no silent write. Reading her own information never needs confirmation; changing anything always does.

This plugin is built to be capable — it can read and write — precisely so that the limit lives where it belongs: in the scopes she grants and the confirmations she gives, not in an artificially crippled tool.

## Before any command: the preflight check

Before the first `gws` command in a session, run the preflight health check so failures are caught early with a clear message:

```bash
"${CLAUDE_PLUGIN_ROOT}/scripts/check-integration.sh" gws
```

If it exits with a non-zero status, stop and show the message it printed to standard error, word for word. Do not continue with any Google Workspace operation. A typical message looks like:

> integration gws unavailable: gws authentication failed: token expired — run: gws auth login

## Authentication and setup

If a `gws` command reports "Access blocked", any authentication error, or any non-zero exit, stop and tell Amelia:

> Authentication is required. In a terminal, run:
> ```bash
> gws auth setup   # the first time only — it creates a Google Cloud project and turns on the needed services
> gws auth login   # for every later sign-in
> ```
> Then try again.

If the command is missing entirely (`gws: command not found`):

> Install the Google Workspace command-line tool with:
> ```bash
> npm install -g @googleworkspace/cli
> ```

### Which permissions to grant

During `gws auth setup`, grant the permissions that match what Amelia wants the assistant to be able to do. To get the full value of the manage-calendar and manage-email skills, that means granting read-and-write permission for both Google Calendar and Gmail. She can grant less if she prefers; the assistant will simply be unable to do whatever she did not allow, and will say so plainly rather than failing in a confusing way. She can change or withdraw these permissions at any time from her Google Account permissions page, which immediately revokes the tool's access.

## Common errors

- **"accessNotConfigured"** — the required Google service is not turned on yet. The tool prints a link that turns it on; show her the link.
- **"Access blocked"** — run `gws auth setup` and then `gws auth login`.
- **A permission error on a write** — the granted scopes are read-only for that service. Tell her plainly that the action needs write permission she has not granted, and that she can grant it by re-running `gws auth setup`.
- **Any other non-zero exit** — show the error text from standard error and ask her how she wants to proceed. Never guess past an error.

## Presentation

Never show raw machine output to Amelia. Format calendar results as a clean, time-sorted list grouped by day; format message lists as a short table led by the unread count; format a single message as labelled fields (sender, recipients, date, subject) followed by the body with quoted reply chains removed unless she asks for them.
