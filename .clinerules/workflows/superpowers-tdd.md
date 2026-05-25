# Superpowers TDD Workflow

Use this workflow for bug fixes, behavior changes, and risky refactors.

Required Cline skills:

- `using-superpowers`
- `test-driven-development`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `test-driven-development`.
3. Write or update the smallest focused test that captures the behavior.
4. Run the focused test and confirm it fails for the expected reason when practical.
5. Implement the smallest code change that makes the test pass.
6. Run the focused test again.
7. Activate `verification-before-completion`.
8. Run broader verification when the change touches shared behavior or user-facing flows.
