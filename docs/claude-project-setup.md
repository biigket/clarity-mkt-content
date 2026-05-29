# Claude.ai Project Setup · Clarity Brand Assistant

Tier 2 AI agent · for **non-technical team members** (admins · marketers · หมอบิ๊ก) who access via web browser

Tier 1 (Claude Code subagents in `.claude/agents/`) is for technical team. Both can run in parallel.

---

## 🎯 What this gives the team

After setup · anyone with access to Claude.ai (https://claude.ai) can:
- Ask brand questions ("ใช้คำว่า 'ลด' ได้มั้ย?")
- Draft content (script · caption · LINE reply)
- Audit images by upload (vision input)
- Get hashtag suggestions
- Reference brand doctrine without reading 290-line CLAUDE.md

→ Same brand knowledge as Tier 1 · easier access · no terminal needed.

---

## 📋 Setup steps (one-time · ~30 minutes)

### Prerequisites
- Claude.ai account (Pro or Team plan for Projects feature)
- Access to repo files (clone or download)

### Step 1 · Create Project

1. Login at https://claude.ai
2. Sidebar → **"Projects"** → **"+ Create Project"**
3. Name: `Clarity Brand Assistant`
4. Description: `Internal AI agent for content team · brand-aligned generation · brand doctrine reference`
5. Click **"Create Project"**

### Step 2 · Add custom instructions

Click **"Set instructions"** · paste the entire content of `ai-prompts/01-master-system.md`:

```bash
# Copy file to clipboard (Mac)
cat ai-prompts/01-master-system.md | pbcopy

# Copy file to clipboard (Linux · X11)
cat ai-prompts/01-master-system.md | xclip -selection clipboard

# Or: open ai-prompts/01-master-system.md and copy manually
```

Paste into the instructions field · Save.

### Step 3 · Upload knowledge files

Click **"Add content"** → **"Upload files"** · upload these (in order):

| Priority | File | Purpose |
|----------|------|---------|
| 1 ⭐ | `CLAUDE.md` | Project memory · most critical |
| 2 ⭐ | `BRAND.md` | Full brand doctrine |
| 3 | `DECISIONS.md` | ADR log · decision rationale |
| 4 | `AUDIENCE.md` | 4 B2C personas |
| 5 | `PILLARS.md` | Content pillar definitions |
| 6 | `BUDGET.md` | Pricing + margin context |
| 7 | `playbook/product-positioning.md` | Per-service hooks |
| 8 | `playbook/guest-pass-system.md` | Referral system |
| 9 | `ai-prompts/01-master-system.md` | AI execution rules |
| 10 | `ai-prompts/02-script-generator.md` | Script generation prompt |
| 11 | `ai-prompts/03-hook-generator.md` | Hook bank prompt |

Total: ~11 files · all under 100KB combined.

### Step 4 · Share with team

Click **Project settings → Share** · add team emails:
- หมอบิ๊ก
- Marketing lead
- Admin (LINE OA manager)
- Content creator/editor
- Designer

Team needs Claude.ai accounts (Pro or Team plan).

### Step 5 · Test

Try these prompts to verify setup works:

```
"ขอ caption สำหรับโพสต์ PE1 · ทุก platform"
```
→ Should produce IG/FB/TikTok/YT captions with correct hashtag stacks

```
"ลูกค้าถาม 'เห็นผลกี่ครั้ง' · ขอ draft LINE reply 2 variants"
```
→ Should produce short + detailed variants · no forbidden words

```
"ใช้คำว่า 'หายขาด' ใน ads ได้มั้ย?"
```
→ Should reject + explain why + suggest alternative

```
[Upload image] "ตรวจ brand compliance หน่อย"
```
→ Should score + flag issues + suggest fixes

If all 4 work → setup complete.

---

## 🔄 Keeping Project knowledge fresh

### When to update knowledge files

Re-upload affected files when:
- `BRAND.md` updated (palette · forbidden words · founder · tagline · etc)
- `CLAUDE.md` updated (project state · workflow)
- New playbook added (member tier · admin scripts · etc)
- DECISIONS.md gets new ADR

### How to update

1. In Project · click affected file → Delete
2. Upload new version
3. Custom instructions stay the same (unless `ai-prompts/01-master-system.md` changed)

### Bulk re-sync (after major brand update)

```bash
# Pull latest
git pull origin main

# Open Project · delete all knowledge files
# Re-upload all in order (see Step 3 table above)
```

---

## 💡 Tips for team using the Project

### Best prompts

**Specific is better:**
- ✅ "Caption สำหรับ PE1 · IG Reel · เน้น hook educational"
- ❌ "เขียน caption"

**Reference clip IDs:**
- ✅ "Hook ads สำหรับ PE6 (60-80%) · 5 variants"
- ❌ "Hook โฆษณา"

**Specify platform/format:**
- ✅ "FB caption 250 chars · CTA หนัก"
- ❌ "Caption"

### When to NOT use Project

- ❌ Editing repo files (use Claude Code · Tier 1)
- ❌ Running scripts (use local Claude Code)
- ❌ Calling Phaya API (use local · sandbox blocks)
- ❌ Multi-file refactoring (use Claude Code)

---

## 🎯 Tier 1 vs Tier 2 quick comparison

| | Tier 1 · subagents | Tier 2 · Project |
|---|--------------------|------------------|
| **Access** | Claude Code (CLI) | claude.ai (web/mobile) |
| **Skill needed** | Terminal · git | Browser only |
| **Specialization** | 5 role-specific agents | 1 general assistant |
| **File operations** | ✅ Read · Write · Edit | ❌ View only |
| **Run scripts** | ✅ Bash · Make | ❌ |
| **Vision (image)** | ✅ | ✅ |
| **Web search** | ✅ | ✅ |
| **Update mechanism** | git pull | Manual file re-upload |
| **Cost** | Claude Code (free) | Claude.ai Pro/Team |
| **Best for** | Developer · power user · production | Admin · marketing · daily quick check |

---

## 🚀 Recommended team workflow

```
หมอบิ๊ก (review/approval)
   ↓ uses
Claude.ai Project (Tier 2) · audit content · approve scripts

Marketing lead
   ↓ uses
Claude.ai Project for daily · Claude Code (Tier 1) for batch work

Content creator/editor
   ↓ uses
Claude Code (Tier 1) · @script-generator · @caption-writer

Admin (LINE OA)
   ↓ uses
Claude.ai Project · "ขอ draft reply..."

Designer
   ↓ uses
Claude Code (Tier 1) · @image-prompt-builder
```

---

## 🔧 Troubleshooting

### Project doesn't seem to know brand rules

- Check custom instructions are set (not empty)
- Verify CLAUDE.md was uploaded as knowledge
- Try: "อ่าน CLAUDE.md แล้วบอก founder ชื่ออะไร" → should say นพ.ฐิติคมน์

### Knowledge not updated after BRAND.md change

- Knowledge files don't auto-sync with git
- Manually delete old version · upload new

### Team member can't access

- Verify their email is added in Project sharing
- Verify their Claude.ai plan supports Projects (Pro/Team)

---

## Cross-reference

- Tier 1 subagents → `.claude/agents/`
- Brand doctrine → `BRAND.md`
- Project memory → `CLAUDE.md`
- Local Claude Code setup → `docs/local-setup.md`
- AI prompt master → `ai-prompts/01-master-system.md`
