---
name: brainstorm
description: Explore multiple approaches, generate prototypes, and brainstorm solutions before committing to implementation. Use for design exploration, architecture decisions, and scoping.
trigger: /brainstorm
---

# /brainstorm

Help the user explore the solution space before writing production code. Generate multiple approaches, create quick prototypes, and let the user react before you commit to a direction.

## When Invoked

### Step 1 - Understand the problem

Ask clarifying questions about:
- What problem are they solving?
- What constraints exist (tech stack, performance, compatibility)?
- What scale are we working at?

### Step 2 - Search the codebase

Use search tools to understand:
- What already exists that's related
- What patterns and conventions are used
- What dependencies are available

### Step 3 - Generate multiple directions

Present 3-5 distinct approaches, ordered from cheapest to most ambitious:
- Each approach should have a clear label, 2-3 sentence summary, and trade-offs
- Cover different design philosophies, not just minor variations
- Include one "wildcard" approach that challenges assumptions

### Step 4 - Prototype on demand

If the user wants to see something concrete, build a quick prototype:
- Use a single HTML file with inline CSS/JS when possible
- Use fake/mock data - do NOT wire up real backends or state management
- Focus on the part they need to react to (layout, interaction, flow)
- Keep it disposable - the goal is feedback, not production code

### Step 5 - Narrow scope

After the user reacts, help them define the right scope:
- What's essential for the first version?
- What can be deferred?
- Is there a simpler framing of the problem?

## Example Prompts You Should Handle

- "Make me an HTML page with 4 wildly different design directions so I can react"
- "Before wiring anything up, make a single HTML file mocking the new feature with fake data"
- "Search the codebase and brainstorm 10 places we could intervene, from cheapest to most ambitious"
