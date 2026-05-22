# Google Sheets MCP Setup Guide

**Goal:** เปิดให้ Claude Code (ใน code.claude.com) อ่าน/แก้/append ข้อมูลใน Google Sheets ของคุณโดยตรง

**Time:** 15-20 นาที (ครั้งเดียว · ใช้ตลอด)

---

## Part 1 — Google Cloud Setup (10 นาที)

### 1.1 สร้าง Google Cloud Project

1. เปิด **console.cloud.google.com** · log in ด้วย account เดียวกับ Google Drive
2. คลิก project dropdown มุมบนซ้าย (ที่เขียน "Select a project" หรือชื่อ project ปัจจุบัน)
3. คลิก **"NEW PROJECT"** มุมบนขวา
4. กรอก:
   - **Project name:** `Clarity MCP`
   - Location: ปล่อย "No organization"
5. คลิก **CREATE** · รอ 10-20 วินาที
6. คลิก notification "Create Project: Clarity MCP" → **SELECT PROJECT**

### 1.2 Enable APIs (เปิด API 2 ตัว)

ที่ search bar บนสุด พิมพ์ → คลิก ENABLE ทีละตัว:

1. **"Google Sheets API"** → คลิก ENABLE · รอ 10 วินาที
2. กลับไป search bar → **"Google Drive API"** → คลิก ENABLE

> ทำไมต้อง 2 ตัว: Sheets API ใช้อ่าน/เขียน cell · Drive API ใช้ search file + permissions

### 1.3 สร้าง Service Account

1. Search bar → **"Service Accounts"** → คลิกผลที่ขึ้น "IAM & Admin"
2. คลิก **+ CREATE SERVICE ACCOUNT** (ปุ่มบนสุด)
3. กรอก:
   - **Service account name:** `claude-mcp-sheets`
   - Service account ID: auto-fill
   - Description: `MCP server for Claude Code Google Sheets access`
4. คลิก **CREATE AND CONTINUE**
5. **Grant access:** ข้ามได้ คลิก CONTINUE
6. **Grant users access:** ข้ามได้ คลิก **DONE**

### 1.4 สร้าง JSON Key (credentials)

1. คุณจะเห็น service account ใน list · คลิกเข้าไป
2. ไปที่ tab **KEYS** (บนสุด)
3. คลิก **ADD KEY → Create new key**
4. เลือก **JSON** → CREATE
5. ไฟล์ดาวน์โหลดอัตโนมัติ ชื่อประมาณ `clarity-mcp-xxx-xxx.json`
6. ⚠️ **เก็บไฟล์นี้อย่างปลอดภัย** เหมือน password · ใครได้ไฟล์นี้เข้าถึงชีทคุณได้หมด

### 1.5 Share Sheets ให้ Service Account

Service account = "user คนหนึ่ง" ที่มี email พิเศษ ต้อง share ชีทให้เหมือน share กับเพื่อน

1. เปิดไฟล์ JSON ที่เพิ่ง download · copy ค่าจาก field `"client_email"` (ตัวอย่าง: `claude-mcp-sheets@clarity-mcp-xxx.iam.gserviceaccount.com`)
2. เปิด Google Sheet ที่จะให้ Claude เข้า (เช่น `clarity-content-master`)
3. คลิก **Share** (มุมขวาบน)
4. Paste email + เลือก **Editor** → คลิก Send (ไม่ต้อง send notification ก็ได้)

**Shortcut สำหรับชีทเยอะ:** สร้าง folder ใน Drive ชื่อ `Clarity Claude` → ย้ายชีทเข้า folder นั้น → Share folder ทีเดียว · service account เข้าได้ทุก file ใน folder

> **TIP:** จำ Folder ID ไว้ (ดูจาก URL: `https://drive.google.com/drive/folders/[FOLDER_ID]`)

---

## Part 2 — code.claude.com Setup (5 นาที)

### 2.1 เปิด Environment Settings

1. เปิด **code.claude.com**
2. มุมขวาบน → คลิกชื่อ/avatar → **Environments**
3. หา environment ที่ running session นี้ (น่าจะชื่อ `clarity-mkt-content` หรือคล้าย)
4. คลิก **Edit** หรือ **Settings**

### 2.2 Upload Service Account JSON เป็น Secret

หา section **"Secrets"** หรือ **"Environment Variables"**:

**Option A — Upload เป็น file mount (แนะนำ)**
- Add file: `google-credentials.json`
- Paste contents ของ JSON file ที่ download ไว้
- Mount path: `/secrets/google-credentials.json`

**Option B — เก็บเป็น env var (ทางเลือก)**
- Add env var:
  - Name: `GOOGLE_SERVICE_ACCOUNT_JSON`
  - Value: paste JSON ทั้งก้อนเป็น string (ระวัง escape quote)

### 2.3 เพิ่ม MCP Server

หา section **"MCP Servers"** → คลิก **Add MCP Server** (หรือ Custom)

**ใช้ตัวนี้แนะนำ (xing5/mcp-google-sheets · Python · 19 tools):**

```json
{
  "name": "google-sheets",
  "command": "uvx",
  "args": ["mcp-google-sheets@latest"],
  "env": {
    "SERVICE_ACCOUNT_PATH": "/secrets/google-credentials.json",
    "DRIVE_FOLDER_ID": "<paste-folder-id-from-step-1.5>"
  }
}
```

> **DRIVE_FOLDER_ID** = optional · ถ้ามี → จำกัด Claude เข้าได้แค่ folder นี้ (safer) · ถ้าไม่ใส่ → Claude เข้าได้ทุก file ที่ service account share

**ทางเลือก (Node.js):**

```json
{
  "name": "google-sheets",
  "command": "npx",
  "args": ["-y", "@mkummer225/google-sheets-mcp"],
  "env": {
    "GOOGLE_APPLICATION_CREDENTIALS": "/secrets/google-credentials.json"
  }
}
```

### 2.4 Save + Restart

1. คลิก **Save** หรือ **Apply**
2. กลับมาที่ session นี้ · **/exit** หรือเริ่ม session ใหม่
3. รอ environment rebuild (1-2 นาที)

---

## Part 3 — Verify (2 นาที)

### 3.1 ตรวจ MCP โหลดสำเร็จ

ใน session ใหม่ ถาม:
> "What MCP tools do you have for Google Sheets?"

ควรเห็น tools เช่น:
- `mcp__google-sheets__list_spreadsheets`
- `mcp__google-sheets__get_sheet_data`
- `mcp__google-sheets__update_cells`
- `mcp__google-sheets__append_rows`
- `mcp__google-sheets__create_sheet`
- `mcp__google-sheets__batch_update`
- (รวมประมาณ 19 tools)

ถ้าไม่เห็น → ไป Troubleshooting ด้านล่าง

### 3.2 Test ทีละ tool

**Read test:**
> "อ่าน sheet Calendar ใน clarity-content-master ดูว่ามีคลิปไหนอาทิตย์นี้"

**Write test (ระวัง — เปลี่ยนข้อมูลจริง):**
> "Update row ของ PE6 ใน Calendar sheet · เปลี่ยน status เป็น 'Scheduled'"

**Append test:**
> "เพิ่ม row ใหม่ใน Calendar sheet · clip ID 'TEST-X' · status 'Idea'"
> (จำไว้ลบหลัง test เสร็จ)

---

## Troubleshooting

### "No Google Sheets tools available"
- Session ยังไม่ restart · /exit แล้วเข้าใหม่
- MCP config JSON syntax ผิด · ตรวจ `{}` `,` `:` ครบ
- Command ผิด: Python ต้อง `uvx` · Node ต้อง `npx`
- ดู logs ใน code.claude.com → Environment → Logs

### "403 Permission denied" / "Caller does not have permission"
- Service account email ไม่ได้ share กับชีท
- ตรวจ Share permission = **Editor** (ไม่ใช่ Viewer)
- รอ 1-2 นาทีให้ permission propagate
- ถ้าใช้ Folder approach · ตรวจชีทอยู่ใน folder ที่ share

### "404 File not found"
- Service account มองไม่เห็น file
- Search ผิด keyword · ลอง `list_spreadsheets` ดูก่อนว่ามีอะไรบ้าง
- ตั้ง `DRIVE_FOLDER_ID` ให้ตรง folder ที่ share

### "Invalid credentials" / "Unauthorized"
- Path ผิด · ตรวจ `SERVICE_ACCOUNT_PATH` ตรงกับ secret mount path
- JSON file เสีย · ลอง re-download key + ลอง parse ด้วย `jq` ดูก่อน

### "uvx: command not found"
- Environment ไม่มี Python + uv · ใช้ Node version (`@mkummer225/google-sheets-mcp`) แทน

---

## Quick Reference Commands

หลัง setup เสร็จ ลอง commands พวกนี้:

```
"List sheets ในโฟลเดอร์ Clarity Claude"
"Read sheet Calendar ดูคลิป Month 2"
"Update PE6 status เป็น 'Scheduled'"
"Append row ใหม่ใน Scripts sheet สำหรับ AM6"
"สร้าง sheet ใหม่ชื่อ Month 3 Calendar ใน folder"
"Format header row ของ Calendar เป็น bold + background sage"
"Get cells A1:K20 ของ Production Status"
```

---

## Security Notes

1. **JSON key file** = "password" ของ service account · เก็บอย่างปลอดภัย · ห้าม commit ลง git
2. **Folder isolation** = ใช้ `DRIVE_FOLDER_ID` จำกัด scope ดีกว่าให้เข้าทุก file
3. **Revoke ได้** เมื่อต้องการ · ลบ service account ใน console.cloud.google.com
4. **Quota** = Google Sheets API ฟรี 500 requests/minute · เหลือเฟือสำหรับ ops ปกติ

---

## ผลที่ได้

หลัง setup เสร็จ workflow จะเป็น:
- ✅ Claude อ่าน sheet ปัจจุบัน · plan content
- ✅ Claude update status ใน Calendar เมื่อ approve script
- ✅ Claude append clip ใหม่ใน library
- ✅ Claude สร้าง sheet ใหม่ทุก month จาก template
- ✅ Claude format/highlight แบบ programmatic

ไม่ต้อง export/import xlsx อีกต่อไป
