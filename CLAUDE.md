# Claude Context · Clarity MKT Content

> Auto-loaded by Claude Code at session start. Gives any new session the working context needed to operate immediately.

---

## What this repo is

**Clarity Clinic** content strategy + production assets
- **Type:** B2C dermatology clinic · Bangkok (ราชเทวี · ใกล้ BTS)
- **Hero treatment:** หลุมสิว (acne scar) · 5,000 ราคาเดียว · ไม่ผูกคอร์ส
- **Other services:** งานผิว · ยกกระชับ (3-service architecture per ADR-008)
- **Face:** หมอบิ๊ก (founder)

This repo holds **brand doctrine + AI prompts + ad/content briefs + production scripts**. Not application code.

---

## Brand essentials · DO/DON'T at a glance

### Single brand palette (espresso/brown · no other palettes)
- Base: `#3D2F24` → `#5C4534` (warm espresso gradient)
- Highlights: `#B8935B` · `#D4A574` (bronze-gold)
- Text: `#F5F0E8` (cream)

### Taglines (always use these · don't invent new ones)
- **Primary** (commercial CTA): `หลุมสิว 5,000 จบที่ Clarity ราชเทวี ใกล้ BTS`
- **Secondary** (philosophy · 1× per clip): `หลุมสิวต้องรักษาทุกชั้นผิว`
- **Internal pillar**: `หมอ 30% — คนไข้ 70%`

### Founder identity (verbatim · don't paraphrase)
- Display name: `นพ.ฐิติคมน์ (หมอบิ๊ก)`
- Specialty: `Aesthetic Doctor`
- License: `ว.61395`
- **NEVER**: "ดร.ฐิติคมน์" · "Dr.Thitikom" · "Dermatologist" (not board-cert)

### Forbidden words (CRITICAL · never use in any content)
- หายขาด · การันตี · 100% · อันดับ 1 · ที่สุด
- ครั้งเดียวเปลี่ยน · ครั้งเดียวจบ
- ราคาเริ่มต้นเพียง · ลดสูงสุดเพียงวันนี้
- เทคโนโลยีใหม่ที่สุดในโลก

### Anti-scarcity rule (brand-defining)
**Brand position = "ราคาคงที่ตลอดปี · ไม่มีลดราคา · ไม่ต้องรีบ"**

Never use:
- จำกัด X สิทธิ์ · เหลือ X ที่ · หมดเขต X · เฉพาะ X คนแรก
- Price slash (ราคาขีด · "ปกติ X,000 ลดเหลือ Y,000")
- Discount language (ลด · save · special offer · promotion)

Replace with: `ราคาเดียวตลอดปี · ไม่มีลดราคา`

### Service Equipment Stack (verified · don't add unverified)

**หลุมสิว (hero):** Subcision (manual · เข็ม · NOT machine) · Microneedle RF · Ablative Fractional Laser (CO2/ER:YAG) · Non-Ablative Fractional Laser (Thulium/ER:Glass) · Picolaser

**งานผิว:** Picolaser · Microneedle RF · Ablative Frac · Non-Ablative Frac · Long-Pulsed KTP · Long-Pulsed ND:YAG · Diode 4-wavelength

**ยกกระชับ:** HIFU · Microneedle RF · Synergy Dotting (RF+MFU)

**Acne scar brand line:** `Subcision · MNRF · Ablative Fractional Laser · Picolaser · All layers in 1 program`

**NEVER**: brand-specific machine names (Sylfirm X · Vbeam · Picosure · etc) · "best/newest in the world"

### Voice rules
- Refer to self: `หมอ Big` / `หมอ` (not formal `ผม`/`ดิฉัน`)
- Refer to audience: `คุณ` · `เธอ` · `พี่ๆ` (not `ลูกค้า` · `ท่าน`)
- 70% empathetic + warm · 30% technical depth
- Humor (5555) ok occasionally · พูดตรงๆ · ไม่ formal
- Voice speed for video: 1.3× (fast documentary pacing)

---

## Repo structure (quick map)

```
clarity-mkt-content/
├── BRAND.md                ← brand doctrine (north star · pillars · voice · forbidden words · founder · stack)
├── AUDIENCE.md             ← 4 B2C personas
├── PILLARS.md              ← 4 content pillars + clip outlines
├── CALENDAR.md             ← Month 1 day-by-day schedule
├── DECISIONS.md            ← ADR log (decisions made + pending)
├── BUDGET.md               ← margin analysis + marketing allocation
│
├── ai-prompts/             ← AI generation system
│   ├── 01-master-system.md ← paste as system prompt before any content session
│   ├── 02-script-generator.md
│   ├── 03-hook-generator.md
│   └── 04-rewrite-modifier.md
│
├── ads/                    ← ad creative briefs + assets
│   ├── month-1-hook-bank.md      ← 50 hooks
│   ├── scripts/AD01–AD06.md
│   ├── static-poster-acne-scar-v3-diagram.md
│   ├── carousel-ig-acne-scar-skin-layers.md
│   ├── video-reel-acne-scar-skin-layers.md
│   ├── condo-tv-loop-15s/        ← 15s silent loop (Phaya generation)
│   │   ├── generate.sh           ← t2i
│   │   ├── generate-i2i.sh       ← i2i (needs REFERENCE_URL)
│   │   └── prompts/cut{1,2,3}{,-i2i}.txt
│   └── assets/                   ← reference images for i2i
│
├── content/pillar-{1..4}/  ← clip briefs by pillar
├── video-briefs/           ← HeyGen briefs (18 clips)
├── playbook/               ← guest pass · member tier · product positioning
├── ops/                    ← admin verification scripts
│
├── scripts/                ← automation
│   ├── animate-condo-loop.sh    ← ffmpeg compose 3 PNG → 15s MP4
│   ├── upload-to-imgur.sh       ← image hosting helper
│   └── setup-mcp.sh             ← (legacy · revisit for cleanup)
│
├── docs/local-setup.md     ← local mode setup guide
├── Makefile                ← workflow shortcuts (make help)
└── .env.example            ← API keys template
```

---

## Local workflow (Makefile)

Run `make help` to see all. Most-used:

```bash
source .env                    # load API keys (PHAYA_API_KEY, REFERENCE_URL, etc.)
make check-env                 # pre-flight
make upload-ref IMG=path.png   # host image on Imgur · get REFERENCE_URL
make generate-i2i              # 3 cuts via Phaya i2i (preserves brand visual)
make generate-t2i              # 3 cuts via Phaya t2i (no ref needed)
make animate-loop              # ffmpeg compose → 15s MP4 (1920×1080 H.264)
make clean                     # remove generated files
```

---

## Phaya API · quick reference

Base: `https://api.phaya.io/api/v1`
Auth: `Authorization: Bearer $PHAYA_API_KEY`
Async pattern: `POST create` → `GET status/{job_id}` until `completed` → download `image_url`

### Endpoints

| Endpoint | Body fields |
|----------|-------------|
| `POST /gpt-image-2-text-to-image/create` | `prompt` · `aspect_ratio` · `resolution` |
| `POST /gpt-image-2-image-to-image/create` | `prompt` · `input_urls[]` · `aspect_ratio` · `resolution` |
| `GET /gpt-image-2-text-to-image/status/{job_id}` | — |
| `GET /gpt-image-2-image-to-image/status/{job_id}` | — |

### Constraints
- `aspect_ratio="auto"` works only with `resolution="1K"`
- `aspect_ratio="1:1"` doesn't support `resolution="4K"`
- `input_urls`: 1-5 URLs · JPEG/PNG/WEBP · ≤30MB each

### Aspect ratios
`auto · 1:1 · 5:4 · 9:16 · 21:9 · 16:9 · 4:3 · 3:2 · 4:5 · 3:4 · 2:3`

### Resolutions
`1K · 2K · 4K`

---

## Current state (as of last commit)

### ✅ Done
- Brand v2 doctrine merged (BRAND.md restructured · Founder Profile · Service Equipment Stack · Anti-Scarcity Rule)
- AI prompt system (4 phases · master + script + hook + rewrite)
- Month 1 content production (29 pillar briefs · 18 HeyGen video briefs · 6 ad scripts · 50 hook bank)
- DECISIONS.md (10 ADRs accepted)
- Static poster v3 diagram (validated · 95/100 brand compliance)
- Condo TV silent loop assets (3 cuts · t2i + i2i scripts · animate script)
- Local mode tooling (Makefile · .env.example · docs/local-setup.md)
- Google Sheets MCP integration
- Guest Pass system · Member Tier benefits playbooks

### 🔄 In progress / next
- User generating condo TV loop via Phaya i2i locally
- Animation via `make animate-loop`
- ฉสพ. license number overlay (compliance)
- Publish to condo TV system

### ⏸ Pending (revisit)
- Cleanup tech debt: `docs/google-sheets-mcp-setup.md` + `scripts/setup-mcp.sh` redundant with `.claude/hooks/setup-google-creds.sh`
- 5-layer ad variant (add Non-Ablative Fractional Laser to brand line)
- 9:16 vertical condo TV variant for lift door panels
- FB/IG sound-on 15s variant (with TTS)
- Compliance checklist file (`assets/ad-compliance-checklist.md`)
- Update `CALENDAR.md` to include new ads/ assets

---

## Common task patterns

### "Generate ad creative"
1. Read `BRAND.md` § Service Equipment Stack · Visual Identity · Anti-Brand
2. Read existing ad in `ads/` for pattern reference
3. Check `ai-prompts/01-master-system.md` for voice + forbidden words
4. Draft prompt → save in appropriate folder
5. If user wants generation: use `make generate-i2i` or write standalone curl

### "Audit an ad image"
1. Read image via Read tool
2. Cross-reference against `BRAND.md` checklist:
   - Palette match espresso/brown
   - Forbidden words absent
   - No scarcity/discount language
   - Founder identity correct (if shown)
   - Treatment stack accurate
   - Tagline coverage
3. Report compliance score · flag mismatches

### "Update brand doctrine"
1. Discuss change with user
2. Update `BRAND.md`
3. Sync `ai-prompts/01-master-system.md` (AI execution layer · must match)
4. Add ADR to `DECISIONS.md` if it's a significant pivot
5. Commit + push

### "Add new ad format"
1. Read existing variant in `ads/` for pattern
2. Create new `.md` brief in `ads/` with structure:
   - Concept · Asset Spec · Why this variant · Full Prompt · Compliance Checklist · Channel Adaptations · Cross-Reference
3. Commit + push

---

## Anti-patterns (don't do these)

❌ **Add scarcity language** — even for "limited offer" feels · ขัด Anti-Scarcity Rule
❌ **Show medical equipment images/silhouettes** in ads — compliance risk + brand says ห้าม
❌ **Use Dr.Big formal title** ("ดร.ฐิติคมน์", "Dr.Thitikom") — voice ขัด
❌ **Add brand-specific machine names** (Sylfirm X, Vbeam, Picosure) — ขัดความเป็นกลาง
❌ **Use sage green palette** — dropped in Brand v2 · single espresso palette only
❌ **Promise "หาย" / "100%" / "การันตี"** — forbidden + อย. risk
❌ **Subcision as machine** — เป็น manual procedure (เข็ม) · ห้ามใส่ machine icon
❌ **Add before/after photos** without consent + permit — กฎหมายโฆษณาสถานพยาบาล
❌ **Duplicate brand info in multiple files** — single source of truth principle · cross-reference instead

---

## Recent commits (context for what changed lately)

```
555809a Prepare repo for local Claude Code workflow
693ac15 Add Phaya i2i variant for condo TV loop generator
4084b01 Add condo TV silent loop generator · 15s · Phaya GPT Image 2
c5f3b62 Add acne scar skin-layers ad content trio (poster + carousel + reel)
21bc331 Merge PR #1 · Months 1 content production assets + DECISIONS + ad scripts
9bd04cf Merge PR #3 · Add Google Sheets MCP server configuration
f5fdbf9 Merge PR #2 · Add SessionStart hook for Google credentials
50257be Merge PR #4 · Brand v2 foundation
```

Run `git log --oneline -20` to see deeper history.

---

## When unsure · default behaviors

- **Brand questions** → Read `BRAND.md` first
- **AI generation** → Read `ai-prompts/01-master-system.md`
- **Past decisions** → Check `DECISIONS.md` (10 ADRs)
- **Service / pricing facts** → `BRAND.md § Service Equipment Stack` · `BUDGET.md`
- **Content pillars** → `PILLARS.md`
- **Audience targeting** → `AUDIENCE.md` (4 personas)
- **Production workflow** → `docs/local-setup.md` · `Makefile`

When user asks something that might affect brand → ask before changing doctrine files (BRAND.md · ai-prompts/). Small fixes can be committed directly to main · doctrine pivots should be discussed first.

---

## Communication style with user

- Thai-first (user writes Thai · mix EN ok for technical terms)
- Concise · use tables/bullets for comparison
- Show diff before committing changes
- Confirm before destructive ops (force push · branch delete · large merges)
- For ambiguous requests · offer 2-3 options · let user pick

---

## Cross-reference

- Brand doctrine → `BRAND.md`
- AI prompt master → `ai-prompts/01-master-system.md`
- All decisions → `DECISIONS.md`
- Local workflow → `docs/local-setup.md`
- Phaya API docs → https://phaya.io/docs
- Repo on GitHub → https://github.com/biigket/clarity-mkt-content
