# Guest Pass System — Full SOP

> Operational manual สำหรับ Guest Pass referral program
> ใช้สำหรับ: admin, marketing, content creator
> Owner: หมอ Big

---

## Overview

**Guest Pass Referral** = mechanic ที่แทน subscription model
- ทุกลูกค้าได้ 3 Guest Pass หลังทำ treatment
- ส่งให้เพื่อน → เพื่อนได้ Meso Clarity Bright ฟรี
- เพื่อนทำ treatment เสร็จ → ลูกค้าได้ +1 credit
- สะสม credit → แลกรางวัล (tier 1/2/3)

---

## Customer-Facing Rules

### Guest Pass

| Parameter | Value |
|---|---|
| จำนวน Pass ต่อลูกค้า | 3 ใบ (non-member) / 3 ใบ (member, ต่ออายุเมื่อใช้หมด) |
| Pass expiry | 3 เดือน (non-member) / 6 เดือน (member) |
| Eligibility ของผู้รับ | ลูกค้าใหม่เท่านั้น (verify ด้วยเบอร์โทร + LINE ID) |
| Pass หนึ่งใบ = | 1 เพื่อน รับ Meso Clarity Bright ฟรี (value 2,500) |
| Pass transferable | ไม่ — ส่งให้เพื่อนได้ครั้งเดียว |

### Credit System

| Parameter | Value |
|---|---|
| Trigger ที่ได้ credit | เพื่อนทำ treatment เสร็จ (ไม่ใช่แค่จอง) |
| Credit per successful referral | 1 credit |
| Member bonus | ทุก 3 referrals → +1 bonus credit |
| Credit expiry | 6 เดือน (non-member) / 12 เดือน (member) |
| Credit transferable | ไม่ — ใช้ส่วนตัวเท่านั้น |

### Tier Redemption

| Credits | Reward | Treatment Detail | Market Value |
|---|---|---|---|
| 1 | Picolaser facial 1 ครั้ง | Full face toning (~30 นาที) — **reward-only SKU** | 3,900 |
| 2 | งานผิว 5K bundle ฟรี | Pico + CO2 + DermaV + Er:glass (1 session) | 6,900 |
| 3 | ยกกระชับ Doublo2 ฟรี | 400 shots (~30-45 นาที) | 9,900 |

**Rules:**
- ลูกค้าเลือกแลกระดับใดก็ได้ (ไม่บังคับเก็บถึง 3)
- 1 credit ใช้ไปแล้ว = ไม่ได้คืน (เริ่มสะสมใหม่)
- Reward voucher booking ผ่าน LINE OA — slot priority สำหรับ member

---

## Sharing Mechanism

### Format 1: LINE Share (primary)

ลูกค้าเปิด LINE @clarityclinic → menu "Guest Pass ของฉัน":
- เห็น 3 ใบ พร้อม timer countdown
- กดปุ่ม "ส่งใน LINE" → เปิด share sheet → เลือกเพื่อน
- ระบบ generate unique URL per pass:
  ```
  https://clarityclinic.co/g/[unique-token]
  ```

### Format 2: QR Code

- ลูกค้าเปิด LINE OA → กด "QR Code" → show QR ในมือถือ
- เพื่อนใช้กล้องสแกน → เปิด landing page เดียวกัน
- ใช้กรณีเจอเพื่อนตัวต่อตัว

### Format 3: Copy Link

- ปุ่ม "Copy Link" → paste ที่ไหนก็ได้ (SMS, IG DM, etc.)

### Landing Page Content

```
[Hero] รูปสวย + headline:
"คุณ [Referrer Name] ส่ง Guest Pass ให้คุณ"

[Offer]
"Meso Clarity Bright ฟรี — ผิวกระจ่างทันที"
มูลค่า 2,500 บาท

[CTA]
"รับของขวัญ" → trigger LINE add friend @clarityclinic
หรือ "จองเลย" → booking form
```

---

## Friend Registration & Verification

### Step 1: Friend opens link/QR
- Landing page loads
- Show referrer name + offer
- CTA: "รับของขวัญ"

### Step 2: LINE OA add
- เพื่อนกด CTA → auto-prompt add @clarityclinic
- LINE userID auto-bind ตอน add friend
- ระบบเก็บ LINE userID ใน database

### Step 3: Phone OTP
- ระบบขอเบอร์โทร
- ส่ง OTP 6 หลัก SMS (Twilio/THSMS)
- เพื่อนใส่ OTP ยืนยัน

### Step 4: Auto-validation

ระบบ check (instant):
```
✓ Pass code valid + UNUSED + not expired
✓ Phone number NOT in customer database (= new customer)
✓ LINE userID NOT in customer database
✓ Referrer account active
```

**ถ้าผ่านทั้ง 4 ข้อ:** → "Welcome — จองเวลาเลย"
**ถ้าไม่ผ่านข้อใด:**
- Pass used → "Pass นี้ใช้แล้ว"
- Pass expired → "Pass หมดอายุแล้ว — ขอเพื่อนใหม่"
- Customer existed → "เบอร์/LINE นี้เคยใช้บริการแล้ว"

### Step 5: Booking
- เลือก slot (Meso Clarity Bright 30 นาที)
- Confirm appointment
- Auto reminder LINE OA: T-24h, T-2h

---

## Verification at Clinic (Counter)

### Pre-arrival Check
Admin ดู booking list ของวัน:
- Identify Guest Pass bookings (flagged)
- Note: referrer name, Pass code, expected friend

### Counter Check-in Script

**Admin (กล่าวต้อนรับ):**
> "สวัสดีค่ะ คุณ [ชื่อ] ใช่ไหมคะ?
> ขอ scan QR ที่ booking ของคุณใน LINE @clarityclinic ค่ะ"

### Verification Process

1. **Scan QR** (iPad / มือถือ)
2. **ระบบ load:**
   - Customer name
   - Phone (visible last 4 digits)
   - Pass code
   - Referrer name
3. **Visual check:**
   - LINE profile photo vs face (soft check)
   - ถ้าผิดเห็นชัด (เพศ/อายุ ไม่ตรง) → ขอ ID card
4. **Confirm:**
   - "ใช่คุณ [ชื่อ] ใช่ไหมคะ?"
   - "เพื่อนของคุณคือ [referrer name] ใช่ไหมคะ?"

### Edge Cases at Counter

| Situation | Action |
|---|---|
| Face ไม่ match LINE photo | ขอ ID card → verify name |
| ลืม LINE OA login | ขอเบอร์โทร → admin look up booking |
| Pass code ใช้ไปแล้ว | "Pass ใช้แล้ว — ขออภัย ขอเพื่อนใหม่" |
| เพื่อนเคยเป็นลูกค้า | "เบอร์นี้เคยเป็นลูกค้า — Guest Pass ใช้ได้กับลูกค้าใหม่เท่านั้น" |
| ลูกค้ามาช้ามาก (>30 min) | Admin discretion — โทร confirm หรือ reschedule |

---

## Treatment Workflow

### Meso Clarity Bright (30 นาที)

**Standard SOP:**
1. **Welcome** (2 นาที) — Admin walk to consult room
2. **Consult + Trica3D scan** (8 นาที) — หมอ Big เข้ามา (สำคัญ — สร้าง trust)
   - หมอ ทักทาย จำชื่อจาก booking
   - ฟัง pain point 5 นาที
   - Scan Trica3D + show แผนผังผิว
   - ชี้ 2-3 จุดที่เห็น + แนวทาง (ไม่ขายคอร์ส — แค่ educate)
3. **Meso treatment** (15 นาที) — พยาบาล/aesthetician
   - Topical anesthetic 5 นาที (optional)
   - Vitamin cocktail injection (10 นาที)
4. **Care + handoff** (5 นาที)
   - Care kit (3 sample + plan card)
   - หมอ Big handwritten note (เพิ่ม personal touch)
   - "ดีใจที่ได้รู้จัก [ชื่อ]..."

### Post-treatment Mark

Admin (ที่ counter):
1. Mark "Treatment completed" in system
2. Trigger auto-notification ไปที่ referrer
3. Schedule LINE OA follow-up sequence (Day 3, 10, 21)

---

## Referrer Reward Notification

### Auto-message Template

```
🎉 ของขวัญถึงคุณแล้ว!

เพื่อนของคุณ [Friend name] มาทำ Meso Clarity Bright วันนี้
คุณได้ +1 Credit

สถานะ Credit: 1 / 3

สะสมเพิ่มเลือกรางวัล:
1 → Picolaser facial (มูลค่า 3,900)
2 → งานผิว 5K (มูลค่า 6,900)  
3 → ยกกระชับ Doublo2 (มูลค่า 9,900)

[Use 1 Credit Now]  [Save Credits]
```

---

## Reward Redemption Workflow

### Customer initiates redemption

ใน LINE OA → menu "My Credits" → เลือกระดับที่จะแลก

### System auto-issue voucher

```
🎁 ของขวัญพร้อมใช้!

Picolaser facial 1 ครั้ง
Voucher: PICO-FREE-[customer-id]-001
Expiry: 6 เดือน (non-member) / 12 เดือน (member)

[จองเลย]
```

### Booking voucher session

- Auto-deduct credit
- Show available slots
- Confirm appointment

### At clinic

- Admin scan voucher code at check-in
- Verify validity
- Conduct treatment (Picolaser/งานผิว/ยกกระชับ)
- Mark voucher = USED

---

## Database Schema (Airtable / Notion DB)

### Table: Customers
```
- customer_id (PK)
- name
- phone_number (unique, indexed)
- line_user_id (unique, indexed)
- email
- first_visit_date
- total_spending (auto-calc)
- is_member (auto: total_spending >= 5000)
- status (active/inactive)
- notes
```

### Table: GuestPasses
```
- pass_id (PK)
- pass_code (unique URL token)
- owner_customer_id (FK → Customers)
- issued_date
- expiry_date
- status (UNUSED/RESERVED/USED/EXPIRED)
- shared_method (LINE/QR/copy-link/null)
- shared_to_phone (when friend uses)
- friend_booking_date
- friend_treatment_date
- friend_customer_id (FK → Customers, when friend becomes customer)
```

### Table: Credits
```
- credit_id (PK)
- owner_customer_id (FK → Customers)
- source_pass_id (FK → GuestPasses)
- earned_date
- expiry_date
- status (ACTIVE/USED/EXPIRED)
- used_for_redemption_id (FK → Redemptions, nullable)
- is_bonus (boolean — member 3+1 bonus)
```

### Table: Redemptions
```
- redemption_id (PK)
- customer_id (FK → Customers)
- credits_used (1/2/3)
- redemption_tier (Picolaser/งานผิว/ยกกระชับ)
- voucher_code
- redemption_date
- treatment_scheduled_date
- treatment_completed_date (nullable)
- status (REQUESTED/SCHEDULED/COMPLETED/EXPIRED/CANCELED)
```

### Table: Treatments (all)
```
- treatment_id (PK)
- customer_id (FK → Customers)
- treatment_date
- service_type (5K bundles, premium, Meso Guest, voucher redemption, etc.)
- amount_paid (0 if free)
- is_referral_visit (boolean)
- source_pass_id (FK → GuestPasses if first visit via Pass)
- source_voucher_id (FK → Redemptions if voucher redemption)
- variable_cost
- doctor_id
- notes
```

---

## Automation Flow (LINE OA + Make.com)

```
TRIGGER: Customer completes paying treatment
   ↓ (webhook)
   - Issue 3 Guest Passes
   - Send LINE OA message with pass details
   - Insert into GuestPasses table

────────────────────────────────────────

TRIGGER: Friend uses Guest Pass URL
   ↓ (landing page tracking)
   - Mark pass status: RESERVED
   - Track shared_method + IP
   - Begin verification flow

────────────────────────────────────────

TRIGGER: Friend completes phone OTP + LINE bind
   ↓
   - Create new Customer record
   - Link to original Pass
   - Send booking link

────────────────────────────────────────

TRIGGER: Friend completes treatment
   ↓ (admin marks "treatment completed")
   - Mark pass status: USED
   - Create Credit record for referrer
   - Send LINE OA notification to referrer
   - Update referrer's total_spending if applicable

────────────────────────────────────────

TRIGGER: Customer requests voucher redemption
   ↓
   - Deduct credits
   - Create Redemption record
   - Generate voucher code
   - Send LINE OA with booking link

────────────────────────────────────────

TRIGGER: Credit/Pass approaching expiry (30/15/7 days)
   ↓
   - Reminder LINE OA message
   - "Pass จะหมดอายุใน X วัน"
```

---

## KPIs to Track

| Metric | Target Month 1 | Target Month 3 |
|---|---|---|
| Guest Passes issued | 100 | 300+ |
| Pass redemption rate | >20% | >30% |
| Friend → paying customer conversion | >30% | >40% |
| Credits earned | 30 | 100+ |
| Credit redemption rate | >50% (within 6 mo) | >70% |
| Member upgrade rate | 40% | 60% |
| Average bundle purchase per new customer | 1.2 | 1.8 |
| Net revenue from referral cohort | 50k | 200k+ |
| Cost per Guest Pass cycle | <3,000 | <2,500 |

---

## Edge Cases & Solutions

| Case | Solution |
|---|---|
| เพื่อนจอง แล้วยกเลิก | Pass status → "AVAILABLE" — ลูกค้าใช้ใหม่ได้ |
| เพื่อนมาแล้วไม่ทำ treatment | Pass status → "USED" (จากการมา) แต่ no credit ให้ referrer |
| คนเดียวเข้ามาผ่าน 2 passes ที่ต่างกัน | ระบบ block ตอน register — phone duplicate |
| ลูกค้าเก่ายืม Pass เพื่อนใหม่ | Verification ปฏิเสธ — เคยมา = block |
| Voucher หมดอายุยังไม่ใช้ | Auto reminder 30/15/7 days — หมดแล้วใช้ไม่ได้ |
| Voucher แลกแล้วยกเลิก | Credit คืน (1 ครั้งต่อ voucher) |
| คน abuse system (สมมติชื่อ/เบอร์ปลอม) | Admin manual review weekly |

---

## Marketing Touchpoints

### Touchpoint 1: หลัง Treatment (Counter)
Admin บอก: "วันนี้คุณได้ Guest Pass 3 ใบ ส่งให้เพื่อนได้ — เพื่อนได้ Meso ฟรี คุณได้สะสม credit"

### Touchpoint 2: LINE OA Welcome (T+1 hour)
Auto-message พร้อม Pass codes + how-to-share

### Touchpoint 3: Pass Reminder (T+30, T+60 days)
"Guest Pass ใกล้หมดอายุ — ส่งให้เพื่อน"

### Touchpoint 4: Credit Reminder (T+30, T+90 days)
"Credit สะสมไว้ใช้ — ดูใน LINE OA"

### Touchpoint 5: TikTok/IG Content (Pillar 3 + 4)
Clip explainer (3-5 clips/quarter)

### Touchpoint 6: In-clinic Signage
Poster ใน waiting area + check-in counter

---

## Common Questions (FAQ for Admin)

**Q: ถ้าเพื่อนใช้ Pass แต่เปลี่ยนใจไม่ทำ treatment ได้ไหม?**
A: ได้ — Pass จะเปิดให้ใช้ใหม่ (re-usable until "treatment completed")

**Q: Credit ใช้รวมกันได้ไหม ระหว่างคู่สามี-ภรรยา?**
A: ไม่ได้ — ใช้คนละบัญชี

**Q: รางวัลที่แลกแล้ว — เปลี่ยนใจได้ไหม?**
A: ก่อน booking ได้ — หลัง booking ต้องโทร admin

**Q: เพื่อนมาทำแล้วผลไม่พอใจ — referrer ยังได้ credit ไหม?**
A: ได้ — credit ผูกกับ "treatment completed" ไม่ใช่ "satisfaction"

**Q: Guest Pass ใช้ได้กับ family member ไหม?**
A: ใช้ได้ ถ้าเป็นเบอร์/LINE คนละบัญชี + ไม่เคยมา Clarity

---

## Cross-Reference

- Member tier details → `member-tier-benefits.md`
- Admin verification scripts → `../ops/admin-verification-script.md`
- Per-product details → `product-positioning.md`
- Budget impact → `../BUDGET.md`
