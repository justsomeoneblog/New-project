# Superpowers Parallel Research Workflow

Use this workflow when there are two or more independent documentation or codebase lookup tracks.

Required Cline skills:

- `using-superpowers`
- `dispatching-parallel-agents`
- `subagent-driven-development`

Workflow:

1. Activate `using-superpowers`.
2. Activate `dispatching-parallel-agents`.
3. Identify independent domains.
4. Use Cline `use_subagents` for reading files, searching the codebase, and finding relevant documentation.
5. Give each subagent one focused prompt, exact scope, and required output.
6. Subagents must not edit files, install packages, commit, push, or create PRs.
7. Main Cline task reviews subagent findings and performs any edits.
8. Do not require the user to open manual tasks; keep coordination in the main Cline task.
