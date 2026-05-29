# Claude Code Subagents · Clarity Brand Team

Auto-loaded when Claude Code starts in this repo · invoke by name (`@brand-auditor`, `@script-generator`, etc.)

---

## 🤖 Available agents (5 core)

| Agent | Role | Use case |
|-------|------|----------|
| **`brand-auditor`** | QA · compliance check | Review any creative before publish · score 0-100 + flags |
| **`script-generator`** | Content writer · scripts | Generate 45-60s clip script · saves to `content/pillar-X/` |
| **`caption-writer`** | Copywriter · captions | IG/FB/TikTok/YT/LINE captions + hashtag stack |
| **`line-responder`** | Admin · customer support | Draft LINE OA customer replies in brand voice |
| **`image-prompt-builder`** | Designer · prompts | Phaya/ChatGPT image prompts following brand · saves to `ads/` |

---

## 💡 How to use

### In Claude Code session

```
> @brand-auditor ดูรูปนี้ตรง brand มั้ย: ads/condo-tv-loop-15s/clarity-condo-cut1.png

> @script-generator ขอ script ใหม่ · pillar 3 (anti-mkt) · 60s · 
  หัวข้อ "ทำไม Clarity ไม่ join Black Friday"

> @caption-writer caption สำหรับ PE1 · ทุก platform

> @line-responder ลูกค้าถาม "เห็นผลกี่ครั้ง" · ขอ draft 2 variants

> @image-prompt-builder สร้าง prompt H1 Brand at a Glance · 1:1 · i2i mode
```

Agent อ่าน `CLAUDE.md` + relevant docs · ทำงานตาม role definition · return output

---

## 🎯 Pre-flight context every agent reads

ทุก agent อ่าน **CLAUDE.md** ก่อน (auto) · กับ files ที่ specific role ต้องการ:

| Agent | Reads | Why |
|-------|-------|-----|
| brand-auditor | CLAUDE + BRAND + master-system | Forbidden words · palette · anti-scarcity |
| script-generator | CLAUDE + BRAND + master-system + script-generator prompt + sample brief | Voice · format · pillar template |
| caption-writer | CLAUDE + BRAND + clip brief | Voice · hashtag stack |
| line-responder | CLAUDE + BRAND + playbook | Brand promise · pricing · positioning |
| image-prompt-builder | CLAUDE + BRAND + sample image briefs | Visual identity · founder · stack |

---

## 🔄 Update agents · workflow

1. Edit `.claude/agents/[agent-name].md`
2. Test in session (invoke agent · check output)
3. Commit + push
4. Team `git pull` → next session uses updated agent

---

## ⚙️ Each agent's allowed tools

| Agent | Tools | Why |
|-------|-------|-----|
| brand-auditor | Read · Grep · Bash | Read files · search forbidden words |
| script-generator | Read · Write | Read patterns · save new brief |
| caption-writer | Read | Read brief · output to chat (no file) |
| line-responder | Read | Read playbook · output to chat |
| image-prompt-builder | Read · Write | Read patterns · save prompt files |

(No tools that delete · execute network · or post to external services)

---

## 🚀 Add new agent

Create `.claude/agents/<name>.md` with frontmatter:

```yaml
---
name: agent-name
description: Clear description of when to use + what it does
tools: Read, Write, Bash  # optional · inherit all if omitted
model: sonnet | haiku | opus  # optional · sonnet is default
---

You are [role].

## Before you start
Read: CLAUDE.md + relevant files

## When to use
[criteria]

## Your job
[workflow]

## Quality check
[checklist]

## Communication style
[guidelines]
```

Commit · push · team has access.

---

## 🎯 Suggested next agents (build when needed)

| Agent | Role | Pri |
|-------|------|-----|
| `comment-replier` | Draft TikTok/IG comment replies | M |
| `ad-copy-writer` | Paid FB/IG/TikTok ad creative copy | H |
| `pillar-tracker` | Audit Notion mix vs target 27/23/33/17 | M |
| `repurpose-agent` | Suggest 5 derivatives from 1 hero clip | H |
| `hook-generator` | Generate 10 hook variants per topic | M |

---

## Cross-reference

- Project memory → `CLAUDE.md`
- Brand doctrine → `BRAND.md`
- AI execution layer → `ai-prompts/01-master-system.md`
- Local workflow → `docs/local-setup.md`
- Claude.ai Project setup → `docs/claude-project-setup.md` (Tier 2 · for non-tech team)
