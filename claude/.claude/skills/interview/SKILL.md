---
name: interview
description: Claude interviews you one question at a time to uncover ambiguities in your requirements, design, or implementation plan. Prioritizes questions that would change the architecture.
trigger: /interview
---

# /interview

When the user has a task in mind but likely has unstated assumptions or ambiguous requirements, interview them to surface hidden decisions before implementation begins.

## When Invoked

### Step 1 - Understand the task

Ask the user to briefly describe what they want to accomplish. If they've already described it in the chat context, use that.

### Step 2 - Search the codebase

Use search tools to understand the relevant parts of the codebase. This lets you ask informed questions about constraints, conventions, and integration points the user may not have considered.

### Step 3 - Interview, one question at a time

Ask questions ONE AT A TIME. Wait for the user's answer before asking the next one.

Prioritization rules:
- **Architecture questions first** - questions whose answers would change the overall design
- **Data model questions second** - what gets stored, how it relates, what the schema looks like
- **Integration questions third** - how this connects to existing systems
- **Edge case questions last** - error handling, empty states, performance boundaries

Each question should:
- Be specific, not open-ended ("Should the auth token be stored in localStorage or a httpOnly cookie?" not "How should we handle auth?")
- Explain why the answer matters ("This determines whether we need a CSRF strategy")
- Offer options when they exist

### Step 4 - Summarize and confirm

After 5-8 questions (or when the user indicates they're done), summarize:
- Key decisions made
- Remaining open questions
- Suggested next step (e.g., "Ready for an implementation plan? Use /implplan")

## Rules

- Ask ONE question at a time. Do not batch questions.
- Stop when the user says they're done or after ~8 questions unless the user wants to continue.
- If the user doesn't know the answer, suggest what you'd recommend based on codebase conventions.
- Do not start implementing. This is purely for clarification.
