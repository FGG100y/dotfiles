#!/usr/bin/env bash
# Clone/update vim pack plugins from packages/vim-plugins.list.
# Usage: vim-packsync.sh [--update]    default: clone missing only
set -euo pipefail

LIST="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/packages/vim-plugins.list"
UPDATE=0
[ "${1:-}" = "--update" ] && UPDATE=1

count=0
while IFS=$'\t' read -r target url branch _; do
    [ -n "$target" ] || continue
    case "$target" in \#*) continue ;; esac
    dir="$HOME/.vim/$target"
    if [ -d "$dir/.git" ]; then
        [ "$UPDATE" = 1 ] && git -C "$dir" pull --ff-only --quiet
    else
        mkdir -p "$(dirname "$dir")"
        git clone --quiet --depth 1 -b "$branch" "$url" "$dir"
    fi
    count=$((count + 1))
done < "$LIST"

echo "vim packs OK: $count plugins"
