# Agent Skills

<p align="center">
  <img src="assets/agents-skills.png" alt="Agent Skills" width="720">
</p>

A personal collection of AI agents and agent skills, kept in git and symlinked into local agent runtimes.

This repository is inspired by [Matt Pocock's skills repo](https://github.com/mattpocock/skills) and builds on top of that idea: small, composable pieces of agent behavior that can be versioned, edited, shared, and installed locally without turning the whole workflow over to a framework.

## What This Is

This repo stores two related kinds of agent configuration:

- `skills/`: reusable skill packs with focused instructions and workflows.
- `agents/`: standalone agent personas for specialized collaboration.

The goal is not to create a giant agent operating system. The goal is to keep useful working practices close to the metal: readable markdown, simple shell scripts, and prompts that can be improved over time.

## Why Keep This In Git

Agent behavior becomes part of the engineering environment. Keeping it in a repository makes it easier to:

- reuse the same agents and skills across machines and projects
- review changes to prompts like code
- genericize project-specific agents before sharing them
- keep local runtime directories clean with symlinks
- experiment without losing the previous version that worked

## Repository Layout

```text
.
├── agents/              # Agent persona files
├── assets/              # README and repo assets
├── scripts/             # Local linking and listing helpers
└── skills/              # Agent skills, one directory per skill
```

## Current Agents

- `critic`: architectural critique focused on intent, simplicity, and systemic risk.
- `podcast-host`: free-form interviewer for surfacing and sharpening ideas.
- `product-owner`: user-story and requirements steward for a repository.
- `reasoning-engine`: terse precision-reasoning persona for correctness-first answers.
- `reliability-engineer`: SRE perspective for reliability, toil, monitoring, and risk.
- `technical-product-owner`: bridge from product intent to architecture-aware technical plans.
- `troubleshooter`: methodical debugging and root-cause-analysis specialist.

## Current Skills

- `blog-writer`: turns notes, drafts, transcripts, or conversations into personal technical blog posts.
- `idea-interview`: conducts a podcast-host style interview to discover and sharpen an idea.

## Local Setup

Run the linker from the repository root:

```bash
./scripts/link-skills.sh
```

The script links skills and agents into supported local runtime directories when they exist:

- `~/.claude/skills`
- `~/.claude/agents`
- `~/.agents/skills`
- `~/.config/opencode/agents`

The links point back into this repository, so edits here are immediately reflected in local agent tools.

To list available skills:

```bash
./scripts/list-skills.sh
```

To remove all symlinks pointing to this repository from your local runtime directories (useful for cleaning up stale or broken links if you delete or rename an agent/skill in this repo):

```bash
./scripts/unlink-skills.sh
```

## Adding A Skill

Create a new directory under `skills/` with a `SKILL.md` file:

```text
skills/my-skill/SKILL.md
```

Keep skills focused. A good skill has a clear trigger, a small workflow, and enough instructions to change behavior without burying the agent in ceremony.

## Adding An Agent

Create a markdown file under `agents/`:

```text
agents/my-agent.md
```

Agents should describe a role, boundaries, operating method, and output expectations. Before committing an agent extracted from a project, remove project names, private paths, internal product assumptions, and domain-specific invariants that do not belong in the generic version.

## Design Principles

- Small prompts beat giant frameworks.
- Plain markdown beats hidden configuration.
- Symlinks beat copying files by hand.
- Versioned behavior beats mystery local state.
- Generic shared agents should not leak project-specific context.

## License

Apache-2.0. See `LICENSE`.
