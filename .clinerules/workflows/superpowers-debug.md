# Superpowers Debug Workflow

Use this workflow for bugs, regressions, failed tests, build errors, and unexpected behavior.

Required Cline skills:

- `using-superpowers`
- `systematic-debugging`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `systematic-debugging`.
3. Reproduce the failure or inspect the provided evidence.
4. State known facts and unknowns before changing code.
5. Trace the smallest relevant execution path.
6. Test one hypothesis at a time.
7. Make the smallest fix that explains the evidence.
8. Activate `verification-before-completion`.
9. Verify with the focused failing case first, then broaden verification when risk justifies it.
