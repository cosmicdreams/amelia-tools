---
name: email
description: >
  Read and manage Amelia's Gmail through the Google Workspace command-line tool (the
  command named gws). Use when she asks to check her email, read a message, find
  messages from someone, see her unread mail, draft a reply, or send a message.
  Trigger phrases: "check my email", "any new emails", "do I have mail from my
  professor", "read this message", "show me my inbox", "unread emails", "reply to
  this", "draft an email", "send an email". Do not trigger for calendar tasks — use
  the calendar skill for those.
---

# Email

Read and manage Amelia's Gmail through the Google Workspace command-line tool, whose command name is `gws`.

How much this skill can do is set by the permissions Amelia granted and her confirmation in the moment. Reading her mail never needs confirmation; sending or replying always does, and there is no undo on a sent message. The full rules are in the [consent model](../../references/consent-model.md), and the authentication and error handling are in [working with Google Workspace from the command line](../../references/google-workspace-command-line.md).

## Preflight

Before the first `gws` command in a session, run the health check:

```bash
"${CLAUDE_PLUGIN_ROOT}/scripts/check-integration.sh" gws
```

If it exits non-zero, stop and show the message from standard error word for word. Do not continue.

## List the inbox (unread first)

```bash
gws +triage
```

For more messages:

```bash
gws gmail users messages list --params '{"userId": "me", "maxResults": 20}'
```

This returns message identifiers. Fetch the details of any message with the read command below. Present the list as a short table led by the unread count.

## Read a message

```bash
gws gmail users messages get --params '{"userId": "me", "id": "<message_identifier>"}'
```

Show the sender, the recipients (including any carbon-copy recipients, if present), the date, the subject, and then the body. Remove quoted reply chains unless she asks to see them.

## Send a new message (requires her confirmation)

Sending is a write, and there is no way to unsend. Before you send, show Amelia the recipient, the subject, and the full body, and ask plainly: "Send this email?" Send only after she says yes.

```bash
gws gmail users messages send --params '{"userId": "me"}' --json '{"raw": "<the message, encoded as base64url>"}'
```

To build the value for `raw`, construct a standard raw email message (sender, recipient, subject, body) and encode it with base64url.

## Reply to a message (requires her confirmation)

First read the original message to get its threading details (the message identifier, the references chain, and the conversation identifier). Build the reply with the matching in-reply-to and references headers so it threads correctly, and send it with the conversation identifier. As with any send, show her the reply and confirm before sending.

## Presentation

Always present results as clean text — a table for message lists, an indented block quote for a message body. Never show her the raw machine output.

If a send returns a permission error, it means send permission was not granted. Tell her plainly, and point her to re-running `gws auth setup` if she wants to allow it.
