# Superpowers Multi-Agent Research for Cline

Use this rule when a task would benefit from multiple independent read-only research tracks.

Cline may use Cline's native `use_subagents` tool for read-only research when the user asks for parallel research or when the task clearly benefits from it. For manual task splitting, Cline may propose `/newtask` prompts, but Cline must not open manual tasks automatically. The user decides whether to open another task.

Good candidates for proposed read-only tasks:

- Use `writing-plans` and summarize the implementation workflow.
- Use `systematic-debugging` and summarize the debugging checklist.
- Use `requesting-code-review` or `receiving-code-review` and summarize review expectations.
- Use `using-git-worktrees` or `finishing-a-development-branch` and summarize branch or completion guidance.

Default behavior for subagents or separate documentation tasks:

1. Use only relevant local project skills under `.cline/skills/`.
2. Summarize findings with file references.
3. Do not edit files.
4. Do not run formatters, install packages, commit, push, or create PRs.
5. Do not change scope from read-only unless the user explicitly authorizes it.

Suggested wording:

> This can be split into independent read-only research tasks. I can use Cline subagents for read-only research, or propose `/newtask` prompts if you want to open them manually.

Use these Cline skills when relevant:

- `dispatching-parallel-agents`
- `subagent-driven-development`
