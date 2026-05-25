# Cline Tool Mapping

Use this mapping when an upstream Superpowers skill names tools from another agent harness.

| Upstream term | Cline equivalent |
| --- | --- |
| `Skill` tool or "invoke a skill" | `use_skill` |
| `TodoWrite` | A visible Markdown checklist in the response, or Cline's task UI if available |
| `Task` tool or "dispatch subagent" | `use_subagents` for reading files, searching the codebase, and finding documentation |
| Subagent implementation work | Main Cline task implements changes; Cline subagents only read/search/report |
| `Read` / `Grep` / `Glob` | Cline file reading and search tools |
| `Edit` / `Write` / `apply_patch` | Cline file editing tools in the main task only |

Rules for Cline subagents:

- Use subagents for research, codebase exploration, documentation reading/searching, and review.
- Do not ask subagents to edit files, install dependencies, commit, push, or create PRs.
- If a Superpowers skill says a subagent should implement a change, adapt it so the subagent investigates and reports, then the main Cline task performs the edit.
