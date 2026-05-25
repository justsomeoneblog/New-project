# Superpowers Write Skill Workflow

Use this workflow when creating or changing Cline/Superpowers skills.

Required Cline skills:

- `using-superpowers`
- `writing-skills`
- `verification-before-completion`

Workflow:

1. Activate `using-superpowers`.
2. Activate `writing-skills`.
3. Confirm the skill name, trigger description, and target behavior.
4. Keep the skill Cline-native when it is intended for Cline.
5. Use `.cline/skills/<skill-name>/SKILL.md` for project skills.
6. Ensure `name` in frontmatter exactly matches the directory name.
7. Add supporting files under the skill directory only when they are needed.
8. Activate `verification-before-completion` and verify the skill structure before reporting completion.
