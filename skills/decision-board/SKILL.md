---
name: decision-board
description: Put the points a user has to decide on a decision board, a private claude.ai page where they answer each point and Claude replies on its card, round after round. Use when there are four or more points for the user, or a point likely to need more than one round; offer it in one line first. Needs the Artifact tools; without them, ask in the chat.
---

# Decision board

A decision board is one Artifact page with a database. Claude writes the points into the database. The user answers each point on the page and submits the round, and Submit posts a comment that wakes the Claude session watching the board. Claude then replies on the cards, settles what was decided and opens the next round.

Beside this file: `board.html`, the page, which holds nothing about any topic, so every board uses it unchanged; `board.py`, which seeds a board, builds each round's writes and exports a board as Markdown; and `DESIGN.md`, the copy of the board on which this skill was designed.

The steps come first, from When to use it to Closing a board; the reference follows, from The data on.

## When to use it

- Four or more points for the user to decide, or any point likely to need more than one round. One or two quick questions stay in the chat.
- Offer it first, in one line ("6 points to decide; put them on a board?"). A yes holds for the rest of the session.
- One board per discussion, named after its subject. A later question on the same work goes on the same board as a new point.
- It needs the `Artifact`, `ArtifactData` and `ArtifactComments` tools. Without them, as in Codex, ask in the chat. In cloud sessions, neither the tools nor the Submit notification have been tried: check that the tools exist, and use the chat when they don't.

## Two levels of record

The project keeps both what a board decided and how it got there:

- **The process.** After each round, write the whole board into the project as one Markdown file with `board.py export`. Keep it the way the project keeps plan or task files, beside the plan or task the board serves, and archive it with that plan or task.
- **The outcome.** Write each round's decisions, for readers, into the project's own documents for them: its record of decisions, a devlog, a spec. Each entry names the board and the round and points to the board's file. It doesn't copy the discussion.

The plan or task file the board serves names the board: its link, the path of its copy, the documents that take its outcome, and the last round fully recorded. Follow the project's conventions for all of these; when it has none, ask. The board is never the only copy.

## Starting a board

1. Copy `board.html` to the scratchpad as `<slug>.html` and replace `{{BOARD_TITLE}}` with the board's name, two to four words naming the subject. The `<title>` is the artifact's name in the gallery.
2. Publish it with the Artifact tool: `capabilities: {"db": {}, "comments": {}}`, `icon: "checklist"` and a one-sentence `description`. The publish starts this session's watch on the board.
3. Write the board's header and points as one JSON file (see The helper's files), run `python board.py seed <file> --out <dir>`, and send each batch it prints with `ArtifactData` `batch`.
4. Check with `ArtifactComments` `watch` (no url) that the board is connected with auto-replies armed.
5. Name the board in the plan or task file it serves (see Two levels of record), then give the user the link.

The page renders before its data arrives and fills in live, so seeding after the publish is fine. A second board in the same session needs its own scratchpad file: publishing the same path again updates the first board.

## Writing a point

- A title that names the decision, and a context of a few sentences. Anything longer goes in `detail`, behind a toggle.
- One recommendation. On a call, the option Claude leans to is marked `recommended`, and each option's note says what that choice leads to.
- When some points depend on how another is decided, the governing one goes first, and the dependent ones come once it's settled.
- When the point is about exact text or code, show it as a short snippet, never a large amount. For an insertion or an edit, show the changed part with enough context around it, as a before-and-after `diff` block where it can.
- Before asking a point, check the project's record, so a decided point isn't asked again. A point that reopens a settled decision names it, by title and id, and says what it would replace.
- Nothing private goes on the page, which the user can share: no credentials, tokens or personal data.

## The round loop

Submit wakes this session with a comment on the page's bar. An automatic reply may already be in that thread; don't post another. Each round runs in this order, so that an open round always means the one before it is fully recorded:

1. **Save the board's data.** `ArtifactData` `list` on `board`, `items`, `responses` and `rounds`, all with the same fresh `out_dir` and `query: {"limit": 1000}`; a collection longer than that continues from the listing's `next_cursor`. The listings show each document's version.
2. **Decide each answer**, into a round file (see The helper's files):
   - An Accept or a chosen option settles the point, with a `decision` written so it can go into the project's record as it stands.
   - An Accept or option with a comment that only refines the point settles it, with the refined decision.
   - A Discuss, or a comment that raises a new choice, gets a reply, with the card reworded if needed and a `changed` line saying how. The point stays open.
   - Unanswered points carry over as they are. A response with neither a verdict nor text is an answer the user cleared; `board.py` skips it.
   - A general comment gets a `general_reply`. A new idea in it becomes a new point.
3. **Build the writes**: `python board.py round <out_dir> <round file> --out <dir>`, with `<dir>` outside `<out_dir>`. It copies each answer into its point's thread and applies the round file. It refuses a round file that settles a point without the user's Accept or option, or that leaves an answer with neither a settle nor a reply, or a general comment without a `general_reply`. It refuses a snapshot holding fewer answers than the round's submission counted, or none of `rounds/r<N>`; for a round the user answered without submitting it, pass `--unsubmitted`. On its first run it lists the documents whose versions it needs; write them to a versions file and run it again with `--versions`.
4. **Update the points**: send each `points-*` batch it printed with `ArtifactData` `batch`.
5. **Write the project's records**: the board's copy with `board.py export` on `<dir>/after`, the data as it stands after the round; the round's decisions into the project's documents for readers; and the last round recorded, in the plan or task file.
6. **Open the next round**: send `open-next.json`, which sets `board/meta` to round N + 1 with the round note.
7. **Resolve the Submit thread** with `ArtifactComments` `resolve`, and tell the user in the terminal what was settled and what is open.

When an update changes a point's recommendation, options or kind after the user has answered it, `board.py` adds a before-and-after excerpt of those fields to the point's reply, so such an update needs a reply saying why. A change of scope in the context gets its excerpt in the reply by hand; ordinary rewording needs none.

Points can be added while a round is open; the page shows them live. A round can be submitted with points unanswered, and they carry over.

## Picking a board up in a new session

Look first in the project: the plan or task file names the board, its copy and the last round recorded. When the project names no board, the user can just name it: find it by title with the Artifact tool's `list` action, asking when more than one fits. Then run `ArtifactComments` `watch` with its url, so Submit reaches this session. The page source is needed only to change the page.

A round submitted after the last one recorded is finished from step 1 of the round loop. When its points went in but the next round never opened, as when a session ended between steps 4 and 6, save the board's data again and run `board.py round` with a round file holding only `round` and `round_note`. The answers and replies are already in the threads, so the helper writes nothing twice, and what's left is the copy, the records and the next round.

## Closing a board

A board closes when the work it serves is finished: when the plan or task file it fed is archived, or when the discussion has clearly moved on to a separate one and this one is fully closed, which may be after implementation. Until then it stays, and new questions on the same work go on it. It is ready to delete when every submitted round is recorded and its copy and outcome documents are current; then offer to delete it, and the user confirms each delete.

## The data

`board/meta`: `title`, `eyebrow` (a short line above the title), `intro`, `round` (the open round, from 1), `roundNote` and `roundNoteRound`. The note shows only while `roundNoteRound` equals `round`.

`items/<id>`, one document per point, sorted by `order`. The id is a short kebab-case name, shown on the card; `general` is taken by the general comments box:

```json
{
  "order": 10, "section": "The page", "group": "", "kind": "proposal",
  "title": "…", "status": "open",
  "context": "…", "detail": "…", "recommendation": "…",
  "options": [{ "key": "a", "label": "…", "note": "…", "recommended": true }],
  "changedRound": 2, "changed": "…",
  "thread": [{ "who": "you", "round": 1, "verdict": "Accepted", "text": "…" }],
  "decision": "…", "settledRound": 1
}
```

- `kind` is `proposal` or `call`. A proposal is a point where Claude has a reasoned default: one recommendation, and the user accepts it or comments. A call depends on the user's preference or on something Claude can't know: Claude says which way it leans, and the user chooses. Calls come first, highlighted, under "Your call"; a point without `kind` is a proposal.
- `section` heads a group of cards; `group` is a short label shown beside the id.
- `options` are for real alternatives only. A point without options gets an Accept button; every point also has Discuss and a comment box.
- `changed` shows as "Updated in round N" while `changedRound` equals the open round, which also opens the card's discussion.
- `thread` is the point's discussion and its lasting history; `who` is `you` or `claude`. Past four messages, the page folds the earlier ones behind "Earlier discussion".
- `status: "settled"` moves the card to the Settled tab, where it shows its title, `decision` and discussion.

`responses/<id>`: the user's answer, written by the page and overwritten each round: `round`, `verdict` (`accept`, `option` or `discuss`), `option` (the chosen key), `text`, `state` (`draft` or `submitted`) and `updatedAt`. `responses/general` is the general comments box at the foot of the page, in the same shape.

`board/general`: the box's `thread` and `changedRound`, as on a point.

`rounds/r<N>`: written on Submit: `round`, `submittedAt`, `answered`, `open`, `general`, and `notified` once a session received it or `notifyUnknown` when the send may or may not have gone through. Without `notified`, the page offers a Notify Claude button, which sends it again from the user's tap, and a "What to tell Claude" line to copy into a terminal; before Submit, it says when no session is listening.

`locks/submit`: a short lease the page takes while it submits, so one tab or device submits a round at a time.

Text fields take a small Markdown subset: paragraphs, `- ` bullets with one nested level, fenced code blocks (a `diff` block colors its `+` and `-` lines), `` `code` `` and `**bold**`. Option labels and notes are plain text.

## The helper's files

A board to seed, for `board.py seed`:

```json
{
  "meta": { "title": "…", "eyebrow": "…", "intro": "…" },
  "items": [
    { "id": "keep-names", "kind": "call", "section": "…", "title": "…", "context": "…",
      "options": [{ "key": "a", "label": "…", "note": "…", "recommended": true }], "recommendation": "…" }
  ]
}
```

A round, for `board.py round`; every key but `round` is optional:

```json
{
  "round": 6,
  "settle": { "<id>": "<decision>" },
  "reply": { "<id>": "<Claude's reply>" },
  "update": { "<id>": { "context": "…", "changed": "<how the card changed>" } },
  "add": [{ "id": "<id>", "kind": "proposal", "title": "…", "context": "…", "recommendation": "…" }],
  "general_reply": "…",
  "round_note": "- …"
}
```

Versions, as the listings show them, for the documents `board.py round` names: `{"items/<id>": 3, "board/meta": 5, "board/general": 2}`.

Both commands write each document as a JSON file under `<dir>/docs/` and print the batches as `writes` lists, which keeps quotes and code blocks intact. A batch holds at most 50 writes and stays under the 1 MiB a batch takes; a document over the database's 256 KiB is refused. A new point's `order` follows the last one unless it sets its own, and a new point starts open: it can't set `status`, `decision`, `settledRound`, `thread`, `changed` or `changedRound`. Running `board.py round` again on fresh data, after some of its writes went in, writes nothing twice: it recognizes the answers, replies and new points already on the board.

## Exporting a board

```bash
python board.py export <out_dir> --out <file.md> [--url <board url>] [--omit <id>] [--redact <file.json>]
```

The file has every point in the board's order, with its context, detail, options, recommendation, decision and discussion, then the general comments and the rounds. `--omit` leaves a point out, and `--redact` takes a JSON list of `[text, replacement]` pairs, for a copy that goes somewhere parts of the board shouldn't. The pairs apply to the board's text before it is laid out, then to the copy; each must match somewhere, and none may remain. Keep that list where the original text may be, not beside the copy. The script refuses a directory without `board/meta.json` and `items/`, so a mistyped path can't overwrite a good copy with an empty one.

## Changing the page

Edit `board.html` here, then republish a board from a fresh copy: in the session that published it, from the same scratchpad path; from another session, `read` the artifact first and publish with its `url`. Publishing keeps the database. The viewer shows no `alert`, `confirm` or `prompt` dialogs, so a confirmation step has to be part of the page; this one needs none, since every answer can be changed until Submit.
