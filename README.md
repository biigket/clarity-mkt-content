# Clarity Clinic — Content Strategy

> Internal documentation สำหรับ content strategy ของ Clarity Clinic
> B2C dermatology clinic · Focus: หลุมสิว · ผิวกระจ่าง · ยกกระชับ
> Location: ราชเทวี / พญาไท / สยาม · Face: หมอ Big

---

## Quick Links

- [Brand Foundation](./BRAND.md) — North Star, Identity, Voice
- [Target Audience](./AUDIENCE.md) — 4 B2C personas
- [Content Pillars](./PILLARS.md) — 4 pillars + clip outlines
- [Calendar](./CALENDAR.md) — Schedule + Month 1 day-by-day
- [Decisions](./DECISIONS.md) — ADR + pending decisions
- [Budget & Margin](./BUDGET.md) — Margin analysis + allocation
- [Product Positioning](./playbook/product-positioning.md) — Per-product hook
- [Guest Pass System](./playbook/guest-pass-system.md) — Full SOP
- [Member Tier](./playbook/member-tier-benefits.md) — Upgrade benefits *(coming)*
- [Admin Verification](./ops/admin-verification-script.md) — Counter scripts *(coming)*
- [Playbook](./PLAYBOOK.md) — Production workflow *(to be created)*

## Local Workflow (Claude Code CLI)

- [Local Setup Guide](./docs/local-setup.md) — install · API keys · workflows
- `make help` — workflow shortcuts (generate · animate · upload)
- `.env.example` — API keys template (Phaya · ElevenLabs · Imgur)

---

## Project Status

| Item | Status |
|---|---|
| Strategy | Complete (May 2026) |
| Production | Pending kickoff |
| Channel | @clarityclinic (TikTok + IG) |
| Hero treatment | หลุมสิว 5K (5 หัตถการใน 1 session) |
| First post target | Week 1 ของเดือนถัดไป |

---

## Quick Context

**Clarity Clinic** = คลินิกผิว mid-tier ในย่านราชเทวี / พญาไท / สยาม

**Target audience:** พนักงานออฟฟิศ + Gen Y/Z working women ที่:
- มีปัญหาผิว (หลุมสิว, ฝ้า, ผิวหมอง, หย่อนคล้อย)
- กลัวโดน hard-sell
- ต้องการ "ทำหลายเครื่องในวันเดียว" — ประหยัดเวลา

### Service Architecture

```
ENTRY POINTS
├─ Free Consult + Trica3D Scan (0 บาท / 30 นาที)
└─ Meso Clarity Bright (Guest Pass only — friend benefit, value 2,500)

CORE BUNDLES — 5,000 บาท แต่ละชุด (1 session, multi-modality)
├─ หลุมสิว 5K — 5 หัตถการ (Subcision + MNRF + Pico + CO2 + Er:glass/YAG)
├─ งานผิว 5K — 4 หัตถการ (Pico + CO2 + DermaV + Er:glass) ⭐ 80% margin
├─ ยกกระชับ 5K — Doublo2 400 shots ⭐ 80% margin (Hironic advantage)
└─ Integration 5K — Polynucleotide + งานผิว combo

PREMIUM (single ticket / splittable)
├─ Rejuran — 10,000 (61% margin)
├─ Botox Korea 200u — 10,000 ✅ splittable
├─ Botox Xeomin 100u — 12,000 ✅ splittable
└─ Juvelook 8cc — 15,000 ✅ splittable

GUEST PASS REWARDS (เฉพาะ referrer — earn via referrals)
├─ 1 credit → Picolaser facial full face toning (reward-only, value 3,900)
├─ 2 credits → งานผิว 5K bundle ฟรี (value 6,900 market price)
└─ 3 credits → Doublo2 400 shots ฟรี (value 9,900 market price)
```

### Margin Reference (Quick)

| Product | Sell | Cost | Margin |
|---|---|---|---|
| หลุมสิว 5K | 5,000 | 2,000 | **60%** |
| งานผิว 5K | 5,000 | 1,000 | **80%** ⭐ |
| ยกกระชับ 5K | 5,000 | 1,000 | **80%** ⭐ |
| Integration 5K | 5,000 | 2,300 | 54% |
| Rejuran | 10,000 | 3,900 | 61% |
| Botox Korea 200u | 10,000 | 5,000-5,600 | 44-50% |
| Botox Xeomin 100u | 12,000 | 6,500 | 46% |
| Juvelook 8cc | 15,000 | 7,000 | 53% |

ดู [BUDGET.md](./BUDGET.md) สำหรับ analysis เต็ม

---

## Strategic Position

**Channel แยกจาก Optima Aesthetic 100%** (decision ADR-001)

| Dimension | Clarity (this repo) | Optima (separate) |
|---|---|---|
| Audience | B2C (คนไข้) | B2B (หมอ/คลินิก) |
| Channel | @clarityclinic | @optimaaesthetic |
| Doctor face | หมอ Big (warm/empathetic) | หมอ Big (Engineer-Doctor) |
| CTA | "ปรึกษาฟรี LINE" | "ขอ demo / ใบเสนอราคา" |

---

## 4 White Space ที่ Clarity ยึด

จาก market research (Bangkok acne scar landscape, 12 คู่แข่ง):

1. **ราคาบนเว็บทุก SKU + ไม่ขายคอร์ส** — ไม่มีคู่แข่งปักธงเป็น brand promise ชัดเจน
2. **5 เครื่อง 1 session 5,000** — multi-modality bundle ที่ราคาเดียว
3. **Guest Pass + Tier reward** — ตรงข้ามกับ subscription model
4. **Doublo2 advantage** — เป็น distributor ของ Hironic = cartridge cost ถูกที่สุด

---

## Owner & Cadence

| Role | Owner |
|---|---|
| Strategy direction | หมอ Big |
| Content production | Content creator 1 คน (part-time 15-20k/เดือน) |
| Approval | หมอ Big (final review ทุก clip) |
| Patient consent + Guest Pass verification | Clinic admin |
| Distribution + ads | Marketing |
| KPI review | รายเดือน |
| Strategy review | รายไตรมาส |

---

## How to Use This Repo

1. อ่าน `BRAND.md` ก่อน — ทำความเข้าใจ foundation
2. อ่าน `AUDIENCE.md` — รู้ว่าทำ content ให้ใคร
3. อ่าน `PILLARS.md` — เห็น 4 หมวด + clip outlines
4. อ่าน `CALENDAR.md` — รู้ schedule + clip ไหนวันไหน
5. อ่าน `BUDGET.md` — เข้าใจ margin + marketing allocation
6. อ่าน `playbook/` — operational guides
7. ดู `content/` folder — clip brief แต่ละตัว

---

## Forbidden in this Project

- ใช้คำว่า "หายขาด" / "การันตี" / "100%" / "อันดับ 1"
- "ราคาเริ่มต้นเพียง..." (ลวงราคา)
- Hard-sell คอร์สผูกมัด
- Subscription / Credit Pass model (ตัดออกแล้ว)
- Flash sale 50-80% deep discount
- Macro KOL ที่ overexposed (ใช้ nano/micro)
- Cross-promote กับ Optima แบบ explicit
- ผลิต content ที่ไม่ตรงกับ pillar ใดเลย

---

## Related Projects

- Optima Aesthetic Content Strategy — B2B medical device (separate repo: optima-mkt-content)

---

## Working Sheet (source of truth)

**[Clarity MKT Content](https://docs.google.com/spreadsheets/d/1LhB6RNAmKShNNDOSKau8UrTW1708iPxC57DTYxx5-r8/edit)**
— Google Sheet ที่ใช้ track/edit content calendar จริง

- **Sheet ID:** `1LhB6RNAmKShNNDOSKau8UrTW1708iPxC57DTYxx5-r8`
- **Owner:** thitikom1994@gmail.com
- **Tabs (12):** Calendar · Clip Library · Production Status · Scripts · Scenes · Personas · Pillars · Pricing · Hashtags · KPIs · Voice Rules · Decisions

> Sheet นี้คือ live source of truth — ไฟล์ `.md` และ `.xlsx` ใน repo เป็น snapshot/reference เท่านั้น เวลาแก้ content ให้แก้ใน Sheet ก่อน

---

## MCP: Google Sheets

This repo includes a `.mcp.json` that registers a **Google Sheets MCP server**
([`mcp-google-sheets`](https://github.com/xing5/mcp-google-sheets), run via `uvx`)
so Claude Code can read/write the content calendar directly in Google Sheets
instead of editing `clarity-content-calendar.xlsx`.

### Required setup (one-time)

1. **Google Cloud project** → enable **Google Sheets API** + **Google Drive API**.
2. **Create a service account** → download its JSON key.
3. **Share the target Sheet (or Drive folder)** with the service account's
   `client_email` (give Editor access).
4. **Provide credentials to Claude Code** via one of:
   - `SERVICE_ACCOUNT_PATH` → path to JSON file (default: `./.secrets/google-service-account.json`, gitignored), OR
   - `GOOGLE_SHEETS_CREDENTIALS_BASE64` → base64-encoded JSON (preferred for web sessions; set in environment settings).
5. **Optional:** set `GOOGLE_SHEETS_DRIVE_FOLDER_ID` to scope access to one folder.

### Local use

Drop the service-account JSON in `./.secrets/google-service-account.json`,
then `claude` from this directory — the server starts automatically.

### Claude Code on the web

Set `GOOGLE_SHEETS_CREDENTIALS_BASE64` (and optionally `GOOGLE_SHEETS_DRIVE_FOLDER_ID`)
in the environment's variable settings. The server is auto-launched when you
approve `.mcp.json` on first session start.
