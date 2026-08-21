#!/bin/bash
# PostToolUse hook: auto-format & lint Python files after Write
set -euo pipefail

INPUT=$(cat)

# Extract the file path from Write tool input
FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys, json
data = json.load(sys.stdin)
tool_input = data.get('input', {})
# file_path can be at top level or nested in input
path = tool_input.get('file_path', '') or data.get('file_path', '')
print(path)
" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only process Python files
if [[ "$FILE_PATH" != *.py ]]; then
  exit 0
fi

# Check file still exists (might have been deleted)
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

echo "[hook] Formatting & linting: $FILE_PATH"

ruff format "$FILE_PATH" 2>&1 || true
ruff check --fix "$FILE_PATH" 2>&1 || true

echo "[hook] Done: $FILE_PATH"
