#!/usr/bin/env bash
set -euo pipefail

# Links all skills in the repository to ~/.claude/skills, so that
# they can be used by the local Claude CLI.
# Also links skills and agents to ~/.agents if the directory exists.

REPO="$(cd "$(dirname "$0")/.." && pwd)"

check_dest() {
  local dest="$1"
  # If the destination is a symlink that resolves into this repo, we'd end up
  # writing the per-file symlinks back into the repo's own tree. Detect
  # and bail out instead of polluting the working copy.
  if [ -L "$dest" ]; then
    local resolved
    resolved="$(readlink -f "$dest")"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "error: $dest is a symlink into this repo ($resolved)." >&2
        echo "Remove it (rm \"$dest\") and re-run; the script will recreate it as a real dir." >&2
        exit 1
        ;;
    esac
  fi
  mkdir -p "$dest"
}

link_skills() {
  local dest="$1"
  check_dest "$dest"

  find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0 |
  while IFS= read -r -d '' skill_md; do
    local src
    src="$(dirname "$skill_md")"
    local name
    name="$(basename "$src")"
    local target="$dest/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      rm -rf "$target"
    fi

    ln -sfn "$src" "$target"
    echo "linked skill $name -> $src"
  done
}

link_agents() {
  local dest="$1"
  check_dest "$dest"

  find "$REPO/agents" -type f -name '*.md' -print0 |
  while IFS= read -r -d '' src; do
    local name
    name="$(basename "$src")"
    local target="$dest/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      rm -rf "$target"
    fi

    ln -sfn "$src" "$target"
    echo "linked agent $name -> $src"
  done
}

if [ -d "$HOME/.claude" ]; then
  echo "Linking for Claude CLI..."
  link_skills "$HOME/.claude/skills"
  link_agents "$HOME/.claude/agents"
fi

if [ -d "$HOME/.agents" ]; then
  echo "Linking for general agent tools (~/.agents)..."
  link_skills "$HOME/.agents/skills"
fi

if [ -d "$HOME/.config/opencode" ]; then
  echo "Linking agents for OpenCode..."
  link_agents "$HOME/.config/opencode/agents"
fi
