---
name: plain-english
description: Find Claudish in a text (ordinary words in private senses, labels the reader can't decode, sentences that drop needed words or stack clauses, metaphors in place of plain statements) and fix it without changing the meaning. Claude fixes its own drafts and texts it was asked to edit; for other text it lists each problem with a plain rewrite. Use before handing over a long or important document, spec, plan, proposal, prompt or brief, and when the user asks for plain English or objects to wording. Also describes two checks by a fresh agent, one for clarity and one for meaning, which /doublecheck runs on long or important prose.
argument-hint: [file, or text to check]
---

# Plain English

Claude models drift into "Claudish": English that the reader has to decipher. Every word is real, and most sentences are grammatical, but the writer gives words private senses, refers to things by names it made up, and leaves out the words that link one idea to the next, so only the writer knows what the text means. This skill finds Claudish and either rewrites it or lists each problem with a plain rewrite, as the procedure below says. The Plain English section of the global `CLAUDE.md` gives the short rules; this file lists the habits in full, with examples, and gives the procedure.

Plain English is not simplified English: technical text keeps its technical terms, including new terms it defines for new concepts. The problem is private language, not technical language that the reader knows or that the text defines.

The habits below are signs to look for, not bans. The test is whether the intended reader can follow the text on one reading. A label, a short phrase or a compound that this reader understands at once is fine, and spelling everything out in full makes text as hard to read as Claudish does.

**Text to check:** $ARGUMENTS (if empty, check the draft or document under discussion).

## What plain English looks like

- The claim first, then why it matters, then an example.
- The general case first, then the exception.
- Sentences the reader can follow on one reading. Words such as "because", "so", "but" and "unless" show how the ideas connect.
- Each thing called by the name its reader already uses for it, and labels used only once the reader knows what they stand for.
- For a problem: what the issue is, with one example of the wrong behaviour and the expected behaviour.
- For a rule: when it applies and what to do.

## Where Claudish comes from

- **Long pieces of work.** Over hours or days on a task, Claude names the things it handles (options, steps, groups of files or results) and gives ordinary words narrow meanings. By the end its messages are written in that private vocabulary.
- **Copying.** A phrase coined once in a message goes into notes, plans, comments and documents. The next session or agent finds it there, treats it as settled wording and copies it on.
- **Text for other agents.** Briefs, prompts, plans and reports passed between agents contain the densest Claudish, whichever model wrote them, and the user reads them whenever they are quoted.
- **Fixing by addition.** Told to avoid private terms, Claude tends to keep the private word as the main term and bolt on a clause that defines it: "The stragglers, meaning the four tests that still fail, come next." The sentence gets longer and no clearer. Lead with the description instead; a label the reader will need again can follow in parentheses.

## The habits

In the examples below, the plain versions say what the writer meant, so some state facts that the original left out. When you fix someone else's text and can't tell what they meant, ask instead of supplying the facts.

### Words

**Ordinary words in private senses.** This is the commonest kind. Replace the word with what it means.

| Claudish | Plain |
|---|---|
| "This function is load-bearing." | "Three other functions depend on this one." |
| "The paragraph earns its place." | "The paragraph is worth keeping." |
| "Get a cold read before merging." | "Before merging, have someone who hasn't seen the draft review it." |
| "On my read, the second proof is cleaner." | "I think the second proof is cleaner." |
| "Keep the readings the reviewers flagged." | "Keep the interpretations the reviewers flagged." |
| "The new code holds the invariant." | "The new code keeps the invariant true." ("The invariant holds" is ordinary English.) |
| "The paragraph lands at 70 words." | "The paragraph comes to 70 words." (A patch that "landed" in the main branch is ordinary developer usage.) |
| "The second section carries the argument." | "The second section makes the argument." |
| "The honest answer is that we don't know." | "We don't know." |
| "The shape of the fix is clear." | "It is clear what the fix has to change." |
| "The testing story is weak." | "Few parts of the code have tests." |
| "This rerun was owed anyway." | "We had to rerun this anyway." |
| "The parked items" | "The items we postponed" or "the items we decided not to do": say which. |

Any ordinary word can drift this way, and a long project coins words of its own, such as "the headline and the guard" for a main rule and a narrow exception beside it. Standard technical terms, such as a guard clause in code, are fine for readers who know them. Replace a word when it is used in a sense the work gave it.

A project term that the user also uses is fine in text for the user; explain it to any other reader. Don't extend any term to things it was not used for: "the invariant holds" is standard English, but "the new code holds the invariant" is Claudish.

**One word in two senses.** A text uses "model" for a statistical model and for a language model; a paragraph uses "test" for a unit test and for a statistical test. Use a different word for one of the two senses.

**Labels the reader can't decode.** Short labels such as "option B", "step 3" or "the second fix" are useful shorthand, and so are replies built from them, once the reader knows what each label stands for. A label fails when the reader was never told what it means, when it was explained so long ago that they can't remember, or when the text goes to someone who never saw it introduced. Another failure is a made-up name for every option, step and group of items, so that the reader has to decode each one.

- "Option B is faster.", when the options were listed many messages ago → "Caching the results on disk (option B) is faster than recomputing them."
- "Fix the stragglers next.", when the four failing tests were never called that → "Next, fix the four tests that still fail."
- "Gates A and B become a single boundary.", when the reader never saw the gates defined → "We planned to stop twice: once when the data was cleaned, and once when the models were fitted. Now we stop once, after both."
- "Reply 'A delete, B yes, C yes' to accept." is fine when A, B and C are listed just above. It fails when the reader has to search the earlier conversation to find them; then list them again.

A new concept that the work keeps coming back to may get its own term, as this file does with "Claudish". Define such a term where it first appears and use it the same way throughout.

An ID the reader may need to look up (a file, a test, an issue number) goes after the description: "the test that checks every exported CSV file uses LF line endings (`test_csv_export_uses_lf`)".

**Runs of hyphenated compounds and noun strings made for the occasion.** An occasional compound that reads at once is fine, such as "the two-step fix". A run of them makes the reader unpack each one; unpack them into a clause instead.

- "the late-join partial-sync case" → "the case where a client joins late and has only part of the data"
- "the retry-safe single-write path" → "the code that writes each record once, even when the request is retried"

### Sentences

**Dropped words the reader needs.** A phrase without a verb is fine in a list, a heading or a status line where its meaning is clear. It fails when the reader can't tell what the missing words were.

- "Meanwhile, the migration script." → "Meanwhile I'm writing the migration script." (Or fixing it, or running it: the original doesn't say.)
- "The cache, not the network." → "The slowdown comes from the cache, not the network."

**Long sentences that stack clauses, a long phrase before the verb, or asides between the subject and its verb.**

- "A config file whose keys the loader, or the migration that rewrites old files, already normalises is skipped." → "A config file is skipped when its keys have already been normalised, either by the loader or by the migration that rewrites old files."
- "The worker, which the scheduler starts for each job and which needs write access to the cache, runs as a normal user." → "The scheduler starts a worker for each job. Each worker runs as a normal user and needs write access to the cache."

**Rules written as flat statements of fact, with the condition hidden.** The reader has to work out that the sentence is an instruction, and when it applies.

- "A setting only the admin can change is shown before a step needs it." → "If a step needs a setting that only the admin can change, the guide must show that setting before the step."
- "A function that writes to the database is covered by an integration test." → "If a function writes to the database, give it an integration test."

**The exception before the rule.**

- "Drafts are exempt. Otherwise, every page needs a reviewer's approval before it is published." → "Every page needs a reviewer's approval before it is published. Drafts don't need one."

**A special case without its outcome.** When a rule mentions a special case, say what happens in it.

- "Backups older than 30 days are deleted. Backups marked as kept are another matter." → "Backups older than 30 days are deleted, except those marked as kept, which are never deleted."

**Words that point at nothing.** "It", "either", "also" or "the clause", with no earlier words that they could refer to.

- "Either breaks the build." → "Removing the lock file or upgrading the compiler breaks the build."

**The order turned around.** A pronoun comes before the thing it refers to, or a result before the step that produces it.

- "The tests run on it once the build has produced the package." → "The build produces the package, and then the tests run on it."

### Images and rhetoric

**Metaphors where a plain statement exists.** A metaphor fails when the reader has to translate it back into the literal claim.

- "Batch size is the big lever." → "Batch size changes the run time most."
- "The index rebuild is the long pole." → "The index rebuild takes longest, so it decides when the job finishes."
- "The rule has no teeth." → "Nothing enforces the rule."
- "The sample names are just furniture." → "Nothing tests the sample names; they only make the example look real."
- "The parser chokes on tabs." → "The parser fails when the input contains tabs."

**A contrast with something nobody said.** An "X, not Y" sentence where no reader thought of Y: "This section lists the requirements, not a wish list." Keep a contrast only when the reader would otherwise assume Y.

**A closing flourish.** This is a sentence with two balanced halves that sounds like a conclusion but claims nothing checkable, or claims too much: "Speed and accuracy are therefore one problem, and this design solves it as one." State the concrete result, or delete the sentence.

**Answers to doubts the reader doesn't have, and comments on your own choices.** Cut "This is not a simple extension, since…" unless a reader would think it is simple. Write "Steps:", not "The steps, ordered so that each builds on the last:".

### The reader

- **The wrong addressee or speaker.** A README for people who install a tool tells "you" to edit files that only its maintainers touch. In instructions for Claude, the author is "the user" at first and then becomes "I" and "me", so it is unclear who is speaking. Write for the main reader of the text, and name the reader and the writer the same way throughout.
- **The wrong register.** Chat shorthand in a document; a README written like an advertisement; technical words in a summary for the public; a casual tone in a formal letter. Match the register to the reader and the kind of document.
- **The session's history in a document.** A rules file states the rules, not what changed ("unchanged", "still", "now"). "Documents have one reader" in the global `CLAUDE.md` covers this.
- **Decisions credited to the user.** If the user approved several of your recommendations together in one reply, call each of them "the recommendation you accepted", not "your decision".
- **A change shown in pieces.** When you ask the user to approve a change to a text, show the final text of the part that changes, not a diff fragment.

## Procedure

When asked to check a text (a file, a pasted passage or your own draft):

1. **Name the reader** and what they know: the user, who knows the project but not this session; a co-author; a reviewer or a panel; another agent that has only its brief; a model that sees only its prompt.
2. **Terms.** List every word or label that this reader would not understand in the sense used: words in private senses, labels they were never given or can't remember, IDs, and project terms this reader doesn't know. Replace a private word with what it means. Put a description before a label the reader can't decode, keeping the label in parentheses if it will come up again. A technical term stays; if this reader may not know it, define it where it first appears.
3. **Sentences.** Find the sentences this reader would have to read twice. For each, find the habit above that causes the problem.
4. **Reader.** Check the addressee, the register, the session's history and decisions credited to the user.
5. **Rewrite with the smallest change that fixes each sentence.** Replace a word, add a missing verb, put a description before a label, or split a long sentence. Restructuring a whole sentence or paragraph is where meaning drifts, so do it only when a smaller change doesn't work.
   - Rewrite the sentences that fail, not the whole text, unless asked to.
   - Keep technical terms, including terms the text defines. Don't turn a technical document into a version for laypeople.
   - Don't add statements that go without saying, such as "Apply each rule only to the cases it covers."
6. **Compare the meaning.** Put each rewritten sentence next to its original and check that it makes the same claims, under the same conditions, with the same scope ("all", "some", "only"), the same strength ("must", "should", "may"), the same hedges and the same numbers, and that each pronoun and label points at the same thing. Undo any difference you didn't intend. If you can't tell what the original means, don't guess a plain version: ask the user, or, if you are a sub-agent, report the sentence as unclear.
7. **Report.** If the text is your own draft from this session, or a text you were asked to edit, fix it and say briefly what you changed. Otherwise list each problem with its location, the quoted text and a plain version, and change the file only if the user asks.

## Checks by a fresh agent

Writers cannot see their own Claudish, because they know what every private term means. They also miss changes of meaning in their own rewrites, because they read the rewrite with the meaning they intended. A new agent that hasn't seen the session catches both. `/doublecheck` runs the check by a fresh reader on long or important prose (documents, specs, plans, proposals, prompts and briefs that people or models will act on), and the meaning check when a change rewrites such prose. Run them at other times when the user asks.

For each check, start a new Opus sub-agent (see Agent Selection in the global `CLAUDE.md`). Don't fork this conversation, and don't give the agent the session, the goals or what the text is meant to say. For a long text, have it write its report to a file you name and reply with the path.

### Check by a fresh reader

This check shows whether the text can be followed.

1. Give the agent three things: the text (as a path, or pasted in), a description of the intended reader, and the instructions in step 2.
2. Ask it to read as that reader and change nothing, and to report:
   - each paragraph, rule or item restated in plain words, in one or two sentences;
   - every word or phrase it had to guess at, with its guess;
   - every sentence it had to read twice, and what made it hard;
   - every instruction it would not know how to apply, or that seems to contradict another.
3. Compare its restatements with what the text is meant to say. Rewrite, with the procedure above, every sentence that the reader restated wrongly, read twice, or could not apply. For each guessed word, replace the word if the guess was wrong; if the guess was right, decide whether other readers would also guess right.
4. Run the check again on the rewritten text, with another new sub-agent, if you rewrote more than a few sentences or fixed instructions that contradicted each other. Otherwise stop.

### Meaning check

This check shows whether a rewrite still says what the original said.

1. Give the agent the original and the rewrite, side by side or as two files, and the instructions in step 2.
2. Ask it to change nothing and to list every difference in meaning between the two versions: claims added, dropped, weakened or strengthened; changed conditions, scope, numbers or hedges; and pronouns or labels that now point at something else. Ask it to quote both versions for each difference.
3. For each difference, keep the rewrite only if the change was intended and correct. Otherwise restore the original meaning in plain words.
