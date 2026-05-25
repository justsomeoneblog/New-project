# Superpowers Branch Workflow

Use this workflow before starting isolated feature work, switching branches, or preparing a worktree.

Required Cline skills:

- `using-superpowers`
- `using-git-worktrees`

Workflow:

1. Activate `using-superpowers`.
2. Activate `using-git-worktrees`.
3. Check current git status and branch.
4. Do not overwrite or revert user changes.
5. Prefer the existing workspace when the user has already chosen it.
6. If a new branch or worktree is needed, explain why. Continue only when the user already requested branch/worktree work.
7. Never use destructive git commands unless the user explicitly requests and confirms them.
