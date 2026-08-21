#!/bin/bash
# PreToolUse hook (Bash): guard against dangerous git operations.
# Decides from the actual command text in the hook's stdin JSON.
# Outputs a block decision JSON ONLY when the command really matches.
#
# Why not use `if` matchers: v2.1.233–2.1.237 have a misfire bug where a
# Bash command containing an undefined $VAR trips the matcher and the
# last hook in the list blocks it with a bogus reason (see
# ~/.claude/hooks-misfire-bug.md). This hook has no `if`, so it runs on
# every Bash call and self-checks the real command — immune to misfires.

INPUT=$(cat 2>/dev/null) || exit 0
CMD=$(printf '%s' "$INPUT" | jq -r '.tool_input.command // .input.command // empty' 2>/dev/null)
[ -n "$CMD" ] || exit 0

# Flatten newlines so multi-line commands still match
FLAT=$(printf '%s' "$CMD" | tr '\n' ' ')

block() {
  printf '{"decision":"block","reason":"%s"}' "$1"
  exit 0
}

contains() { printf '%s' "$FLAT" | grep -qE "$1"; }

# 1. force push（--force，含 --force-with-lease / --force-if-includes）
if contains 'git push[[:space:]].*--force'; then
  block "禁止 force push。如确需执行，请手动操作"
fi
# 2. force push（-f，独立参数）
if contains 'git push[[:space:]](.*[[:space:]])?-f([[:space:]]|$)'; then
  block "禁止 force push（-f）。如确需执行，请手动操作"
fi
# 3. 任何 git push
if contains '(^|[^[:alnum:]_-])git push([[:space:]]|$)'; then
  block "禁止自动执行 git push。如确需执行，请手动操作"
fi
# 4. hard reset
if contains 'git reset[[:space:]].*--hard'; then
  block "禁止 hard reset，这是不可逆操作。如确需执行，请手动操作"
fi
# 5. --no-verify
if contains 'git[[:space:]].*--no-verify'; then
  block "禁止跳过 git hooks（--no-verify）。如确需执行，请手动操作"
fi
# 6. --no-gpg-sign
if contains 'git[[:space:]].*--no-gpg-sign'; then
  block "禁止跳过 GPG 签名（--no-gpg-sign）。如确需执行，请手动操作"
fi

exit 0
