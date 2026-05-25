# Superpowers Finish Workflow

Use this workflow when implementation is complete and the user wants to commit, merge, push, or open a PR.

Required Cline skills:

- `using-superpowers`
- `verification-before-completion`
- `finishing-a-development-branch`

Workflow:

1. Activate `using-superpowers`.
2. Activate `verification-before-completion`.
3. Run the strongest relevant verification available for this repo.
4. Read the command output and report exact evidence.
5. Activate `finishing-a-development-branch`.
6. Check git status before staging or committing.
7. Stage only task-relevant files.
8. Commit only after verification evidence is available.
9. Merge, push, PR creation, or destructive cleanup should only happen when the user already gave explicit instructions.
