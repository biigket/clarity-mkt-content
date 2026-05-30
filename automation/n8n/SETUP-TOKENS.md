# คู่มือเอา Token — WF3 Ad Reporting

> เป้าหมาย: เติม 5 ค่าลง `automation/n8n/.env` ให้ flow วิ่งได้
> (`NOTION_DB_ID` รู้แล้ว = `a0a269402d03470ab7a895b76f65fec7`)
>
> ลำดับแนะนำ: **Notion → Meta → TikTok** (ง่าย→ยาก)

---

## 1️⃣ Notion — `NOTION_TOKEN` (≈3 นาที · ได้ทันที ไม่ต้อง verify)

1. เปิด https://www.notion.so/my-integrations
2. กด **+ New integration**
3. ตั้งชื่อ `Clarity n8n` · เลือก workspace **Thitikom's Space HQ** · Type = **Internal**
4. กด **Save** → เข้าไปแท็บ **Configuration**
5. หัวข้อ **Capabilities** ติ๊กให้มี ✅ Read content ✅ Insert content
6. คัดลอก **Internal Integration Secret** (ขึ้นต้น `ntn_` หรือ `secret_`) → นี่คือ **`NOTION_TOKEN`**
7. ⚠️ **สำคัญที่สุด — แชร์ DB ให้ integration:**
   - เปิดหน้า **📊 Ads Performance Tracker** ใน Notion
   - มุมขวาบน กด **•••** → **Connections** → **Add connections** → เลือก **Clarity n8n**
   - (ถ้าไม่แชร์ขั้นนี้ n8n จะเขียนไม่ได้ → error 404/unauthorized)

✅ ได้: `NOTION_TOKEN`

---

## 2️⃣ Meta (Facebook + Instagram) — `META_ACCESS_TOKEN` + `META_AD_ACCOUNT_ID`

ต้องมี **Business Manager** (business.facebook.com) ที่มีบัญชีแอดอยู่แล้ว

### 2.1 หา Ad Account ID
1. business.facebook.com → **Business settings** (เฟือง)
2. ซ้ายมือ **Accounts → Ad accounts** → คลิกบัญชีที่ยิงแอด
3. เห็นเลข **Account ID** (ตัวเลขล้วน) → นี่คือ **`META_AD_ACCOUNT_ID`**
   *(ใส่แค่ตัวเลข ไม่ต้องมี `act_` — flow เติม `act_` ให้เอง)*

### 2.2 สร้าง App + System User token (อายุยาว)
1. https://developers.facebook.com → **My Apps → Create App** → ประเภท **Business** → ตั้งชื่อ → Create
2. ในแอป → **Add Product** → เพิ่ม **Marketing API**
3. กลับไป **Business settings → Users → System users** → **Add** → ชื่อ `clarity-n8n` · role **Admin**
4. กด **Add assets** → เลือก **Ad account** ที่จะดึง → เปิดสิทธิ์ **View performance** (อ่าน)
5. กด **Generate new token** → เลือกแอปที่เพิ่งสร้าง
6. ติ๊ก scope: **`ads_read`** + **`read_insights`** → **Generate token**
7. คัดลอก token (ขึ้นต้น `EAA...`) → นี่คือ **`META_ACCESS_TOKEN`**
   *(System User token อายุยาว/ไม่หมดง่าย — เหมาะกับ automation)*

> ⚠️ ถ้า Meta บังคับ **Business verification** ก่อนออก token ให้ทำตามที่มันแจ้ง (อัปเอกสารธุรกิจ) — มี lead time

✅ ได้: `META_ACCESS_TOKEN` · `META_AD_ACCOUNT_ID`

---

## 3️⃣ TikTok — `TIKTOK_ACCESS_TOKEN` + `TIKTOK_ADVERTISER_ID`

ขั้นนี้ยุ่งสุด (ต้องผ่าน OAuth ของ developer app)

### 3.1 หา Advertiser ID
1. เปิด **TikTok Ads Manager** (ads.tiktok.com)
2. มุมขวาบน/Account info → เห็นเลข **Advertiser ID** → นี่คือ **`TIKTOK_ADVERTISER_ID`**

### 3.2 สร้าง Developer App + ขอ token
1. https://business-api.tiktok.com → **Register as developer** (ถ้ายังไม่เคย)
2. **My Apps → Create an App** → กรอกชื่อ/คำอธิบาย/redirect URL
3. ขอสิทธิ์ (scope) ที่มี **Reporting / Ad Account – Read**
4. ส่ง **App review** ให้ TikTok อนุมัติ *(มี Sandbox ให้เทสต์ก่อนได้)*
5. หลังอนุมัติ → ทำ **Authorization (OAuth)**: เอา advertiser ของพี่ authorize ให้แอป
6. แลกได้ **`access_token`** (อายุยาว) → นี่คือ **`TIKTOK_ACCESS_TOKEN`**

> ⚠️ TikTok ต้อง **approve app** ก่อนใช้ production — เริ่มสมัครเร็วๆ เพราะรอนาน

✅ ได้: `TIKTOK_ACCESS_TOKEN` · `TIKTOK_ADVERTISER_ID`

---

## 4️⃣ เสียบค่า + รันทดสอบ

```bash
cd automation/n8n
cp .env.n8n.example .env      # ถ้ายังไม่ได้ทำ
# แก้ .env เติม 5 ค่าที่ได้มา + ตั้ง N8N_BASIC_AUTH_PASSWORD
docker compose up -d          # เปิด n8n → http://localhost:5678
```

ใน n8n UI:
1. **Workflows → Import from File** → `workflows/wf3-reporting-meta-tiktok-to-notion.json`
2. กด **Execute Workflow** (เทสต์ 1 ครั้ง)
3. เปิด Notion **Ads Performance Tracker** → ต้องเห็นแถวใหม่ของเมื่อวานโผล่
4. โอเคแล้ว → toggle **Active** ให้รัน cron ทุกเช้าเอง

---

## เช็กลิสต์

- [ ] `NOTION_TOKEN` + แชร์ DB ให้ integration แล้ว
- [ ] `META_ACCESS_TOKEN` + `META_AD_ACCOUNT_ID`
- [ ] `TIKTOK_ACCESS_TOKEN` + `TIKTOK_ADVERTISER_ID`
- [ ] `docker compose up` + import + Execute เห็นแถวใน Notion
- [ ] กด Active

> 💡 ทำ **Notion อย่างเดียวก่อนก็ได้** แล้วเทสต์ Meta/TikTok ทีละตัวพอ token มาถึง — ไม่ต้องรอครบ 3 ตัว
