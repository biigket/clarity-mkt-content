# 02 · Script Generator Prompt

> Use this after loading 01 Master System Prompt
> Generates 45-60s script with 2 hooks + final TTS

---

```txt
Using the Clarity Clinic system prompt and brand doctrine:

Generate a short-form documentary-style Clarity content script.

TOPIC:
{{TOPIC}}

PILLAR:
{{PILLAR}}  // Brand / Patient / Education / Anti-marketing

PRODUCT FOCUS:
{{PRODUCT}}  // หลุมสิว / ยกกระชับ / งานผิว / Cross

REQUIREMENTS:
- Generate Hook A (primary)
- Generate Hook B (alternate)
- Generate Final TTS Script (45-60 seconds reading at voice speed 1.3)
- Storytelling flow with compare logic
- Realistic medicine (no overpromise)
- Hopeful tone (not fearmongering)
- Consultation-first CTA matching standard template
- Use understandable medical explanation (simplify jargon immediately)
- Reference dual tagline at least 1x: "หลุมสิว 5,000 จบที่ Clarity" + "หลุมสิวต้องรักษาทุกชั้นผิว"
- Voice = หมอ Big personality (พูดตรงๆ · ไม่ formal · humor 5555 ok)
- Standard CTA: "[Product] 5,000 จบที่ Clarity ราชเทวี ใกล้ BTS · ปรึกษาฟรี ทักไลน์ at clarityclinic"

AVOID:
- Hard sell · aggressive marketing
- Fake urgency · "ลดสูงสุดเพียงวันนี้"
- Exaggerated claims · "หายขาด · 100% · อันดับ 1"
- Luxury flex
- Attacking specific clinics by name
- Generic ChatGPT voice

OUTPUT FORMAT:

HOOK A:
[1-3 second opening · stop scroll]

HOOK B:
[alternate opening for A/B test]

FINAL TTS SCRIPT:
[45-60 seconds total · use Hook A as opening · include philosophy reference · end with CTA]

VOICE DIRECTION NOTE:
[1 line: pacing · emotion · key emphasis words]

VISUAL CUE NOTE:
[1-2 lines: scene mood · B-roll suggestion · ที่ไม่ต้องเห็นหน้าคนไข้]
```

---

## Example Usage

**Input:**
```
TOPIC: ทำไมต้องรอ 6 อาทิตย์ก่อนทำซ้ำ
PILLAR: Education
PRODUCT: หลุมสิว
```

**Expected Output:** 45-60s script that:
- Explains collagen mature cycle (6-8 weeks)
- Uses หมอ Big voice (พูดตรงๆ · friendly)
- References "หลุมสิวต้องรักษาทุกชั้นผิว" once
- Ends with "หลุมสิว 5,000 จบที่ Clarity ราชเทวี ใกล้ BTS · ปรึกษาฟรี ทักไลน์ at clarityclinic"
- Visual cue: clinic interior · calendar timeline animation · ไม่เห็นหน้าคนไข้
