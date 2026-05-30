# n8n · Ad Automation (Clarity)

> สถาปัตยกรรม **Hybrid**: 🧠 Claude = สมอง (creative · brand audit · สรุปผล) · 🤚 n8n = มือ (แตะ API · เขียนตัวเลข) · 📋 Notion = โต๊ะกลาง

```
🧠 Claude (scheduled)          🤚 n8n (scheduled)
─────────────────             ─────────────────
คิด creative + แคปชัน           WF3  ดึง metric FB/TikTok → Notion   ✅ มีแล้ว (read-only)
ตรวจ brand compliance          WF2  ยิงแอด หลังอนุมัติ (publish)      ⏸ ทำทีหลัง
อ่าน metric → สรุป/แนะนำ          WF4  เฝ้างบ / auto-pause              ⏸ ทำทีหลัง
        │                            ▲
        └────── เขียน/อ่าน Notion ────┘
```

เริ่มจาก **WF3 (Reporting · อ่านอย่างเดียว)** ก่อน — ไม่แตะเงิน เสี่ยงต่ำสุด พิสูจน์ท่อ Claude↔Notion↔n8n ให้นิ่งก่อน

---

## WF3 · Ad Reporting → Notion

ทุกเช้า 08:00 (Asia/Bangkok) ดึงตัวเลข "เมื่อวาน" ของ Meta + TikTok แล้วเขียนเป็นแถวใหม่ลง
**📊 Ads Performance Tracker** (1 แถว = 1 campaign × platform × วัน)

```
Daily 08:00 ─┬─ Meta · Get Insights ── Map ── Notion · Create Row (Meta)
             └─ TikTok · Get Report ── Map ── Notion · Create Row (TikTok)
```

**ปลายทาง (ยืนยันแล้วว่าเขียนได้จริงผ่าน MCP):**
- Database: `📊 Ads Performance Tracker`
- `NOTION_DB_ID = a0a269402d03470ab7a895b76f65fec7`
- data source: `collection://509aa90a-3cce-4194-9a62-d572c6f501f5`

### Field mapping — API → Notion

| API (Meta / TikTok)                 | คอลัมน์ Notion   | n8n เติม |
|-------------------------------------|------------------|:-------:|
| `spend`                             | Spend (THB)      | ✅ |
| `impressions` · `reach`             | Impressions · Reach | ✅ |
| `clicks` · `ctr`                    | Clicks · CTR %   | ✅ |
| `cpm` · `cpc`                       | CPM · CPC        | ✅ |
| `cost_per_action_type` (lead/msg) / `cost_per_conversion` | CPL (THB) | ✅ |
| `date_start` / `stat_time_day`      | Date             | ✅ |
| `publisher_platform` / fixed        | Platform · Placement | ✅ |
| `campaign_name` (regex `AD0x/ST0x/CR0x`) | Ad Campaign | ✅ (ถ้าตั้งชื่อแคมเปญมีรหัส) |

> 💡 **ตั้งชื่อแคมเปญใน Ads Manager ให้มีรหัส** เช่น `AD03 · หลุมสิว · wk22` แล้ว n8n จะ map เข้าช่อง Ad Campaign ให้อัตโนมัติ

### ครึ่งล่างของกรวย — n8n เติมไม่ได้ (มาจาก CRM/การจอง)

`Consults Booked · Shown · Customers · Revenue · CAC · ROAS · LINE Adds`
→ กรอกมือ หรือต่อจากระบบจอง/LINE OA ทีหลัง (ดู "ถัดไป")

---

## วิธีรัน

```bash
cd automation/n8n
cp .env.n8n.example .env          # แล้วเติม token จริง
docker compose up -d              # เปิด n8n ที่ http://localhost:5678
```

แล้วใน UI ของ n8n:
1. **Workflows → Import from File** → เลือก `workflows/wf3-reporting-meta-tiktok-to-notion.json`
2. กด **Execute Workflow** ทดสอบ 1 ครั้ง (ดูว่ามีแถวใหม่โผล่ใน Notion ไหม)
3. ติดปัญหา auth → ดู "Token ที่ต้องเตรียม" ด้านล่าง
4. โอเคแล้ว → กด **Active** (toggle) ให้รัน cron ทุกเช้าเอง

> ไม่ต้องตั้ง n8n credential ใดๆ — flow อ่าน token จาก env ทั้งหมด (`$env.*`)
> docker-compose เปิด `N8N_BLOCK_ENV_ACCESS_IN_NODE=false` ให้แล้ว

---

## Token ที่ต้องเตรียม (มี lead time — เริ่มขอเร็ว)

| Token | ขอจากไหน | หมายเหตุ |
|---|---|---|
| **Notion** | notion.so/my-integrations → สร้าง internal integration → แชร์หน้า Ads Tracker ให้ integration | ใช้ได้ทันที |
| **Meta** | Business Manager → System User → token scope `ads_read` | ต้องผ่าน **business verification** |
| **TikTok** | TikTok for Business → Developer app → Reporting API → `advertiser_id` + access token | ต้อง **approve app** |

> Reporting ขอแค่สิทธิ์ "อ่าน" — เบากว่าตอน publish (ที่ต้องขอ `ads_management`)

---

## ความปลอดภัย

- `.env` ถูก gitignore ไว้ — **ห้าม commit token**
- ตั้ง `N8N_BASIC_AUTH_PASSWORD` ให้แข็งแรง ถ้าเปิดออกเน็ต ควรมี reverse proxy + HTTPS
- WF3 เป็น **read-only** ต่อแพลตฟอร์มแอด — เขียนแค่ Notion เท่านั้น ไม่แตะงบ/ไม่ยิงแอด

---

## ถัดไป (ยังไม่ทำในรอบนี้)

- [ ] WF2 · Publish (approved → สร้าง campaign/adset/ad) — ต้อง `ads_management` + human approval gate
- [ ] WF4 · Budget guardrail — CAC > 2,000฿ → แจ้งเตือน/auto-pause (อ้าง `BUDGET.md`)
- [ ] เชื่อม "ครึ่งล่าง" ของกรวย (จอง→รายได้→CAC) จากระบบจอง/LINE OA
- [ ] Claude scheduled session อ่าน Notion → สรุป/แนะนำรายวัน

## Cross-reference

- ตัวชี้วัด/เพดาน CAC → `../../BUDGET.md`
- Brand doctrine (กันคำต้องห้ามตอนทำ creative) → `../../BRAND.md`
