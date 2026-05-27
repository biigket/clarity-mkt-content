# 03 · Hook Generator Prompt

> Most valuable prompt for ads testing
> Generates 10 hooks/topic for A/B variant testing

---

```txt
Using the Clarity Clinic brand doctrine (from 01 Master):

Generate 10 short-form hooks (1-3 second opening lines) for this topic:

TOPIC:
{{TOPIC}}

HOOK CATEGORY:
{{HOOK_CATEGORY}}

Possible categories:
- contradiction (challenges common belief)
- misconception (corrects myth)
- failed experience (patient/clinic story)
- hope (aspirational outcome)
- compare logic (A vs B framing)
- doctor POV (insider view)
- direct response (immediate value prop · price/location)

REQUIREMENTS:
- 1-3 seconds read time at voice speed 1.3 (Thai · approx 8-15 words)
- Stop-scroll worthy (first frame text overlay must work silent)
- หมอ Big voice (พูดตรงๆ · casual · friendly)
- Comment-inducing (creates discussion, not just emoji reaction)
- Documentary tone · ไม่ใช่ TikTok shock energy

AVOID:
- Loud clickbait
- Fake shock ("คุณจะไม่เชื่อ...")
- Fear marketing ("ถ้าไม่ทำตอนนี้...")
- Forbidden words: หายขาด · การันตี · 100% · อันดับ 1 · ครั้งเดียวเปลี่ยน
- Generic energy (must feel Clarity-specific)

DIVERSITY RULE:
- Mix angle types within the 10 (not all the same category)
- At least 1 contains primary tagline "5,000"
- At least 1 contains secondary tagline "ทุกชั้นผิว"
- At least 2 are testable on cold audience (no context needed)
- At least 2 are stronger for warm/retarget (assume viewer knows brand)

OUTPUT:
1. [Hook]
2. [Hook]
3. [Hook]
4. [Hook]
5. [Hook]
6. [Hook]
7. [Hook]
8. [Hook]
9. [Hook]
10. [Hook]

TOP 3 RECOMMENDED FOR INITIAL TEST:
A: #X — reason (audience + funnel stage)
B: #Y — reason
C: #Z — reason
```

---

## Real Example · AM1 Hooks Generated

**Input:**
```
TOPIC: ทำไมหมอไม่ใช้คำว่า หลุมสิวหายขาด
HOOK_CATEGORY: contradiction
```

**Output:** (see `ads/month-1-hook-bank.md` for full 50-hook output)

```
1. ในวงการนี้ ถ้าใครพูด หลุมสิวหายขาด เลิกฟัง
2. หมอบอกหาย 100% = หมอโกหก · พูดตรงๆ
3. หลุมสิวที่ทำลายไปแล้ว · ร่างกายสร้างกลับไม่เหมือนเดิม
... (7 more)

TOP 3 RECOMMENDED:
A: #1 — proven organic hook · cold audience · contrarian command
B: #4 — ties to brand tagline · warm/retarget · brand consistency
C: #6 — interactive · invites engagement · cold + warm both
```

---

## When to Use This Prompt

| Scenario | Frequency |
|----------|-----------|
| Launch new ads campaign | Once per clip · before production |
| Refresh ad creatives (Week 3+) | Every 2-3 weeks per active clip |
| New topic exploration (Month 2+) | Per new evergreen brief |
| Diagnose ad fatigue (CPL rising) | After 7-10 day decline trigger |

## How to Pick the Right Top 3

1. **Cold audience need** = high stop-scroll · contrarian/curiosity
2. **Warm audience need** = trust deepener · brand consistency · save-worthy
3. **Hot audience need** = direct value prop · price/location · urgency-without-fake

Pick 1 from each tier when possible.
