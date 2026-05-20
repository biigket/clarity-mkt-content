# Decisions — Clarity Clinic

> Architecture Decision Records (ADR) — บันทึก decision ที่ shape brand + content strategy
> Format: ปัญหา → ทางเลือก → ตัดสิน → เหตุผล → consequence
> Status: `Accepted` / `Superseded` / `Deprecated` / `Pending`

---

## วิธีใช้ไฟล์นี้

1. **ทุกครั้งที่มี decision สำคัญ** (positioning, channel, pricing, format) → เพิ่ม ADR ใหม่
2. **ห้ามแก้ ADR เก่า** — ถ้าเปลี่ยนใจ ให้ mark `Superseded by ADR-XXX` แล้วเขียนใหม่
3. **อ้างใน doc อื่น** ด้วยเลข ADR (เช่น "ดู ADR-001") เพื่อ traceability
4. **Review รายไตรมาส** — pending decisions ต้องมี owner + deadline

---

## Index

| # | Decision | Status | Date |
|---|---|---|---|
| ADR-001 | แยก channel จาก Optima Aesthetic 100% | Accepted | 2026-05 |
| ADR-002 | Hero treatment = หลุมสิว (Acne Scar Program) | Accepted | 2026-05 |
| ADR-003 | ราคาบนเว็บทุก SKU + ไม่ขายคอร์สผูกมัด | Accepted | 2026-05 |
| ADR-004 | ใช้หมอ Big เป็น face เดียวข้าม 2 channel | Accepted | 2026-05 |
| ADR-005 | Cadence 5 clips/สัปดาห์ (มากกว่า Optima ที่ 4) | Accepted | 2026-05 |
| ADR-006 | Avatar/Real ratio = 30/70 overall | Accepted | 2026-05 |
| ADR-007 | ใช้ nano/micro KOL — ห้าม macro KOL | Accepted | 2026-05 |
| ADR-008 | Service architecture 3 ชั้น (Hero / Bread & Butter / Premium) | Accepted | 2026-05 |
| ADR-009 | Lunch Hour menu 30 นาที = bread & butter | Accepted | 2026-05 |
| ADR-010 | Sub-brand @clarityacnescar = Phase 2 (optional) | Pending | 2026-05 |

---

## ADR-001 — แยก channel จาก Optima Aesthetic 100%

**Status:** Accepted · 2026-05

**Context**
หมอ Big มี 2 ธุรกิจ: Clarity (B2C คลินิก) + Optima Aesthetic (B2B distributor เครื่องมือแพทย์). คำถามคือใช้ channel เดียวกัน (audience cross-over) หรือแยก?

**Options**
1. รวม channel เดียว — leverage audience, ประหยัด production
2. แยก 100% — focus per audience, ไม่สับสน
3. แยก แต่ explicit cross-promote บ่อย

**Decision**
แยก 100%. ไม่ explicit cross-promote — แค่ใช้ "หมอ Big" เป็น face ในทั้ง 2 channel เพื่อ recognition organic

| Dimension | Clarity | Optima |
|---|---|---|
| Audience | B2C (คนไข้) | B2B (หมอ/คลินิก) |
| Channel | @clarityclinic | @optimaaesthetic |
| Doctor face | หมอ Big — warm/empathetic | หมอ Big — Engineer-Doctor |
| CTA | "ปรึกษาฟรี LINE" | "ขอ demo / ใบเสนอราคา" |

**เหตุผล**
- คนไข้ B2C เห็น distributor content = สับสน + ลด trust ("คลินิกขายเครื่อง?")
- หมอเห็น patient story = ไม่ relevant กับ buying decision
- Algorithm TikTok feed ต้อง consistent topic เพื่อ optimize reach

**Consequence**
- ต้อง production แยก 2 ชุด — cost สูงขึ้น
- ใช้หมอ Big เป็น "shared asset" ที่ recognition cross-over โดยไม่ต้อง explicit
- Audience ที่อยากรู้ทั้ง 2 ด้านจะ find เอง — ok

---

## ADR-002 — Hero treatment = หลุมสิว (Acne Scar Program)

**Status:** Accepted · 2026-05

**Context**
Clarity ทำหลายบริการ (หลุมสิว, ฝ้า, ผิวกระจ่าง, ยกกระชับ). ต้องเลือก 1 หัวข้อเป็น hero hook เพื่อสร้าง category authority

**Options**
1. หลุมสิว — pain point ลึก, ราคาสูง, repeat customer
2. ฝ้า/กระแดด — audience กว้างกว่า แต่ commoditized
3. ยกกระชับ (HIFU/Ulthera) — margin สูงแต่ category แข่งดุมาก

**Decision**
หลุมสิว เป็น hero. ฝ้า/ผิวกระจ่าง = cross-sell. ยกกระชับ = upsell premium

**เหตุผล**
- Market research: 12 คู่แข่งในกรุงเทพไม่มีใครปักธง "ราคาบนเว็บ + ไม่ขายคอร์ส" สำหรับหลุมสิว
- หลุมสิว = high-intent + word-of-mouth strong (เพื่อนแนะนำกันเอง)
- หมอ Big มี Optima distributor — เครื่องมือ subcision / pico / RF microneedling ครบ
- Trica3D scan = brand-unique asset ที่แข่งยาก
- Cost-per-result transparency = white space ที่ยึดได้

**Consequence**
- Content 40% ของ pillar 1 ต้องเป็น patient story หลุมสิว
- Hero pricing บนเว็บต้องเปิดเผยทั้งหมด (ดู ADR-003)
- Persona A (office worker หลุมสิว) = primary target
- ฝ้า/ผิวกระจ่าง content ทำแต่ไม่ใช่ flagship

---

## ADR-003 — ราคาบนเว็บทุก SKU + ไม่ขายคอร์สผูกมัด

**Status:** Accepted · 2026-05

**Context**
อุตสาหกรรมคลินิกผิว Bangkok 95% ใช้ "ราคาเริ่มต้นเพียง..." + ขายคอร์สผูกมัด 10 ครั้งแสน. Clarity ต้องเลือก positioning

**Options**
1. ตามตลาด — ลวงราคา + คอร์สผูกมัด (revenue ก้อนใหญ่ครั้งเดียว)
2. ราคาบนเว็บแต่ยังขายคอร์ส — half-measure
3. ราคาบนเว็บทั้งหมด + จ่ายทีละครั้ง — full transparency

**Decision**
Option 3. เปิด price list ทุก SKU บนเว็บ + ไม่มีคอร์สผูกมัด (มีแค่ Acne Scar Pass 4 ครั้งและ Clarity Credit Pass แบบไม่บังคับ)

**เหตุผล**
- ตรงกับ North Star "ความสม่ำเสมอ" (คนไข้กลับมาเพราะ trust ไม่ใช่เพราะจ่ายล่วงหน้า)
- Pain point #1 ของ Persona A = กลัวโดน hard-sell
- Tamada Clinic ดังจาก angle นี้แล้ว แต่ยังไม่มีใครปักธงในย่านราชเทวี-สยาม
- 92% คนไทยเชื่อ "ไม่ขายเอง" มากกว่าโฆษณา

**Consequence**
- Revenue per visit ต่ำกว่า cost ขายคอร์ส แต่ LTV สูงกว่า (retention 1+ ปี)
- ต้อง content pillar 3 (Anti-marketing) maintain positioning ตลอดเวลา
- ห้ามทำ flash sale 50-80% — devalue brand (ดู Forbidden list ใน README)
- Admin ต้อง trained ห้าม hard-sell ในห้องตรวจ — หมอ Big คุยรักษา / admin จัดการราคา

---

## ADR-004 — ใช้หมอ Big เป็น face เดียวข้าม 2 channel

**Status:** Accepted · 2026-05 · Related: ADR-001

**Context**
ADR-001 แยก channel แล้ว แต่จะใช้ face คนเดียว (หมอ Big) หรือสร้าง persona แยกต่อ channel?

**Options**
1. หมอ Big ทั้ง 2 — recognition + ประหยัด
2. หมอ Big = Optima, persona อื่น = Clarity
3. หมอ Big + co-host แยก persona ต่อ channel

**Decision**
หมอ Big ทั้ง 2 channel แต่แสดงคนละ "ด้าน":
- **Clarity:** warm / empathetic / listening / "หมอที่คุย" (เสื้อยืดสี soft)
- **Optima:** Engineer-Doctor / technical / authority (เสื้อแล็บ formal)

**เหตุผล**
- หมอ Big = unique asset (founder + KOL + actual operator)
- Recognition cross-over โดยไม่ต้อง explicit cross-promote (ADR-001)
- Audience ทั้ง 2 trust "real person" มากกว่า persona ที่สร้างขึ้น
- Avatar version ออกแบบให้สะท้อนต่าง side ของหมอ Big เอง

**Consequence**
- หมอ Big = bottleneck (ต้อง record + approve ทุก clip)
- ถ้าหมอ Big absent นาน → content stall
- Avatar coverage 30% ของ content = mitigation ส่วนหนึ่ง
- ต้อง code-switch tone ระหว่าง Clarity vs Optima content อย่าง consistent

---

## ADR-005 — Cadence 5 clips/สัปดาห์

**Status:** Accepted · 2026-05

**Context**
Optima (B2B) ใช้ 4 clips/สัปดาห์. Clarity ควรใช้เท่าไหร่?

**Options**
1. 3/สัปดาห์ — ประหยัด production, deep per clip
2. 4/สัปดาห์ — เท่า Optima
3. 5/สัปดาห์ — frequency สูงสำหรับ B2C
4. Daily (7) — เกินกำลัง 1 creator

**Decision**
5 clips/สัปดาห์ (จันทร์-อังคาร-พุธ-พฤหัส-อาทิตย์)

**เหตุผล**
- B2C audience consume content เยอะกว่า B2B → ต้อง stay top-of-mind
- Patient story content มี supply เยอะ (ผ่าน clinic เดือนละหลายร้อยเคส)
- TikTok/IG algorithm reward weekly consistency
- 5 = sustainable สำหรับ creator 1 คน part-time (15-20k/เดือน)

**Consequence**
- Production ต้อง batch shoot ทุก 2 สัปดาห์ (10 clips/batch)
- ห้ามโพสต์วันศุกร์/เสาร์ — preserve creator weekend + algorithm สังเกตว่าเสาร์ engagement ต่ำ
- ต้องมี backlog 4 อาทิตย์ buffer — กันเดือนที่หมอ Big ติดงาน

---

## ADR-006 — Avatar/Real ratio = 30/70 overall

**Status:** Accepted · 2026-05

**Context**
Avatar (illustrated 2D หมอ Big) ผลิตเร็วและถูกกว่า real video. แต่ B2C ต้องการ trust ของ "หมอจริง". หาส่วนผสมที่ลงตัว

**Options**
1. 100% Real — สูงสุด trust แต่ production แพง + ช้า
2. 50/50 — balance แต่ Avatar เด่นเกินใน B2C
3. 30/70 (Avatar/Real) — Real นำ trust, Avatar เสริม volume

**Decision**
30/70 overall (Avatar/Real). แตกย่อยตาม pillar:
- Pillar 1 (Patient Story) → 0/100 (ห้าม avatar)
- Pillar 2 (Education) → 60/40
- Pillar 3 (Anti-marketing) → 70/30
- Pillar 4 (Treatment) → 0/100

**เหตุผล**
- Patient story เป็น avatar = สูญเสีย proof value ทั้งหมด (real คือ point)
- Education + opinion content avatar ได้ — ไม่ต้องเห็นหน้าหมอตลอด
- Real content ต้องเก็บไว้ตอน "หมอ Big appear" ให้ premium feel
- Production cost: avatar ~30% ของ real video

**Consequence**
- Avatar style ต้อง consistent (ดู `assets/avatar/avatar-brief.md`)
- Real video ต้อง batch shoot เพื่อ amortize setup cost
- ห้ามใช้ avatar กับ medical claim ที่ต้อง verify (จะดู corporate เกินไป + ลด trust)

---

## ADR-007 — ใช้ nano/micro KOL เท่านั้น

**Status:** Accepted · 2026-05

**Context**
Influencer strategy: macro (1M+), micro (10k-100k), nano (<10k)?

**Options**
1. Macro KOL — reach กว้าง แต่ trust ต่ำใน medical niche
2. Micro KOL — sweet spot reach + trust
3. Nano KOL (patient จริง + small creator) — trust สูงสุด, reach จำกัด

**Decision**
**Nano + Micro เท่านั้น** — ห้ามใช้ macro KOL ที่ overexposed

**เหตุผล**
- Medical niche: 60% คนไทยตัดสินใจซื้อจาก review ลูกค้าจริง, ไม่ใช่ KOL ใหญ่
- Macro KOL รับงานเยอะ → audience รู้ว่าจ่ายเงิน → trust ต่ำ
- Nano = ลูกค้าจริงที่มีปัญหาเดียวกับ audience → relatability สูงสุด
- Cost effective: 10 nano KOL @ 5k = 50k ได้ content 10 ชิ้น + reach รวม > 1 macro 200k

**Consequence**
- ต้อง vet nano KOL หนัก (ผิวจริงต้อง match condition + แสดงผลได้)
- Patient consent + medical disclaimer ต้องเข้มกว่าปกติ
- Tracking ROI ยากขึ้น (multiple touchpoints)
- ไม่ทำ campaign แบบ celebrity endorsement

---

## ADR-008 — Service architecture 3 ชั้น

**Status:** Accepted · 2026-05

**Context**
ต้องการ pricing architecture ที่ serve เป้าหมายทั้ง acquisition + retention + margin

**Decision**
3 ชั้น:

```
HERO (specialist hook + acquisition)
  └─ Acne Scar Program — 24,900-39,900 (4 sessions)

BREAD & BUTTER (mass volume, repeat traffic)
  └─ Lunch Hour menu 30 นาที — 990-1,990

UPSELL PREMIUM (high margin, existing trust)
  └─ Ulthera / HIFU / Thermage — 15,000-50,000
```

**เหตุผล**
- Hero ดึงคนเข้าใน category authority
- Bread & Butter ทำให้คนกลับมาบ่อย (ความสม่ำเสมอ — ตรง North Star)
- Premium upsell หลังจาก trust สร้างแล้ว — ไม่ใช่ entry point
- Lunch Hour @ 990 = entry price ต่ำที่ Persona B (student/first jobber) เข้าถึงได้

**Consequence**
- Marketing แต่ละชั้นต้องแยกชัด — ห้ามให้ Hero content ขาย Premium
- KPI per ชั้นต่างกัน (Hero = LTV, B&B = frequency, Premium = ASP)
- Staff training: รู้ว่าใครอยู่ชั้นไหน + ไม่ jump เกิน

---

## ADR-009 — Lunch Hour menu 30 นาที = bread & butter

**Status:** Accepted · 2026-05 · Related: ADR-008

**Context**
ต้องการ entry product ที่ Persona A (office worker) ใช้ได้บ่อย + ไม่กระทบเวลางาน

**Decision**
สร้าง 5 menu × 30 นาที × 990-1,990 บาท:
- Clean Lunch / Glow Lunch / Calm Lunch / Smooth Lunch / Tight Lunch

**เหตุผล**
- Pain point Persona A: "ลางานไม่ได้บ่อย" + "พักเที่ยงทำได้ไหม"
- ราชเทวี/พญาไท/สยาม = office hub — เดิน 10-15 นาทีจากตึก
- Market gap: ไม่มีคลินิกในย่านนี้ปักธง "lunch hour" เป็น brand promise
- Frequency play: คนทำ lunch hour เดือนละครั้ง = 12 visits/ปี = retention 4x ของ Hero

**Consequence**
- Booking slot 11:30-13:30 ต้อง reserve สำหรับ Lunch Hour เท่านั้น
- Service ต้อง guarantee เสร็จใน 30 นาที (no downtime, no redness)
- Marketing copy ต้องบอกเวลาให้ชัด: "พักเที่ยง 30 นาที กลับทำงานต่อ"
- Staff training: queue management + speed without rush feel

---

## ADR-010 — Sub-brand @clarityacnescar = Phase 2

**Status:** Pending · Owner: หมอ Big · Deadline: 2026-08 (Month 3 review)

**Context**
DSK Clinic ใช้ @dsk.acnescar เป็น sub-brand แยก สำเร็จในการ funnel ลูกค้า "หลุมสิว". Clarity ควรเปิด @clarityacnescar เมื่อไหร่?

**Options**
1. Month 1 พร้อม main channel — focus หลุมสิวเร็ว
2. Month 3+ หลัง main แข็งแรง — leverage existing audience
3. ไม่เปิดเลย — เก็บใน main channel

**Decision**
**Pending** — review Month 3 (สิงหาคม 2026) เมื่อ main channel มี:
- [ ] 5k+ followers
- [ ] 3+ patient story clips ที่ go viral (50k+ views)
- [ ] Production bandwidth พอแยก 2 channel

**Tentative direction:** Option 2 (Month 3+)

**เหตุผล (สนับสนุน Option 2)**
- Month 1-2 ต้อง concentrate effort สร้าง main channel
- Sub-brand ต้อง content แยก = double creator load
- Risk: main channel ยังไม่แข็ง = sub-brand ดู orphan

**เหตุผล (อาจกลับมา Option 1 ถ้า)**
- Patient supply หลุมสิวมากกว่า 8 เคส/เดือน
- มี creator คนที่ 2 ที่ specialize หลุมสิว
- Competitor ใหม่เข้าตลาดเดียวกัน → ต้อง defend category fast

---

## Pending Decisions (รอตัดสิน)

| # | Decision | Owner | Deadline | Notes |
|---|---|---|---|---|
| P-01 | Posting database: Notion vs Airtable vs Metricool | Marketing | 2026-06 W2 | ดู schema ใน CALENDAR.md |
| P-02 | Content creator: in-house vs freelance vs agency | หมอ Big | 2026-06 W1 | งบ 15-20k/เดือน part-time |
| P-04 | Inner Circle 100 — benefit structure | หมอ Big | 2026-06 W4 | Launch Month 1 W4 |
| P-05 | B2B HR pilot — เลือก 5 ตึกไหน | Marketing | 2026-07 W1 | CP Tower confirmed เป็นตึกแรก |
| P-06 | Newsletter platform (LINE OA enough หรือต้องเสริม email) | Marketing | 2026-06 W3 | |
| P-07 | YouTube long-form — เริ่ม Month เท่าไหร่ | หมอ Big | 2026-08 | ใช้ repurpose จาก TikTok ก่อน |
| P-08 | Patient meetup format (Month 4) | หมอ Big + Admin | 2026-07 | Online vs offline vs hybrid |
| P-09 | Crisis playbook — ใครเป็น first responder นอกเวลางาน | Admin lead | 2026-06 W2 | ดู CALENDAR.md Crisis Response |
| P-10 | สบส. compliance review — ใครเป็น final approver | หมอ Big | 2026-06 W1 | กฎหมาย disclaimer "ผลลัพธ์เฉพาะบุคคล" |

---

## Cross-Reference

- Brand foundation ที่ shape โดย decisions เหล่านี้ → `BRAND.md`
- Audience ที่ targeting จาก decisions → `AUDIENCE.md`
- Pillars ที่ implement decisions → `PILLARS.md`
- Calendar ที่ execute decisions → `CALENDAR.md`
