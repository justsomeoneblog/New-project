# Superpowers Review Workflow

Use this workflow before merging, before a PR, after major implementation work, or whenever the user asks for review.

Required Cline skills:

- `using-superpowers`
- `requesting-code-review`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `requesting-code-review`.
3. Inspect the diff and relevant files.
4. Use Cline subagents only for read-only review when useful.
5. Put findings first, ordered by severity, with file and line references.
6. If there are no findings, say so and identify remaining test or verification risk.
7. Activate `verification-before-completion` before claiming the branch is ready.
