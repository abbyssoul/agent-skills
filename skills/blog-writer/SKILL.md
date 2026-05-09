---
name: blog-writer
description: Turns an existing conversation, interview transcript, raw notes, or draft into a structured personal technical blog post with a hook, motivation, deep technical explanation, and standalone conclusion. Use when the user asks to write, synthesize, edit, or convert gathered material into a blog article or Jekyll post.
---

# Blog Writer

Turn existing material into a clear, engaging, personal technical blog post. Use the conversation so far, supplied notes, transcript, or draft as source material; do not conduct a full interview unless a missing detail blocks the article.

## Quick Start

When asked to write the post, first extract:

- Thesis: the central claim the post should make.
- Reader promise: what the reader will understand or be able to do by the end.
- Personal motivation: the story, frustration, surprise, or shift in belief that makes the topic matter.
- Technical substance: definitions, mechanisms, examples, tradeoffs, objections, and practical advice.
- Gaps: missing facts that need either a short follow-up question or a `[TODO: ...]` marker.

Then write an essay-style article, not a Q&A transcript, unless the user explicitly asks for Q&A.

## Article Shape

Aim for about 1500 words or fewer unless the user asks for long-form depth. Structure the article so it works for both linear readers and skimmers.

- Hook: open with a specific tension, surprise, concrete scene, or contrarian claim.
- What this is about: state the topic and reader promise early.
- Motivation or personal story: explain why this idea matters to the author and what changed their mind.
- Main argument: develop the thesis through clear claims and examples.
- Technical deep dive: include enough implementation detail, mental models, tradeoffs, or edge cases for technical readers.
- Objections and nuance: address what a smart critic would get right.
- Practical implication: explain what an engineer, lead, founder, or team should do differently.
- Standalone conclusion: recap the thesis, why it matters, and the practical takeaway so a reader who skipped to the end can decide whether the article was worth their time.

## Writing Principles

- Preserve the user's voice: reflective, direct, technical, personal, and pragmatic.
- Prefer concrete scenes, examples, and claims over generic explanation.
- Do not invent facts, anecdotes, quotes, projects, metrics, or personal experiences.
- Keep technical explanations readable: define terms before using them heavily, then go deep where it matters.
- Use headings that communicate the argument, not vague labels like `Introduction` or `Conclusion`.
- Avoid overstating certainty. Preserve real tensions and unresolved questions.
- If the source material mentions AI, connect it to the argument only where it genuinely belongs.
- Keep the opening and ending strong; cut throat-clearing and summary repetition.

## Workflow

1. Review the supplied material and conversation so far.
2. If style context is needed in a Jekyll blog repo, read a few existing `_posts/*.markdown` files.
3. Extract thesis, supporting claims, examples, definitions, objections, and unresolved gaps.
4. Ask one short follow-up question only when the missing answer is essential to the post.
5. Otherwise, write the article and mark non-blocking gaps with `[TODO: ...]`.
6. If writing to a file, use `_drafts` for in-progress posts unless the user requests publication in `_posts`.
7. Finish by reporting the file path and any remaining `[TODO: ...]` items.

## Jekyll Post Rules

- Published posts live in `_posts`.
- In-progress posts live in `_drafts`.
- Use file names like `_posts/YYYY-MM-DD-slug.markdown` for published posts.
- Never overwrite an existing post without explicit permission.
- Prefer existing tags from `_tags`.
- If adding a new tag, create `_tags/<tag>.md` with `slug: tag` frontmatter.

Use this frontmatter shape for published posts:

```yaml
---
layout: post
title:  "Post Title"
date:   YYYY-MM-DD HH:MM:SS +1000
categories: engineering
tags: [engineering, philosophy]
---
```

## Completion Criteria

For a draft in chat, finish with the article and a short list of remaining assumptions or `[TODO: ...]` items.

For a file, finish with the file path, whether it is a draft or published post, and any remaining `[TODO: ...]` items.
