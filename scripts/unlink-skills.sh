#!/usr/bin/env bash
set -euo pipefail

# Unlinks all skills and agents that point into this repository
# from ~/.claude and ~/.agents directories.
# This is useful to remove stale links that may still point to a (re)moved agent or skill file.

REPO="$(cd "$(dirname "$0")/.." && pwd)"

unlink_items() {
  local dest="$1"
  if [ ! -d "$dest" ]; then
    return
  fi

  # Find all symlinks in the destination directory
  find "$dest" -maxdepth 1 -type l -print0 |
  while IFS= read -r -d '' symlink; do
    local target
    # Use readlink without -f to get the exact link target, which handles broken symlinks well.
    # The linking script uses absolute paths, so this will reliably match $REPO.
    target="$(readlink "$symlink")"
    case "$target" in
      "$REPO"|"$REPO"/*)
        rm "$symlink"
        echo "unlinked $(basename "$symlink") from $dest"
        ;;
    esac
  done
}

if [ -d "$HOME/.claude" ]; then
  echo "Unlinking for Claude CLI..."
  unlink_items "$HOME/.claude/skills"
  unlink_items "$HOME/.claude/agents"
fi

if [ -d "$HOME/.agents" ]; then
  echo "Unlinking for general agent tools (~/.agents)..."
  unlink_items "$HOME/.agents/skills"
  unlink_items "$HOME/.agents/agents"
fi
