# Superpowers Multi-Agent Research for Cline

Use this rule when a task would benefit from multiple independent documentation or codebase lookup tracks.

Cline may use Cline's native `use_subagents` tool to read files, search the codebase, and find relevant documentation when the task clearly benefits from parallel lookup.

Good candidates for subagent lookup tasks:

- Use `writing-plans` and summarize the implementation workflow.
- Use `systematic-debugging` and summarize the debugging checklist.
- Use `requesting-code-review` or `receiving-code-review` and summarize review expectations.
- Use `using-git-worktrees` or `finishing-a-development-branch` and summarize branch or completion guidance.

Default behavior for subagents:

1. Read relevant local project skills under `.cline/skills/`.
2. Search the repository for related rules, workflows, code, and docs.
3. Find external documentation only when the current environment/tooling allows it.
4. Summarize findings with file references and source links where available.
5. Do not edit files.
6. Do not run formatters, install packages, commit, push, or create PRs.
7. Return findings to the main Cline task for synthesis and implementation decisions.

Suggested wording:

> I will use Cline subagents for independent read/search/documentation lookup and then synthesize the results here.

Use these Cline skills when relevant:

- `dispatching-parallel-agents`
- `subagent-driven-development`
