---
name: blindspot
description: Analyze a codebase or problem domain to find your "unknown unknowns" before starting work. Helps you understand what you don't know you don't know.
trigger: /blindspot
---

# /blindspot

Help the user discover what they don't know about a codebase, domain, or problem before they start implementing. This reduces costly mid-implementation pivots.

## When Invoked

You MUST do the following:

### Step 1 - Understand the user's starting point

Ask 1-2 questions to establish context:
- What are they trying to accomplish?
- What is their experience level with this codebase / domain?

### Step 2 - Search the codebase or domain

Use the search tools (Grep, Glob, Task) to understand:
- What relevant modules, patterns, or conventions exist
- What historical work has been done in this area
- What dependencies or constraints might be lurking
- What risks, edge cases, or gotchas are specific to this context

### Step 3 - Report your findings

Present a structured "blind spot report" covering:

1. **What exists that you may not know about** - relevant modules, conventions, historical decisions
2. **What could go wrong** - edge cases, compatibility issues, hidden constraints
3. **What "good" looks like in this domain** - the quality bar, unwritten standards, community best practices
4. **What questions you should be asking** - the right framing for follow-up prompts

### Step 4 - Suggest better prompts

End with: "Based on these blind spots, here are 3-4 refined prompts you should consider using instead."

## Example Behavior

If the user says: `/blindspot I'm adding a new auth provider but I know nothing about the auth modules`

You should:
1. Search for auth-related code, configs, middleware, tests
2. Map the auth architecture: how providers are registered, how tokens flow, what middleware chains exist
3. List conventions (naming, error handling patterns, test patterns)
4. Identify risks (session management, token refresh, OAuth state handling)
5. Suggest refined prompts that account for the discovered patterns
