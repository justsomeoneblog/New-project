# Superpowers Multi-Agent Documentation Reading for Cline

Use this rule when a task would benefit from multiple independent documentation-reading tracks.

Cline may propose splitting work into separate documentation-reading tasks, but Cline must not automatically open `/newtask` or create a new task. The user decides whether to open another task.

Good candidates for proposed read-only tasks:

- Read planning docs and summarize the implementation workflow.
- Read debugging docs and summarize the debugging checklist.
- Read code review docs and summarize review expectations.
- Read git workflow docs and summarize branch or completion guidance.

Default behavior for separate documentation tasks:

1. Read only the relevant local docs under `docs/superpowers/skills/`.
2. Summarize findings with file references.
3. Do not edit files.
4. Do not run formatters, install packages, commit, push, or create PRs.
5. Do not change scope from read-only unless the user explicitly authorizes it.

Suggested wording:

> This can be split into independent documentation-reading tasks. I can propose the task prompts, and you can decide whether to open them with `/newtask`.

Reference docs:

- `docs/superpowers/skills/dispatching-parallel-agents/SKILL.md`
- `docs/superpowers/skills/subagent-driven-development/SKILL.md`
