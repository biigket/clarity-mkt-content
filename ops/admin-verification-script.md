# Admin Verification Script

> บทพูดและ workflow ที่ admin ใช้ตอน check-in
> Last updated: May 2026

---

## Daily Pre-shift Check (9:00 AM)

ก่อนเปิดให้บริการ admin ทำ:

1. **เปิด Booking Dashboard** (Airtable / system)
2. **Scan วันนี้:**
   - กี่ booking ทั้งหมด?
   - กี่ Guest Pass redemption?
   - กี่ Reward voucher redemption?
   - มี VIP/Member booking ไหม?
3. **Pre-load info** สำหรับแต่ละ booking:
   - Customer name
   - Treatment type
   - Special notes (allergy, history, etc.)
4. **Notify หมอ Big** ถ้ามี:
   - First-time Member upgrade วันนี้
   - Reward redemption tier 3 (Doublo2)
   - Patient story candidate (filming consent)

---

## Counter Check-in Scripts

### Case 1: Regular Walk-in (ลูกค้าใหม่ มาเอง)

**Admin:**
> "สวัสดีค่ะ คุณมาทำอะไรวันนี้คะ?"

**Listen, then:**
> "เนื่องจากเป็นครั้งแรกที่ Clarity — ขออนุญาตให้คุณกรอกข้อมูลก่อนนะคะ
> และเรามี Free Consult + Trica3D scan ฟรี 30 นาที
> ให้หมอ Big ดูผิวก่อนตัดสินใจ"

**ถ้าลูกค้ารู้แน่นอนว่าจะทำ bundle ไหน:**
> "เข้าใจค่ะ — งั้นเรา consult สั้นๆ ก่อนทำ พอได้ไหมคะ?
> เป็น standard ของเรา — เพื่อให้ผลที่ดีที่สุดสำหรับคุณ"

### Case 2: Returning Customer (มาทำซ้ำ)

**Admin (ดูระบบ):**
> "สวัสดีค่ะ คุณ [ชื่อ] — ครั้งที่แล้วทำ [treatment] เป็นยังไงบ้างคะ?"

**Listen:**
> "วันนี้ทำ [booked treatment] นะคะ
> หมอ Big จะ scan Trica3D ดูเปรียบกับครั้งก่อนค่ะ"

### Case 3: Guest Pass Redemption (เพื่อนใช้ Pass มา)

**Admin (preparation — ดูจาก booking ในระบบ):**
- เห็น flag: "Guest Pass redemption"
- ดู: Referrer name, Pass code, Friend name

**Greeting:**
> "สวัสดีค่ะ คุณ [Friend name] ใช่ไหมคะ?
> ขอ scan QR ใน LINE @clarityclinic ของคุณค่ะ"

**Scan QR:**

System verifies → ถ้าผ่าน:
> "ผ่านค่ะ — คุณเป็นเพื่อนของคุณ [Referrer] ที่ส่ง Guest Pass มา
> วันนี้ได้ Meso Clarity Bright ฟรี — มูลค่า 2,500 บาท
> ขอ welcome อย่างเป็นทางการนะคะ"

**ถ้าไม่ผ่าน:** ดู Edge Cases ด้านล่าง

### Case 4: Reward Voucher Redemption (ใช้ Credit แลก)

**Admin:**
> "สวัสดีค่ะ คุณ [ชื่อ] — วันนี้มาใช้ voucher
> [Tier 1 Picolaser / Tier 2 งานผิว / Tier 3 Doublo2] ใช่ไหมคะ?"

**Scan voucher code:**

System verifies → ถ้าผ่าน:
> "Voucher ผ่านค่ะ — ขออภัยที่ใช้เวลานิดนึง
> เพราะ voucher นี้สำคัญ — ของขวัญจากการแนะนำเพื่อนของคุณ"

### Case 5: Member ที่มา treatment

**Admin (ดูระบบ — เห็น Member icon):**
> "สวัสดีค่ะ คุณ [ชื่อ] — Clarity Member ของเรา
> วันนี้ทำ [treatment] นะคะ
> มี priority booking — ห้องพร้อมแล้ว ขอเชิญเข้าได้เลยค่ะ"

**ถ้ามี perks ที่ใช้ได้:**
> "ขออนุญาตเช็คนะคะ — Birthday gift / Annual Trica3D ของคุณยังไม่ได้ใช้
> สนใจ schedule วันถัดไปไหมคะ?"

---

## Verification Process (Step-by-Step)

### For Guest Pass Bookings

```
Step 1: ขอ QR/booking code
   ↓
Step 2: Scan ที่ iPad/มือถือ
   ↓
Step 3: System loads booking detail:
   - Customer name (friend)
   - Phone (last 4 digits visible)
   - Pass code
   - Referrer name
   - Treatment type (Meso Clarity Bright)
   ↓
Step 4: Visual verification
   - ดู LINE profile photo vs face
   - ถ้าตรง → ✓
   - ถ้าไม่ตรง → ขอ ID card
   ↓
Step 5: Confirm verbally
   - "ใช่คุณ [name] ใช่ไหมคะ?"
   - "เพื่อนของคุณคือคุณ [Referrer] ใช่ไหมคะ?"
   ↓
Step 6: Approve → ดำเนิน treatment
```

### For Voucher Redemption

```
Step 1: ขอ voucher code (ใน LINE OA)
   ↓
Step 2: Scan/พิมพ์ลงระบบ
   ↓
Step 3: System verify:
   - Voucher valid + not used + not expired
   - Booked treatment matches voucher tier
   ↓
Step 4: Confirm
   - "Voucher tier [X] ค่ะ — มูลค่า [Y]"
   - "ใช่ใช่ทำวันนี้ใช่ไหมคะ?"
   ↓
Step 5: Mark "in progress" → ดำเนิน treatment
```

---

## Edge Cases Handling

### EC1: Face ไม่ match LINE photo
**Admin:**
> "ขออภัยค่ะ — ขออนุญาตดู ID card / บัตรประชาชนเพื่อยืนยันตัวตนนะคะ"

(ระบบนี้ป้องกัน abuse — บอกเหตุผลให้ลูกค้าเข้าใจ)

### EC2: ลืม login LINE OA
**Admin:**
> "ไม่เป็นไรค่ะ — ขอเบอร์โทรนิดนึง จะ look up ให้ค่ะ"

Manual search ในระบบโดยใช้ phone

### EC3: Pass code ใช้แล้ว
**Admin:**
> "ขออภัยค่ะ — Pass นี้ใช้ไปแล้ว
> เป็นไปได้ว่าใช้กับเพื่อนอีกคน
> ถ้าต้องการ Meso Clarity Bright วันนี้
> เรามี promotion สำหรับลูกค้าใหม่ที่ — [offer]
> หรือ start ที่ 5K bundle ก็ได้ค่ะ"

### EC4: เพื่อนเคยเป็นลูกค้า (phone exists in DB)
**Admin:**
> "ขอตรวจสอบนิดนึงนะคะ — เบอร์นี้เคยมาที่ Clarity แล้วใช่ไหมคะ?"

**ถ้าลูกค้าสับสน/ไม่จำ:**
> "พอจะจำได้ไหมว่ามาเมื่อไหร่ ทำอะไร?
> Guest Pass ใช้ได้กับลูกค้าใหม่เท่านั้น — แต่ถ้าคุณเคยมาแล้ว
> เรามี Member benefit ให้ดู — น่าสนใจกว่า Guest Pass ด้วยซ้ำค่ะ"

### EC5: Voucher หมดอายุ (เพิ่งพบตอนมาถึง)
**Admin:**
> "ขออภัยค่ะ — voucher นี้หมดอายุไปเมื่อ [date]
> ขออนุญาต offer วันนี้: [discount หรือ alternative]
> หรือถ้าต้องการแนะนำเพื่อนเพิ่ม — ระบบจะออก credit ใหม่ให้ค่ะ"

**Admin notify หมอ Big** ถ้าเป็นกรณี borderline (หมดเมื่อวานนี้ฯลฯ) — discretion อาจ approve ได้

### EC6: ลูกค้ามาช้า (>30 นาที)
**Admin:**
> "ขออภัยค่ะ — คิวถัดไปเริ่มในอีก [X] นาที
> ถ้ารอได้ จะให้เริ่มหลังคิวนี้ค่ะ
> หรือ reschedule วันอื่นได้นะคะ?"

### EC7: ลูกค้าโกรธ/ดราม่า
**Admin (สงบ + professional):**
> "ขออภัยที่ทำให้คุณรู้สึกแบบนั้นค่ะ — ขออนุญาต listen ก่อนนะคะ"

หลังฟังจบ:
> "เข้าใจค่ะ — ขออนุญาตปรึกษากับ supervisor / หมอ Big สักครู่
> ขอเวลา 5 นาทีนะคะ"

**ห้าม:**
- โต้แย้งทันที
- ป้องกันตัวเอง
- ลด/หักล้างอารมณ์ลูกค้า

**ต้อง:**
- Listen เต็มที่
- Acknowledge feeling
- Take to private space
- Escalate ตามจำเป็น

### EC8: Senior member สงสัย benefit
**Admin:**
> "ค่ะ — สิทธิ์ของคุณตอนนี้คือ [list]
> ขอเปิด LINE OA → 'My Membership' ให้ดูค่ะ"

---

## Post-treatment Mark (สำคัญ)

หลังลูกค้าทำเสร็จ + จ่ายเงิน:

### Standard Treatment
```
1. Mark "Treatment completed" ในระบบ
2. Confirm next appointment ถ้ามี
3. ให้ Care kit + Plan card
4. Thank you message
```

### Guest Pass Treatment (เพื่อนมา)
```
1. Mark "Treatment completed" + "Pass redeemed"
2. ระบบ auto-trigger:
   - Notification ไป Referrer (LINE OA)
   - Credit issued to Referrer
3. Care kit + Plan card
4. Soft sell next visit (ดู Conversion Sequence)
```

### Voucher Redemption
```
1. Mark "Voucher used" + "Treatment completed"
2. System logs:
   - Variable cost
   - Redemption ID
3. Care kit + Plan card
4. Update customer record
```

### Member Treatment
```
1. Mark "Treatment completed"
2. Update cumulative spending
3. Check if benefit ที่เกี่ยวข้อง available:
   - Birthday gift due?
   - Annual Trica3D due?
4. Care kit + Plan card
```

---

## Daily Closing Routine (7:00 PM)

ก่อนปิดบริการ admin ทำ:

1. **Reconcile bookings:**
   - All treatments marked correctly?
   - Vouchers properly recorded?
   - Guest Pass status updated?
2. **Trigger auto-actions:**
   - Pass redemption notifications sent?
   - Credit issued to referrers?
3. **Update tracking sheet:**
   - Daily revenue summary
   - Variable cost summary
   - Guest Pass status changes
4. **Flag issues:**
   - Pending verification cases
   - Suspicious activity (multiple bookings same phone)
   - Customer complaints to escalate

---

## Weekly Review (Monday morning)

1. **Guest Pass metrics:**
   - Passes issued last week
   - Passes redeemed
   - Conversion rate
2. **Credit metrics:**
   - Credits earned
   - Credits redeemed
   - Credits expiring soon (alert)
3. **Member metrics:**
   - New members
   - Birthday gifts pending
   - Annual reviews scheduled
4. **Identify issues:**
   - Bottlenecks in workflow
   - Common edge cases
   - Need for SOP update

---

## Forbidden Behaviors (Admin Code of Conduct)

| Don't | Do |
|---|---|
| "คอร์สนี้ดีกว่านะคะ" (upsell pressure) | "ถ้าสนใจ ดูราคาในเว็บได้นะคะ" |
| "ทำเพิ่มอีกได้นะคะ" หลังจบ treatment | Care kit + "หมอแนะนำให้รอ X อาทิตย์" |
| "หายขาด/การันตี/100%" | "ดีขึ้นชัด / ลึกตื้นขึ้น" |
| "promotion วันนี้เท่านั้น" | "ราคาทุกรายการ ดูในเว็บได้ตลอด" |
| Forced "Birthday gift use today" | "ลองดูว่าตรงกับช่วงไหนสะดวก" |
| Reveal customer info to ผู้อื่น | Privacy first — only own customer |

---

## Cross-Reference

- Guest Pass full SOP → `../playbook/guest-pass-system.md`
- Member benefits → `../playbook/member-tier-benefits.md`
- Product details → `../playbook/product-positioning.md`
