# Decision Board Skill

Copy of the decision board, made 2026-10-24 at round 8: every point with its discussion. 37 of 37 points settled.

1 point, about a board in another project, is left out of this copy, and so are quotes from that project.

*dotclaude · decision-board*

Turning the decision page into a global Claude Code skill, `decision-board`, kept in dotclaude. This page is the generic version: your calls at the top, Claude's proposals below. Answer each point, then submit at the bottom.

## The page

### Two kinds of points: proposals and calls

`two-kinds` · Proposal · settled in round 1

**Decision.**

Two kinds of points, set by each point's `kind`: proposals, where Claude has a reasoned default and you accept or comment, and calls, which depend on your preference. Calls are highlighted and counted on their own. Their names are a point of their own.

**Context.**

Each point has a `kind`. A **proposal** is a point where Claude has a reasoned default: one recommendation, and you accept it or comment. A **call** depends on your preference or on something Claude can't know: Claude says which way it leans, and you choose. Calls are highlighted and counted on their own in the header.

**Detail.**

The field, on each document in `items`:

```json
{ "kind": "call" }
```

It takes `proposal` or `call`, and a point without it is a proposal. It is separate from `section`, so a section can hold both kinds, as on this page.

**Recommendation.**

Keep the two kinds and their names as they work on this page.

**Discussion.**

**You, round 1 (Accepted):**

> Are these two names clear enough?

**Claude, round 1:**

> The two kinds are settled. Their names are a new call in round 2, with the alternatives.

### What to call the two kinds

`names` · Your call · settled in round 2

**Decision.**

The two kinds are called **Your call** and **Proposals**.

**Context.**

The page shows them as **Your call** and **Proposals**: the headings under Needs you, the tag on each card, the outline and the counts in the header. "Proposal" names what Claude brings and "Your call" names what you decide, so the pair is a little uneven.

**Options.**

- **Your call and Proposals** (recommended): As now. Plain, and it says who decides.
- **Questions and Proposals**: An even pair, but it overlaps the "Comment or question" box on every card.
- **Your choice and Proposals**: Close to "Your call", a little more literal.

**Recommendation.**

Keep "Your call". It says plainly that the decision is yours.

**Discussion.**

**You, round 2 (Option: Your call and Proposals):**

### Which kind comes first under Needs you

`kind-order` · Your call · settled in round 1

**Decision.**

Calls first under Needs you, then proposals.

**Context.**

This page lists the calls first and the proposals after them.

**Options.**

- **Calls first** (recommended): The points that need the most thought stay in view, even on a long board.
- **Proposals first**: Clear the quick accepts, then turn to the calls.

**Recommendation.**

Calls first. On a long board, calls at the bottom would get buried.

**Discussion.**

**You, round 1 (Option: Calls first):**

### An “Accept remaining proposals” button

`accept-rest` · Your call · settled in round 1

**Decision.**

Keep the "Accept remaining proposals" button. It answers only the proposals you haven't answered, never a call, and can be undone until you submit.

**Context.**

The bar at the bottom has a button that accepts every proposal you haven't answered yet. It never answers a call, and each card can still be changed until you submit. You can try it on this page.

**Detail.**

A proposal with options gets its recommended option, and one with no recommended option is left alone. A proposal you've commented on counts as answered, so the button skips it.

**Options.**

- **Keep it** (recommended): Fewer clicks when you agree with most proposals.
- **Drop it**: Every proposal gets its own click.

**Recommendation.**

Keep it. It can be undone until you submit, and calls still need a click each.

**Discussion.**

**You, round 1 (Option: Keep it):**

### Code blocks in cards

`code-blocks` · Proposal · settled in round 1

**Decision.**

Cards render fenced code blocks, which scroll inside the card. The page's Markdown: paragraphs, `- ` bullets with one nested level, fenced code blocks, `code` and **bold**.

**Context.**

Cards render fenced code blocks, for points about exact code or text. A long line scrolls inside the card, not the page. This is the notification Submit sends from this board, with example counts:

```text
Round 1 submitted on the board "Decision Board Skill": 8 answered, 5 left open. Please read the answers and update the board.
```

**Recommendation.**

Keep them. The rest of the Markdown stays small: paragraphs, `- ` bullets with one nested level, `code` and **bold**.

**Discussion.**

**You, round 1 (Accepted):**

### No topic in the page source

`generic-page` · Proposal · settled in round 1

**Decision.**

The page holds nothing about any one topic. Its heading, intro and round note come from `board/meta`, and Claude fills in its `<title>` when it publishes a board. The Submit notification names the board. It ships in the skill as `board.html`.

**Context.**

The page holds nothing about any one topic. Its heading, intro and round note come from `board/meta`. Its `<title>`, which names the artifact in the gallery, is a placeholder that Claude fills in when it publishes a board. The Submit notification names the board, so a session watching two boards knows which one it came from.

**Recommendation.**

Ship the page this way in the skill, as `board.html`.

**Discussion.**

**You, round 1 (Accepted):**

### A box for general comments

`general-comments` · Proposal · settled in round 2

**Decision.**

The board ends with a box for general comments, stored as `responses/general`, with its discussion in `board/general`. It goes in with the round, or on its own. A new idea becomes a new point; a short answer goes in the box's discussion.

**Context.**

The board ends with a box for comments, questions or ideas that don't belong to any one point. It saves as you type and goes in with the round when you submit, like a card's answer, and it can be submitted on its own. Claude answers in the next round: a new idea becomes a new point, and a short answer goes in the box's discussion, above it.

**Detail.**

It is stored as `responses/general`, in the same shape as a point's answer. Its discussion is the `thread` of `board/general`.

**Recommendation.**

Keep it as it works on this page.

**Discussion.**

**You, round 2 (Accepted):**

### Using the sides of the page

`side-space` · Proposal · settled in round 2

**Decision.**

On wide screens the board has an outline on its left: the open points by kind, each marked answered or not, with links to the settled points and the general comments. The reading column keeps its width.

**Context.**

On a wide screen the board has an outline on the left: the open points by kind, each marked answered or not. Clicking one scrolls to its card, and the last links go to the settled points and the general comments. On a screen narrower than about 1180 pixels the outline is hidden and the page is as before. The reading column keeps its width, since longer lines read worse, so the right side stays empty.

**Recommendation.**

Keep the outline. It helps most on long boards, where it shows at a glance what still needs you.

**Discussion.**

**You, round 2 (Accepted):**

## The skill

### What the skill holds

`base` · Proposal · settled in round 2

**Decision.**

The skill holds the page and the protocol, in `skills/decision-board/`. Each new discussion gets its own board, named after its subject. Claude only, since Codex has no Artifact tools. Each round's decisions go into the project's own record.

**Context.**

From the proposal you pasted:

- the page and the protocol, in `skills/decision-board/`;
- a new board for each discussion, named after its subject, like an earlier board and this one, instead of one board per project that keeps collecting every discussion;
- Claude only, since Codex has no Artifact tools;
- each round's decisions written into the project's own record, since the board is where the work happens, not the record.

**Recommendation.**

Keep all four.

**Discussion.**

**You, round 1 (Discuss):**

> one page per topic? sorry I am unclear what you mean - is this what the skill would prescribe? the skill itself comes with no topics

**Claude, round 1:**

> It's what the skill would tell Claude to do, yes. The skill has no topics of its own: a topic is the subject of one discussion, like the subject of an earlier board or this skill now. One page per topic means each new discussion gets a new board, named after its subject, instead of one board per project that keeps collecting every discussion. The card now says so.

**You, round 2 (Accepted):**

### When Claude uses a board

`trigger` · Proposal · settled in round 1

**Decision.**

Claude uses a board when it has four or more points for you, or any point likely to need more than one round. One or two quick questions stay in the chat. This wording goes into the skill's description.

**Context.**

When Claude has four or more points for you, or any point likely to need more than one round. One or two quick questions stay in the chat.

**Detail.**

The pasted proposal said "four or more points to decide, or points the author may comment on". Almost any point may get a comment, so its second half would cover nearly everything.

**Recommendation.**

Use this wording in the skill's description, which every session lists.

**Discussion.**

**You, round 1 (Accepted):**

### Open a board without asking, or offer one first

`offer-or-open` · Your call · settled in round 1

**Decision.**

Claude offers a board in one line first, and a yes holds for the rest of the session. If saying yes gets tedious, Claude opens boards directly instead.

**Context.**

When the trigger applies, Claude can publish the board straight away and give you the link, or ask first in one line.

**Options.**

- **Offer first** (recommended): One line in the chat, such as "6 points to decide; put them on a board?" A yes holds for the rest of the session.
- **Open it directly**: Claude publishes the board and gives you the link; the chat reply only sums up.

**Recommendation.**

Offer first. A board means answering in the browser, and each one adds an artifact to your gallery.

**Discussion.**

**You, round 1 (Option: Offer first):**

> Let's do this for now; if I see it gets annoying to say yes, we will move to direct.

### When a point is settled

`settling` · Proposal · settled in round 1

**Decision.**

A point is settled only on your Accept or a chosen option. A Discuss gets Claude's reply in the card's discussion and stays open. An Accept with a comment is settled when the comment only refines the point, and stays open when it raises a new choice. Each entry in the project's record names the board and the round.

**Context.**

Only on your Accept or a chosen option. A Discuss gets Claude's reply in the card's discussion and stays open for the next round. An Accept with a comment is settled when the comment only refines the point, and stays open when it raises a new choice.

**Recommendation.**

Put this rule in the protocol. Each entry in the project's record names the board and the round the point was settled in.

**Discussion.**

**You, round 1 (Accepted):**

### The data, as the page uses it

`data-model` · Proposal · settled in round 1

**Decision.**

The skill documents the shapes of the board's data: points in `items`, answers in `responses`, submissions in `rounds/r<N>` and the header in `board/meta`. Before the next round, Claude copies each answer into the point's `thread`, since `responses` is overwritten each round.

**Context.**

`responses` holds one document per point, overwritten each round. So before the next round, Claude copies each answer into the point's `thread`, which keeps its whole history. A settled card shows only its title, `decision` and discussion.

**Detail.**

A point, in `items` (`order` sorts the page):

```json
{
  "order": 10, "section": "The page", "group": "", "kind": "proposal",
  "title": "…", "status": "open",
  "context": "…", "detail": "…", "recommendation": "…",
  "options": [{ "key": "a", "label": "…", "note": "…", "recommended": true }],
  "changedRound": 2, "changed": "…",
  "thread": [{ "who": "you", "round": 1, "verdict": "Discuss", "text": "…" }],
  "decision": "…", "settledRound": 2
}
```

An answer, in `responses` under the point's id, written by the page:

```json
{ "round": 1, "verdict": "accept", "option": "", "text": "", "state": "submitted", "updatedAt": "…" }
```

`verdict` is `accept`, `option` or `discuss`. `rounds/r<N>` records each submission, and `board/meta` holds `title`, `eyebrow`, `intro`, `round`, `roundNote` and `roundNoteRound`.

**Recommendation.**

Document both shapes in the skill, as above.

**Discussion.**

**You, round 1 (Accepted):**

### Picking up a board in a new session

`resume` · Proposal · settled in round 1

**Decision.**

A new session finds a board by its name in the Artifact tool's list of your artifacts, so saying which board is enough; Claude asks when more than one fits. It watches the board with `ArtifactComments` and reads the answers with `ArtifactData`, and needs the page source only to change the page itself. When no session is watching, the page tells you to tell Claude in the terminal.

**Context.**

A board outlasts the session that made it, as the last one did. A new session watches the board with `ArtifactComments`, so Submit reaches it, and reads the answers with `ArtifactData`. It needs the page source only to change the page itself.

**Recommendation.**

Add these steps to the protocol. When no session is watching, the page tells you to tell Claude in the terminal.

**Discussion.**

**You, round 1 (Accepted):**

> Can I just tell we had a board and would Claude be able to find it?

**Claude, round 1:**

> Yes. The Artifact tool lists your artifacts by name, most recent first, so "the board on the decision skill" is enough to find this one. If two boards fit, Claude asks which.

### Show the exact text, and check the record first

`exact-text` · Proposal · settled in round 1

**Decision.**

When a point is about exact text or code, the card shows it as a short snippet, never a large amount. For an insertion or an edit, it shows the changed part with enough context around it, as a before-and-after diff where it can. Before asking a point, Claude checks the project's record, so a decided point isn't asked again.

**Context.**

Two lessons from your answers on the last board:

- when a point is about exact text, wording or code, the card shows that text;
- before asking a point, Claude checks the project's record, so a decided point isn't asked again.

**Recommendation.**

Add both to the rules for writing a point.

**Discussion.**

**You, round 1 (Accepted):**

> Yes but code only snippets of course; not large amounts. And the same for exact text. If we are talking of an insertion or edit, you would write the changed snippets (possibly with enough context; ideally pre-post diffs if feasible).

**Claude, round 1:**

> Agreed. Diff blocks now color the added and removed lines, so an edit can be shown before and after. This card's rule, as it changed:
>
> ```diff
> - when a point is about exact text, wording or code, the card shows that text
> + when a point is about exact text or code, the card shows it as a short snippet;
> + for an edit, the changed part with some context, as a diff
> ```

### Cloud sessions are untested

`cloud` · Proposal · settled in round 1

**Decision.**

The skill checks for the Artifact tool and falls back to the chat without it. Test it once in a cloud session before relying on it there.

**Context.**

`remote/setup.sh` copies every published skill into cloud sessions. Whether the Artifact tools exist there, and whether Submit can wake a cloud session, is unknown.

**Recommendation.**

The skill checks for the Artifact tool and falls back to the chat without it. Test it once in a cloud session before relying on it there.

**Discussion.**

**You, round 1 (Accepted):**

### No pointer in the CLAUDE.md files

`pointer` · Proposal · settled in round 1

**Decision.**

No pointer in `CLAUDE.md` or `remote/CLAUDE.md`: the skill's description carries the trigger. Add a pointer only if Claude doesn't reach for the skill on its own.

**Context.**

Every session lists the skill's description, which says when to use it. A line in `CLAUDE.md` and `remote/CLAUDE.md` would be two more places to keep in sync.

**Recommendation.**

Skip the pointer. Add it only if Claude doesn't reach for the skill on its own.

**Discussion.**

**You, round 1 (Accepted):**

### Skip the three additions for now

`additions` · Proposal · settled in round 1

**Decision.**

Skip the Markdown export, the "changed since your last visit" filter and cards with several parts, for now.

**Context.**

- **Markdown export of settled decisions**: Claude writes the record itself from the database, and each `decision` is written so it can go into the record word for word.
- **Changed since your last visit**: rounds 3 to 6 of the last board had 2 to 6 open points each, so Needs you already narrows the page that far.
- **Several parts in one card**: the `group` field ties related cards together.

**Recommendation.**

Skip all three. Code blocks were the one addition worth making now.

**Discussion.**

**You, round 1 (Accepted):**

> OK this board gives me more ideas. We need a "general comments" text box at the end where I can enter comments or questions or ideas (like I am doing now, using a specific box).
>
> The page is only using like 2/3 of the page width; that's fine but it looks like we can do something useful with the sides?

**Claude, round 1:**

> Your two ideas are new points in round 2: a box for general comments, on the page now at the bottom, and an outline on the left side of wide screens.

### The project keeps a copy of each board

`project-copy` · Proposal · settled in round 4

**Decision.**

After each round, Claude writes the whole board into the project as one Markdown file, a record of the process: every point with its context, recommendation, decision and discussion, and the general comments. It's kept the way the project keeps plan or task files, beside the plan or task the board serves, and archived with it. The outcome, the decisions written for readers, goes into the project's own documents for them, which point to the board's file but don't hold the process. Claude asks when the project has no place for either. A small script in the skill writes the file from the board's data.

**Context.**

After each round, Claude writes the whole board into the project as one Markdown file: every point with its context, recommendation, decision and discussion, and the general comments. This file records the process. It's kept the way the project keeps plan or task files, beside the plan or task the board serves, and archived with it.

The outcome is a separate thing: the decisions, written for readers, go into the project's own documents for them, such as its record of decisions, a devlog or a spec. Those point to the board's file but don't hold the process. Claude asks when the project has no place for either.

**Detail.**

The skill carries a small script that turns the board's data, as `ArtifactData` saves it to files, into that Markdown, so the copy comes out the same way every round.

**Recommendation.**

Add both steps to the round loop.

**Discussion.**

**You, round 3 (Accepted):**

> Yes, but see above.

**Claude, round 3:**

> Reworded with the two levels from your general comment.

**You, round 4 (Accepted):**

### What happens to a board when it closes

`cleanup` · Your call · settled in round 3

**Decision.**

Once the work a board serves is finished, Claude offers to delete the board, and you confirm each delete. The work is finished when the plan or task file the board fed is archived, or when the discussion has clearly moved on to a separate one and this one is fully closed, which may be after implementation. Until then the board stays, and a later question on the same work goes on it as a new point, not on a new board.

**Context.**

Boards stay in your claude.ai gallery until deleted, one per discussion. I know of no limit on how many you can keep; the cost is clutter, though the gallery lists the most recent first. A board closes when every point is settled and nothing is left to raise, and by then the project holds its copy.

**Options.**

- **Delete it** (recommended): Claude offers to delete the board once the project has its final copy, and you confirm each delete.
- **Keep it, marked closed**: The page shows it's closed and takes no more answers. Old boards are deleted by hand.

**Recommendation.**

Delete it. Once the project has the copy, the board adds nothing, and a delete always needs your yes.

**Discussion.**

**You, round 3 (Option: Delete it):**

> OK but clarify when - this needs to be after that discussion / plan whatever is fully completed (which might be after its implementation). For example, this might happen when we archive a plan / task file, or when we move to a clearly separate discussion and the previous one is fully closed. Otherwise we would keep opening and closing boards.

### Where this board's copy goes in dotclaude

`this-board` · Your call · settled in round 3

**Decision.**

This board's copy goes in `skills/decision-board/DESIGN.md`, published with the skill, with the quotes from another project taken out. It records the process; `SKILL.md` holds the outcome.

**Context.**

dotclaude has no place for discussions, and this board's decisions go into the skill's `SKILL.md`. The repository is public, and this board quotes your answers on a board in another project.

**Options.**

- **skills/decision-board/DESIGN.md** (recommended): Published with the skill, with the other project's quotes taken out. Later edits to the skill can see why it works as it does.
- **A local file git ignores**: On this machine only, quotes included.

**Recommendation.**

`skills/decision-board/DESIGN.md`, without the other project's quotes.

**Discussion.**

**You, round 3 (Option: skills/decision-board/DESIGN.md):**

### Publish the skill in dotclaude, or keep it local

`publish` · Your call · settled in round 1

**Decision.**

Publish the skill in dotclaude, with its own `.gitignore` line and a row in the README.

**Context.**

dotclaude publishes a skill only once it has its own line in `.gitignore`. This one holds nothing private: a generic page and a protocol. `remote/setup.sh` clones the repository from GitHub, so a skill kept local never reaches cloud sessions.

**Options.**

- **Publish it** (recommended): Its own .gitignore line and a row in the README.
- **Keep it local**: Only this machine has it.

**Recommendation.**

Publish it.

**Discussion.**

**You, round 1 (Option: Publish it):**

## Second opinion

### Record each round before opening the next

`r-recover` · Proposal · settled in round 6

**Decision.**

Each round runs in this order: the board's points, then the project's records, then the next round and the Submit thread. An open round then means the one before it is fully recorded. Rounds carry no claim: one session at a time handles a board.

**Context.**

The round loop opens the next round and resolves the Submit thread before it writes the project's records. If the session ends between those steps, nothing shows that the round was never recorded. The review proposes recording first and opening the next round last, so an open round means the one before it is fully recorded. It also proposes a claim on each round, for two sessions watching one board.

**Recommendation.**

Reorder the loop: the board's points, then the project's records, then the next round and the thread. Skip the claim: two sessions on one board is rare, and you can tell one to stop.

**Discussion.**

**You, round 6 (Accepted):**

### A script for each round's bookkeeping

`r-helper` · Proposal · settled in round 6

**Decision.**

The skill carries a helper script for the bookkeeping. Claude writes a short file of decisions and replies, and the script builds the writes from the board's saved data, in batches of at most 50 with the round's header last, after checking the data is complete. It also seeds a board, and keeps a public copy's redactions repeatable.

**Context.**

Every round so far took a script written for it: copying answers into threads, settling, splitting writes into batches, pinning versions. The review proposes one helper in the skill. Claude writes a short file of decisions and replies, and the helper builds the writes from the board's saved data, in batches of at most 50 with `board/meta` last, after checking the data is complete. The same helper would seed a board and keep the redactions of a public copy repeatable.

**Detail.**

What Claude would write for a round:

```json
{
  "settle": { "names": "The two kinds are called Your call and Proposals." },
  "reply": { "base": "It's what the skill would tell Claude to do, yes. …" },
  "add": [{ "id": "r-order", "kind": "proposal", "title": "…", "context": "…" }],
  "roundNote": "- …"
}
```

The saved data carries no versions, so the helper also reads them from a small file Claude writes from the listing.

**Recommendation.**

Write it. It turns the most error-prone part of each round into one checked step.

**Discussion.**

**You, round 6 (Accepted):**

### Show whether a Claude session is listening

`r-notify` · Your call · settled in round 6

**Decision.**

The page says when no Claude session is listening, before you submit, and offers Notify Claude on a submitted round that no session received, once one is listening.

**Context.**

When no session is watching, Submit still saves the round, and only afterwards does the page say to tell Claude in the terminal. The review proposes saying so before you submit, and offering a Notify Claude button on a submitted round that no session received, once one is watching again.

**Options.**

- **Both** (recommended): A line above Submit when no session is watching, and Notify Claude on a round no session received.
- **Only the line above Submit**: No new button.
- **Neither**: Keep the note after Submit.

**Recommendation.**

Both. A board answered on a phone after the session ended is when this helps, and the button needs your tap each time.

**Discussion.**

**You, round 6 (Option: Both):**

### Keep what an earlier answer agreed to

`r-wording` · Proposal · settled in round 6

**Decision.**

When Claude changes a card's recommendation, options or scope after you've answered it, the discussion gets a short before-and-after excerpt of the change; ordinary rewording needs none. A reopened decision links to the one it replaces.

**Context.**

When Claude changes a card's recommendation, options or scope after you've answered it, the card shows only the new wording, so an earlier answer can read as agreeing to something it didn't. The review proposes a short before-and-after excerpt in the discussion for each such change, with none needed for ordinary rewording, and a link from a reopened decision to the one it replaces. One point on this board went from a call with options to a proposal after your answer.

**Recommendation.**

Add it to the round loop's reply step.

**Discussion.**

**You, round 6 (Accepted):**

### Tie each board to its work and its records

`r-binding` · Proposal · settled in round 6

**Decision.**

When a board starts, the plan or task file it serves names the board's link, the path of its copy and the documents that take its outcome, and after each round the last round fully recorded. A new session finds the board from there, or by title when the project doesn't name it. A board is ready to close when every submitted round is recorded and its copy and outcome documents are current.

**Context.**

When a board starts, the plan or task file it serves names the board's link, the path of its copy and the documents that take its outcome, and after each round the last round fully recorded. A new session then finds the board and its records from the project instead of by title. A board is ready to close when every submitted round is recorded and the copy and outcome documents are current.

**Recommendation.**

Add it, with the search by title kept for a board the project doesn't name.

**Discussion.**

**You, round 6 (Accepted):**

### Getting around a board on a phone

`r-phone-nav` · Your call · settled in round 6

**Decision.**

On narrow screens the board has a collapsed Jump to list at the top, with Next unanswered. The bar stays as short as it is.

**Context.**

The outline shows only on wide screens. On a phone with many open cards, reaching the next unanswered one or the general comments box means scrolling. The review proposes a collapsed "Jump to…" list at the top on narrow screens, with a "Next unanswered" entry.

**Options.**

- **A Jump to list at the top** (recommended): Closed until you tap it; the bar stays as short as it is now.
- **Leave it**: Scrolling is fine at these sizes.

**Recommendation.**

Add the list. It helps most on long boards and takes no room while closed.

**Discussion.**

**You, round 6 (Option: A Jump to list at the top):**

### Long discussions on a card

`r-latest` · Your call · settled in round 7

**Decision.**

Cards keep their order, and so does each card's discussion, oldest first. Past four messages, a discussion folds its earlier messages behind "Earlier discussion", and the last two stay open, still in order. The hint under every card moves to the line under the header, with the warning kept for a Discuss without text.

**Context.**

Cards keep their order, and so does each card's discussion, oldest first. The question is only what a card shows once its discussion gets long. In both cases the hint under every card ("A comment is optional with Accept or an option…") moves to the line under the header, with the warning kept for a Discuss without text.

**Options.**

- **Fold the older messages** (recommended): Past four messages, the earlier ones fold behind "Earlier discussion", and the last two stay open, still in order.
- **Show everything**: As now: the whole discussion, oldest first.

**Recommendation.**

Fold. Nothing moves, and a point that runs for many rounds stays readable.

**Discussion.**

**You, round 6 (Discuss):**

> Maybe... but also keeping the same order in which cards were seen helps so I am not sure. Do we need a fixed rule?

**Claude, round 6:**

> No fixed rule is needed for the order: cards, and each card's discussion, keep the order you saw them in. The only question is whether a long discussion folds its older messages, and the card now asks just that.

**You, round 7 (Option: Fold the older messages):**

### Ask first the questions others depend on

`r-order` · Proposal · settled in round 6

**Decision.**

When some points depend on how another is decided, the governing one goes first and the dependent ones come once it's settled. Each option's note says what that choice leads to.

**Context.**

When some points depend on how another is decided, the governing one goes first and the dependent ones come once it's settled, so answers don't come with conditions. Each option's note says what that choice leads to.

**Recommendation.**

Add it to the rules for writing a point.

**Discussion.**

**You, round 6 (Accepted):**

### When a board is worth it

`r-trigger` · Your call · settled in round 6

**Decision.**

The trigger stays: four or more points, or any point likely to need more than one round, with the board offered first.

**Context.**

The settled trigger is four or more points, or any point likely to need more than one round. The review would make the second half one reason among others: many chat questions take a few rounds too, while a board adds a page, submissions and records. It would keep offering first.

**Options.**

- **Keep the trigger** (recommended): Offering first already filters: an offer that isn't worth it costs one line.
- **Adjust it**: Offer a board when several points gain from being answered together on cards; several rounds alone isn't enough.

**Recommendation.**

Keep it. Since Claude offers first, a board you don't need costs you one "no".

**Discussion.**

**You, round 6 (Option: Keep the trigger):**

## Second opinion (Sol)

### Finishing a round a session left halfway

`s-recover` · Proposal · settled in round 8

**Decision.**

A round a session left halfway, with its points written but the next round not open, is finished by saving the board's data again and running `board.py round` with a round file holding only `round` and `round_note`. The helper finds the answers and replies already in the threads, writes nothing twice, and leaves the copy, the records and the next round.

**Context.**

If a session ends after a round's points went in but before the next round opened, a new session can finish it: save the board's data again and run `board.py round` with a round file holding only `round` and `round_note`. The helper finds the answers and replies already in the threads and writes nothing twice, so all that's left is the copy, the records and the next round. The review proposes writing this recipe into the skill.

**Recommendation.**

Add it to Picking a board up in a new session.

**Discussion.**

**You, round 8 (Accepted):**

### When Claude writes the versions file

`s-versions` · Your call · settled in round 8

**Decision.**

The versions file is written after the first run of `board.py round`, which names the few documents a round writes.

**Context.**

Today the first run of `board.py round` names the few documents whose versions it needs, and Claude writes them from the listings it already has. The review proposes writing every version while saving the board's data, before the first run, with a note that each listing was read to the end.

**Options.**

- **After the first run** (recommended): The helper names exactly the documents a round writes, often two or three.
- **While saving the data**: One step fewer, but every document's version, often thirty or more.

**Recommendation.**

After the first run. It asks for the few versions a round needs, and the snapshot check already catches a listing cut short.

**Discussion.**

**You, round 8 (Option: After the first run):**

### Every answer gets a settle or a reply

`s-coverage` · Proposal · settled in round 8

**Decision.**

`board.py round` refuses a round file that leaves an answer with neither a settle nor a reply, and a general comment without a `general_reply`, listing what is left without a response.

**Context.**

Today an answer the round file forgets is copied into its thread and nothing more, so the round looks done while that answer gets no response. The review proposes that `board.py round` refuses a round file that leaves an answer with neither a settle nor a reply, and a general comment without a `general_reply`.

**Recommendation.**

Make the helper refuse both, with the list of answers left without a response.

**Discussion.**

**You, round 8 (Accepted):**

### What to tell Claude, when no session heard the Submit

`s-tell` · Proposal · settled in round 8

**Decision.**

When no session heard a Submit, the bar offers a closed "What to tell Claude" toggle with a line to copy, naming the board and the round.

**Context.**

When a round's Submit reached no session, the bar says to tell Claude in the terminal. The review proposes a small "What to tell Claude" toggle under it with a line you can copy, such as: Resume the board "Decision Board Skill"; round 8 is submitted.

**Recommendation.**

Add it. It stays closed until you need it.

**Discussion.**

**You, round 8 (Accepted):**

### SKILL.md: the steps first, the reference after

`s-skill-order` · Proposal · settled in round 8

**Decision.**

`SKILL.md` gives the steps first (starting a board, the round loop, picking a board up, closing it) and the reference after (the data, the helper's files, exporting, changing the page), with the rules that need judgment kept with the steps.

**Context.**

Starting a board, the round loop and picking a board up come first, then the data and the helper's files as reference. Someone starting a board today reads the whole data model before the round loop. The rules that need judgment (settling, the order of questions, exact text, privacy, the records) stay with the steps.

**Recommendation.**

Reorder it, without cutting anything.

**Discussion.**

**You, round 8 (Accepted):**

### Make the count's jump easier to see

`s-count-cue` · Proposal · settled in round 8

**Decision.**

The count in the bar shows "next ›" after it and has a spoken name saying where it goes, and the Jump to list's entries have more room on phones.

**Context.**

The count in the bar ("3 of 8 answered.") takes you to the next unanswered point, but on a phone it reads as plain status. The review proposes a small arrow after it and a spoken name for screen readers, and more space between the entries of the Jump to list on phones.

**Recommendation.**

Do both.

**Discussion.**

**You, round 8 (Accepted):**

## General comments

**You, round 2 (Discuss):**

> This is great. A few notes - maybe you already know.
>
> - The discussion should be saved somewhere *in the project*, where appropriate (each project ore repo will have its own conventions for plans, discussions, task files, devlogs, etc.). I don't want the content of a board to live only on Claude artifacts - do you see my point?
> - Will artifacts keep accumulating in Claude and will this become a problem? Should we have a cleanup policy
> -

**Claude, round 2:**

> Yes, I see it: the board is where the discussion happens, but the project should hold all of it, not only the decisions. Both notes are new points in round 3: a copy of each board in the project, and what happens to a board when it closes. Your third bullet came through empty; if something was cut off, add it here.

**You, round 3 (Discuss):**

> Ish. The project should hold all of it to record the process (like we often store task files or plan files); but the entire process should not live at the level where decisions are summarized for readers. Do you see my point?

**Claude, round 3:**

> Yes, I think so: two levels. The board's copy is a record of the process, kept the way the project keeps plan or task files and archived with them. The outcome, the decisions written for readers, goes into the project's documents for readers, such as its record of decisions, a devlog or a spec. Those point to the board's copy but don't hold the process. The card on the project's copy now says this; tell me there if I still have it wrong.

**You, round 5 (Discuss):**

> Checking this on my phone. It seems alright. The panel at the bottom takes up too much space.
>
> “ Every point is settled. Drafts save as you go. Submitting notifies Claude.”
>
> We can surely remove “ Submitting notifies Claude” (I get a modal informing me anyways)
>
> Also not sure if we need to keep “Draft save as you go” there. It’s useful to know but also… takes up space to keep it there. Maybe we put it once at the start. (Also submitting notifies Claude)

**Claude, round 5:**

> Done. The bar shows only the count ("2 of 5 answered.", with "The rest carry over." when a round is partly answered), and a submitted round is one short line. "Answers save as you go, and Submit sends the round to Claude." is said once, under the header. On a phone the bar is tighter and its button reads "Accept rest". The skill's copy of the page gets the same change once its two reviews are done.

## Rounds

| Round | Submitted | Answered | Left open | General comment |
|---|---|---|---|---|
| 1 | 2026-10-24 10:37 | 16 | 0 |  |
| 2 | 2026-10-24 10:52 | 4 | 0 | yes |
| 3 | 2026-10-24 11:04 | 4 | 0 | yes |
| 4 | 2026-10-24 11:13 | 2 | 0 |  |
| 5 | 2026-10-24 11:30 | 0 | 0 | yes |
| 6 | 2026-10-24 11:43 | 9 | 0 |  |
| 7 | 2026-10-24 11:55 | 1 | 0 |  |
| 8 | 2026-10-24 12:21 | 6 | 0 |  |
