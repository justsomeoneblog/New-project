# Superpowers Git Workflow for Cline

Use this rule when work touches branches, commits, PRs, or completion handoff.

Git safety:

1. Check repository status before staging, committing, switching branches, or pushing.
2. Do not overwrite or revert user changes unless the user explicitly asks.
3. Avoid destructive commands such as `git reset --hard`, forced checkout, or broad deletes unless the user explicitly authorizes them.
4. Stage only files relevant to the task.
5. Use clear commit messages that describe the behavior or documentation change.

Completion guidance:

1. Verify the work before claiming it is complete.
2. Report what changed, what was verified, and any remaining risk.
3. If a PR or branch cleanup is appropriate, ask or follow the user's explicit instruction.

Use these Cline skills when relevant:

- `using-git-worktrees`
- `finishing-a-development-branch`
- `verification-before-completion`
