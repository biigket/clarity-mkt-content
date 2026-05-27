# Member Tier Benefits

> Lite tier upgrade — ลูกค้าที่ใช้จ่ายครบ 5,000 บาท
> Auto-upgrade เมื่อ trigger threshold

---

## Eligibility

**Cumulative spending ≥ 5,000 บาท** (ทุกครั้งที่ทำรวมกัน — ไม่จำกัดเวลา)

= **1 bundle purchase** = Member ทันที

### Why 5,000 Threshold

- ตรงกับ 1 bundle (low barrier — easy unlock)
- ไม่ต้องสะสมยอด — single transaction OK
- Psychology: "ทำครั้งแรกได้ Member" = reward feeling immediate

### Auto-upgrade Logic

```
Trigger: payment confirmed + cumulative ≥ 5,000
   ↓
System actions (auto, < 1 min):
1. Update customer record: is_member = true
2. Extend existing Guest Pass expiry (3 → 6 เดือน)
3. Extend existing Credits expiry (6 → 12 เดือน)
4. Activate bonus credit tracking
5. Send LINE OA welcome message
6. Add to "Member" segment in marketing tools
```

---

## Member Benefits (8 ตัว)

### 1. Extended Guest Pass Validity
| Non-member | Member |
|---|---|
| 3 เดือน | **6 เดือน** |

Existing passes auto-extend ทันทีเมื่อ upgrade

### 2. Extended Credit Validity
| Non-member | Member |
|---|---|
| 6 เดือน | **12 เดือน** |

Existing credits auto-extend ทันที

### 3. Bonus Credit (3+1 Pattern)
- ทุก 3 successful referrals → +1 bonus credit
- ใช้รวมกับ credit ปกติได้
- เช่น 3 ref ปกติ = 3 credit + 1 bonus = 4 credits → แลก Doublo2 + Picolaser ได้

### 4. Priority Booking
- Lunch slot (12:00-13:30) — priority queue
- After-work slot (18:00-20:00) — priority queue
- Weekend slot — booking ก่อน non-member 7 วัน

### 5. Birthday Gift
- **Meso Clarity Bright ฟรี 1 ครั้ง** วันเกิด
- Valid ภายในเดือนเกิด ± 1 เดือน (window 3 เดือน)
- Auto LINE OA message 30 วันก่อนวันเกิด

### 6. Annual Trica3D Scan + Plan Review
- ฟรี 1 ครั้ง/ปี
- 45-นาที session กับหมอ Big
- ได้: Trica3D scan + Annual skin plan + Q&A
- เหมาะกับ January หรือเดือนที่สมัคร Member (anniversary)

### 7. Dr.Big Direct LINE
- LINE OA reply โดย หมอ Big เอง (1-2 message/week)
- สำหรับคำถามที่ technical
- Admin คัดกรอง — ไม่ใช่ทุก message ถึงหมอ
- Response time: < 48 ชม.

### 8. Member-only Event Access
- Quarterly skin masterclass (online + offline)
- Member dinner / appreciation event (ปีละ 1-2 ครั้ง)
- Early access to new treatments

---

## Member Benefit Cost Analysis

| Benefit | Variable Cost | Frequency |
|---|---|---|
| Guest Pass extended | 0 (admin only) | Per pass |
| Credit extended | 0 | Per credit |
| Bonus credit (Picolaser tier) | ~500 | Per 3 ref |
| Priority booking | 0 | Per booking |
| Birthday Meso | ~500 | Once/year |
| Annual Trica3D + plan | ~100 (consumables) | Once/year |
| Dr.Big direct LINE | Time only | Ongoing |
| Member event | ~200-500/head | 2-4x/year |

**Total annual cost per Member:** ~1,500-2,500 บาท

### ROI

```
Average Member spending/year:   20,000 (4 × 5K bundle)
Member cost/year:               ~2,000
Member margin/year (avg 70%):   ~12,000
LTV (3 years):                  ~36,000+

ROI: 18x annual cost
```

---

## Member Lifecycle

```
[Day 0] Customer makes first bundle purchase
   ↓ Auto upgrade to Member
   ↓ LINE OA welcome message

[Month 1-3] Member uses Guest Pass + earns credits
   ↓ Bonus credit on 3rd referral

[Month 3-6] Member redeems credits + buys more bundles
   ↓ Repeat purchase = retention

[Month 12] Anniversary
   ↓ Annual Trica3D + plan review
   ↓ Birthday gift (separately by month)

[Ongoing] Quarterly events + Dr.Big LINE access
```

---

## Communication Touchpoints

### TP1: Member Welcome (immediate)
```
🎉 ยินดีต้อนรับเป็น Clarity Member!

คุณได้รับสิทธิ์พิเศษ:
- Guest Pass อายุ 6 เดือน (จาก 3 เดือน)
- Credit อายุ 12 เดือน (จาก 6 เดือน)
- Birthday gift: Meso Clarity Bright ฟรี
- Trica3D annual + Plan review ฟรี
- Dr.Big direct LINE access
- Priority booking + Member events

ดูสิทธิ์เต็มได้ใน LINE OA → "My Membership"
```

### TP2: Birthday (30 days before)
```
🎂 ใกล้วันเกิดของคุณแล้ว!

ของขวัญจากเรา: Meso Clarity Bright ฟรี
ใช้ภายในเดือนนี้ ± 1 เดือน

[จองวันเกิด]
```

### TP3: Annual Trica3D (anniversary month)
```
📊 ครบ 1 ปี — มาดู Trica3D ของคุณ

จองได้: Annual Trica3D + Plan review (ฟรี)
- ดูการเปลี่ยนแปลงผิว 12 เดือน
- ปรับ skin plan สำหรับปีหน้า
- 45 นาทีกับหมอ Big

[จอง]
```

### TP4: Member Event Invite (quarterly)
```
✉️ Skin Masterclass — Member Only

หัวข้อ: [topic]
วันที่: [date]
สถานที่: Clarity Clinic หรือ Online

[ลงทะเบียน]
```

---

## Member Status Dashboard (in LINE OA)

```
═══════════════════════════════════════
🌟 CLARITY MEMBER

ชื่อ: [Customer name]
สถานะ: Member since [date]
อายุสมาชิก: [X เดือน]

═══════════════════════════════════════
GUEST PASSES
─── Pass #1 — เหลือ 45 วัน — UNUSED
─── Pass #2 — เหลือ 45 วัน — UNUSED  
─── Pass #3 — เหลือ 45 วัน — UNUSED

═══════════════════════════════════════
CREDITS — 2 credits + 0 bonus
─── ใช้แลก: งานผิว 5K ฟรี
─── Credit หมดอายุ: [date + 12 เดือน]

═══════════════════════════════════════
BENEFITS STATUS
─── Birthday gift: [available / used]
─── Annual Trica3D: [available / scheduled / used]
─── Dr.Big LINE: [active]

═══════════════════════════════════════
TOTAL SPENDING: 27,000 บาท
TREATMENT HISTORY: [link]
```

---

## Edge Cases & Rules

| Situation | Rule |
|---|---|
| Member ไม่ทำ treatment 12 เดือน | Member status คงอยู่ แต่ status เป็น "inactive" — benefit ใช้ได้แต่ admin จะ check-in |
| Member request downgrade | ไม่ได้ — Member เป็น lifetime status |
| Birthday gift ลืมใช้ | Reset ปีหน้าได้ (1 gift/year) |
| Annual Trica3D ไม่ใช้ | Reset ตอน anniversary (1/year) |
| Member ขอ Dr.Big LINE บ่อยเกิน | Admin คัดกรอง — หมอ Big approve 5-10 message/week max |
| Member ขอย้ายไป Optima | OK — Optima เป็น B2B (คนละ business) แยกระบบ |

---

## Cross-Reference

- Guest Pass full SOP → `guest-pass-system.md`
- Per-product positioning → `product-positioning.md`
- Budget impact → `../BUDGET.md`
- Admin scripts → `../ops/admin-verification-script.md`
