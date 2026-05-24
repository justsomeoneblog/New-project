# Superpowers Testing for Cline

Use this rule for bug fixes, behavior changes, and risky refactors.

Testing guidance:

1. Prefer writing or updating a focused test that demonstrates the desired behavior before changing implementation.
2. Run the focused test and confirm it fails for the expected reason when practical.
3. Implement the smallest change that makes the test pass.
4. Run the focused test again.
5. Run broader verification when the change touches shared behavior or user-facing workflows.

If adding a test is impractical, explain why and use the strongest available manual or command-line verification.

Reference docs:

- `docs/superpowers/skills/test-driven-development/SKILL.md`
- `docs/superpowers/skills/verification-before-completion/SKILL.md`
