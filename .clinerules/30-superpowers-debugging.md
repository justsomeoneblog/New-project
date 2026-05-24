# Superpowers Debugging for Cline

Use this rule for bugs, test failures, regressions, unexpected behavior, or build failures.

Debugging sequence:

1. Reproduce the failure or inspect the reported evidence.
2. State what is known and what is still unknown.
3. Trace the smallest relevant path through the code.
4. Form one concrete hypothesis at a time.
5. Make the smallest fix that explains the evidence.
6. Verify the fix with the most focused command available, then broaden verification when risk justifies it.

Do not guess at fixes before collecting evidence unless the user explicitly asks for a speculative answer.

Reference docs:

- `docs/superpowers/skills/systematic-debugging/SKILL.md`
- `docs/superpowers/skills/verification-before-completion/SKILL.md`
