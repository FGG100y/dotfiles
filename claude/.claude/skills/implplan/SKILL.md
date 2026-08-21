---
name: implplan
description: Generate a structured implementation plan in HTML format, highlighting the decisions most likely to change. Review the plan with the user before writing any code.
trigger: /implplan
---

# /implplan

When the user is ready to implement, generate an implementation plan for review. The plan surfaces decisions the user is most likely to tweak, and buries mechanical refactoring at the bottom.

## When Invoked

### Step 1 - Understand the task

Clarify what the user wants to build. If they've already described it (e.g., from a prior /brainstorm or /interview session), use that context.

### Step 2 - Search the codebase

Use search tools to understand:
- Where the changes need to go
- What existing code will be affected
- What patterns and conventions should be followed

### Step 3 - Generate the plan as an HTML file

Write a file named `impl-plan.html` in the current working directory.

The HTML must structure the plan like this (in priority order):

1. **Decisions You're Most Likely to Tweak** (TOP - most prominent)
   - Data model changes (new tables, fields, types, relationships)
   - New type interfaces and API contracts
   - User-facing changes (UX flows, new screens, behavioral changes)
   - Configuration and environment changes

2. **Implementation Steps** (MIDDLE)
   - Ordered list of changes, each with:
     - What file(s) to change
     - What to do
     - Why (rationale)
     - Dependencies on other steps
   - Clear sequencing: what must happen before what

3. **Mechanical Refactoring** (BOTTOM - de-emphasized)
   - Renames, file moves, formatting changes
   - Test updates
   - Documentation updates
   - Label these as "I trust you on this part"

### Step 4 - Present the plan

After writing the file, tell the user:
- "I've written the plan to impl-plan.html. Key decisions to review: [2-3 sentence summary of the most impactful choices]"
- Ask if they want to adjust anything before starting implementation

### Step 5 - Fresh session suggestion

Remind the user: "For the actual implementation, start a new session and pass this plan as context. This gives you a clean context window."

## Important

- Do NOT start implementing. This command only produces the plan.
- Write the HTML file; do not just describe the plan in chat text.
- Keep the HTML clean and readable - it's meant for human review, not machine parsing.
