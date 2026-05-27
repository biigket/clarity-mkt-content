# Clarity AI Prompt System

> Reusable prompt templates สำหรับ scale content production
> Use with: ChatGPT · Claude · Gemini · any LLM

---

## 📋 Files

| # | File | Use case |
|---|------|----------|
| **01** | `01-master-system.md` | System prompt · ตั้ง brand DNA · paste ก่อนทุก session |
| **02** | `02-script-generator.md` | Generate new 45-60s script จาก topic |
| **03** | `03-hook-generator.md` | Generate 10 hooks/topic · **ใช้สำหรับ ad testing** |
| **04** | `04-rewrite-modifier.md` | แปลง 1 script เป็น variants (more viral · shorter · etc.) |

---

## 🔄 Recommended Workflow

```
Topic idea
   ↓
[01 Master] paste as system prompt
   ↓
[03 Hook Gen] → 10 hooks → pick top 3
   ↓
[02 Script Gen] → full 45-60s script with picked hook
   ↓
[04 Rewrite] (optional) → variant for ad testing
   ↓
Production (HeyGen + editor)
   ↓
Post + analytics feedback
```

---

## ⚙️ Customizations from original Phase 1-4

| Item | Original | Clarity v1 |
|------|----------|------------|
| Visual | espresso/brown · cinematic | ✅ kept |
| Voice | calm documentary | ❌ override → founder personality · พูดตรงๆ · humor ok |
| Tagline | "หลุมสิวต้องรักษาทุกชั้นผิว" | ➕ added "หลุมสิว 5,000 จบที่ Clarity" (primary) |
| Length | 45-60s | ✅ kept |
| Topics | 10 technical (RF/CO2/fibrosis) | ➕ added Brand/Patient/Anti-mkt categories |

---

## 🎯 When to Use Which Prompt

| Need | Use |
|------|-----|
| ออก 10 hooks ใหม่ทดสอบ ads | **03 Hook Gen** |
| สร้าง 20 evergreen Month 2-3 | **02 Script Gen** ผ่านทุก topic ใน CALENDAR.md |
| มี winner organic แล้ว · อยาก variant ads | **04 Rewrite** กับ modifier "shorter" + "more viral" |
| Brief outsource agency / new copywriter | **01 Master** (ส่งให้อ่านก่อนเริ่มงาน) |

---

## 📂 Where outputs go

- Hooks สำหรับ ads → `ads/month-X-hook-bank.md`
- New scripts → `video-briefs/[CLIP_ID].md`
- Variants สำหรับ ad testing → `ads/[CLIP_ID]-variants.md`

---

## ⚠️ Quality gates

Before publishing AI-generated content:

1. ✅ ไม่มี forbidden words (หายขาด · การันตี · 100% · อันดับ 1)
2. ✅ มี dual tagline reference อย่างน้อย 1 บรรทัด
3. ✅ Voice = หมอ Big (ไม่ใช่ ChatGPT-default voice)
4. ✅ Length match target (45-60s for new · ads can be 6/15/30s cuts)
5. ✅ CTA = "ปรึกษาฟรี · ทักไลน์ at clarityclinic"
6. ✅ Human review โดย หมอ Big · marketing lead ก่อน production
