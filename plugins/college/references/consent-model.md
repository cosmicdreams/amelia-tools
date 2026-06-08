# Privacy, Ownership, and Academic Integrity

This document explains who owns this study assistant, where your information lives, what the assistant is allowed to read and write, and what it will never do. It is written for you, Amelia. Every skill in this plugin and the coaching agent link back to this one document, so there is a single place that tells the truth about how your information is handled. If anything elsewhere ever seems to contradict this document, this document wins, and you should treat the contradiction as a bug worth fixing.

The short version: you own this system, you own your information, your information lives somewhere only you can read, and there is no version of this that lets anyone watch your school life. The longer version is below, because on a subject like this you deserve the full account, not a comforting summary.

---

## 1. You own this system

This assistant is a gift, not a window. Your father wrote the code, but writing the code does not give him a view into how you use it. Those are two separate things, and this document exists to keep them separate.

Concretely, ownership means all of the following are true:

- **You control the system.** You decide when to use it, what to show it, when to turn the coaching posture on or off, and whether to keep it at all. You can rename the whole thing to whatever you want on the first run. Naming it after you in the third person would signal "this was built about you," which is the opposite of what it is. It was built for you to point at your own coursework.
- **You control your information.** Everything the system learns about your courses, your confidence, your weak spots, and your weekly plans belongs to you and lives where only you can reach it. The next section describes exactly where that is.
- **There is no owner above you.** There is no administrator account, no parent account, no teacher account, no hidden role with more access than you have. The person with the most access to your school information in this system is you, and there is no one in second place.

---

## 2. Where your information lives, and why your father cannot read it

This is the part that matters most, because intentions are not a safeguard. A system that places your coursework inside your father's personal files would let him see your school life no matter how sincerely anyone promised not to look. The protection here is structural, not a promise. Structure is what you can verify; a promise is not.

### The code and your information are kept in two completely separate places

- **The plugin holds code only, never your information.** The plugin is the set of instructions that tells the assistant how to behave. It is your father's gift to you, and it can live in his code repository, because there is nothing of yours in it. Reading the plugin tells anyone how the assistant works. It tells them nothing about you.
- **Your information lives in a data root that you control.** Your syllabi, your review ledger, your weekly plans, and your notes live in a location you alone can read: your own machine, your own account, or a directory only you can open. This location is called your data root.
- **The plugin only learns the location of your data root from a setting that you provide.** There is no built-in default location, and in particular there is no default that lands inside your father's personal files. Until you tell the system where your data root is, it has nowhere of yours to write to.

### Your data root sits outside three things on purpose

Your data root is deliberately kept outside all three of the places where your father could otherwise see your information:

1. **Outside his personal note vault.** Nothing the system writes ever lands inside his personal Obsidian note vault. His vault is his; your data root is yours; they do not overlap.
2. **Outside his version-control history.** Your information is never committed into his version-control history. Version-control history is permanent and shareable by nature, so keeping your information out of it is essential. Once something enters a version-control history it can be recovered later and copied elsewhere, which is exactly the kind of lingering access this design refuses.
3. **Outside his file synchronization.** Your information is never placed in any folder that synchronizes to his accounts or his other machines. A synchronized folder is a quiet copy that travels; your data root does not travel to him.

### Two things enforce this, not one

The separation does not rest on a single safeguard:

- **The data root being external** means there is no path from his space into yours to begin with.
- **The coaching agent's restricted tools** mean the assistant physically cannot write anywhere except your own notes and your review ledger. It has no general write capability, no shell access, and no web access, so it cannot reach outside your data root even by mistake. Section 4 describes these restrictions in full.

---

## 3. Read by default; any change to the outside world needs your confirmation

The assistant's normal posture is to read, not to change. Reading is free; changing anything in the outside world always asks you first.

- **It reads what you give it, and what you connect.** When you drop in a syllabus, a photograph of one, an assignment sheet, a rubric, a reading, or a note, the assistant reads that material. If you choose to connect Google Workspace (see section 9), it can also read your calendar and your mail. Reading your own information never needs a confirmation step.
- **The study files it writes are yours and private.** The assistant's own record-keeping — your course memory, your notes, and your review ledger — is written only inside your data root. These are your private model of your own coursework, written for you to use, not for anyone to inspect.
- **Every change to the outside world is confirmed, one action at a time.** Sending an email, creating or changing a calendar event, or any other action that affects something outside your private study files is a write, and the assistant always shows you exactly what it is about to do and waits for your yes before doing it. There is no setting that grants blanket approval, and there is never an automatic outside write you did not see and approve. This rule does not expire.
- **The real limit is what you grant.** The assistant can be capable — it can read and write through Google Workspace — on purpose, so that the boundary lives where it belongs: in the permissions you grant Google when you connect, and in the confirmations you give in the moment. If you grant read-only permission, nothing can write, no matter what is typed. You set the ceiling; the assistant lives under it.

---

## 4. The coaching agent reads only, by design

The coaching agent, named coach, is the enforceable core of the learning posture. Part of how it earns your trust is that it is given the smallest possible set of capabilities.

- **It can read, search, list, and call the study skills — and nothing else.** It can read your course files, search them, list what is there, and route into the study skills (capture-course, plan-week, check-syllabus, coach-me, and quiz-me). It has no general write tool, no command-line access, and no web access.
- **That is what makes the boundary a mechanism, not just a promise.** With no way to save a finished file, the agent physically cannot generate and hand you a completed assignment, even if you asked it to and it forgot every other rule. The capability simply is not there. This is the firmest form of the coaching boundary, and it is the version you get when you invoke the coach agent directly.
- **Writing your review ledger is done by the coaching skills, not the agent.** When you test yourself, the coach-me and quiz-me skills record what you got right and wrong, and when each concept is due to come back, in your review ledger inside your data root. They write only there and to your own study notes — never a finished assignment, and never anywhere the builder can read. The ledger is your honest private picture of what you know: yours to read, edit, and delete, and never sent anywhere.

The Google Workspace skills (manage-calendar, manage-email) and the study-aid maker (make-study-aids) are deliberately **not** part of the coaching agent. They are everyday-assistant skills that run in an ordinary session with the tools they need — reaching Google Workspace, or running the notebook tool — and they can act (send a message, add an event, save a study guide) always with your confirmation, as section 3 describes. Keeping them outside the read-only coaching agent is intentional: the coaching agent stays powerless to act in the outside world, so the academic-integrity boundary can never be quietly turned into "send my professor this finished essay." Coaching reads and thinks; the utility skills act, and only with your yes.

---

## 5. Source-grounding and honesty

When the assistant tells you something about how one of your courses works, it owes you an honest, traceable answer.

- **Course facts are grounded in your own materials.** When the assistant states a deadline, a weight, a policy, or what a rubric asks for, it points at where that came from in your own syllabus, rubric, assignment prompt, reading, or note. You can always trace a claim back to the source it rests on.
- **"The material does not say" is a real, valid answer.** If your materials do not contain the answer, the assistant tells you so plainly rather than guessing. An honest "I do not see that in what you gave me" is always better than a confident invention.
- **It never fabricates a citation.** The assistant will not invent a source, attach a real source to a claim that source does not support, or dress up a guess as a grounded fact. Grounding is there to earn your trust, so faking it would defeat the entire point.
- **Grounding does not turn a forbidden answer into an allowed one.** Pointing at the rubric does not make it acceptable to answer a graded question for you. When a question is about the substance being assessed rather than how the course runs, the assistant hands it to the coaching behavior instead of answering it, no matter how well it could cite a source. Grounding raises how submittable an answer is; it does not launder it into something permitted.

---

## 6. The academic-integrity record is voluntary and yours

If a professor ever questions your work, saying "I used a tutor, not an answer machine" is hard to prove on your own. So this system can, at your choice and under your control, keep a record that shows an interaction was hint-laddered coaching and feedback on your own draft, rather than generated answers.

- **It is voluntary.** No record is produced unless you ask for one. The system does not log your interactions for integrity purposes by default.
- **It is yours to show or withhold.** If you do produce a record, it is yours. You decide whether a professor ever sees it. You can show it, keep it, or delete it.
- **There is no school-facing reporting, ever, and no parent-facing reporting, ever.** There is no feature that lets your school or your father pull a report on your activity. A record that someone else could request on demand would be surveillance wearing an academic-integrity costume, and it is not built. The record exists only as something you can choose to offer in your own defense, never as something anyone can demand from you.

---

## 7. No parent-facing view, ever

This deserves to be said on its own, without qualification, because it is the line the whole design is built to protect.

There is no parent-facing view. There is no dashboard your father can open. There is no summary of what you studied, what you skipped, how confident you were, or what you struggled with that anyone but you can see. There is no notification sent to anyone about your activity. There is no quiet log he can read later. This is not a setting that defaults to off and could be switched on. The capability does not exist in the system, and it will not be built.

The system also never shows you an accounting of what you failed to finish. Its weekly view points forward to the lightest next step, not backward at what slipped. It is not a gradebook, and it is not a guilt machine.

---

## 8. The honest caveat: this is a chosen mode, not a cage

You deserve the truth about what this system can and cannot enforce, because a tool that overstates its own guarantees is not trustworthy.

The hard, tool-enforced boundary against producing submittable work holds **only inside the coaching agent, coach.** Inside that agent, the restricted tools mean it physically cannot generate and save a finished assignment. That is real enforcement, not a request.

The everyday coaching surface, the output style named tutor, holds the very same posture, but it holds it **by instruction, not by force.** It reshapes your whole session into coaching mode and follows the same contract, yet it does not have the agent's tool restrictions, so in that surface the boundary is a matter of the assistant following its instructions rather than being physically unable to cross the line.

And you can always open an ordinary session, with full tools, and get a direct answer to anything. Nothing in this system locks you out of that.

This is correct, and it is intended. The coaching posture is a mode you choose for yourself when you actually want to learn. It is not a cage, and it is not something anyone can force you into. The reason the strict boundary lives inside an agent you opt into, rather than being welded onto everything you do, is that the entire premise of this system is that it is yours to steer. A tool that trapped you in a mode you did not choose would be just another way of deciding things for you, which is the thing this design exists to avoid.

The system's only real job is to make the honest path the easiest path. It tries to be more useful than cheating, so that learning is what you reach for because it works, not because you are forced. The choice stays yours.

---

## 9. Connecting Google Workspace, only if you choose it

Connecting your Google Calendar and your Gmail is optional and entirely your choice. Nothing here happens until you run the authentication step yourself. The rules below are set down now, before any account is connected, so they are not negotiated under pressure later. When you do connect, the `manage-calendar` and `manage-email` skills can read and — with your confirmation each time — write.

- **You set the ceiling when you authenticate.** When you connect, Google asks you to approve specific permissions: reading your calendar, changing your calendar, reading your mail, sending mail. The assistant can only ever do what you approved. Grant read-and-write for both if you want the full value of the skills; grant less if you prefer, and the assistant will simply be unable to do the rest and will say so. You can change or withdraw any of this later. This permission set, enforced by Google itself, is the real boundary — stronger than anything this plugin could promise.
- **An honest scope statement, not a comforting fiction.** A permission to read mail grants access to your *entire* mailbox, and a permission to send can send as you; "just school email" is a filter applied after the fact, not a wall the mail provider enforces. You are told this plainly so you can decide with your eyes open. The trade is yours to make: broader access buys more usefulness, and you are the one who weighs that.
- **Every change is still confirmed, one at a time.** Even with write permission granted, the assistant shows you each message before it sends and each event before it creates, and waits for your yes. Permission makes an action possible; your confirmation makes it happen.
- **Tokens live only where you can reach them.** Any access token lives in your keychain or in a path only you can read, never in a file your father can open.
- **Copies expire on their own.** Any copy the assistant makes of your calendar or mail is written to your data root with a short lifetime, so stale copies do not pile up on disk.
- **You can revoke access instantly, by yourself.** You can cut off the connection on your own, without your father, from your Google Account permissions page. Revoking there immediately kills the token, and any already-downloaded copies expire on their own as described above.
- **You can audit your own assistant.** An access log, readable by you, records which information each skill read and what it sent or changed, and when — so that you, the owner, can audit your own assistant. This log is yours. It is never shown to your school or your father.

---

## 10. The handoff that makes ownership a fact

Ownership is not real until your father no longer has a path to your information. There is an explicit transfer-of-control step, not merely a review-and-comment step:

1. Your father builds and tests this first version against throwaway practice fixtures only, never against your real course information.
2. You set your own data-root location and, if you want the plugin under your own account, take the code repository as your own.
3. Your father removes his access to your data root and confirms there is no remaining read path into it, not through version control, not through shared synchronization, and not through shared disk.
4. From that point on, your father cannot read your school life, and you can verify that for yourself.

After the handoff, the facts in this document are facts you can check, not assurances you have to take on faith. That is the whole point.
