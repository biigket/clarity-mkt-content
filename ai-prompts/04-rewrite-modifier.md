# 04 · Rewrite / Modifier Prompt

> Use to create variants of existing approved scripts
> Maintain Clarity brand · change one dimension at a time

---

```txt
Rewrite this Clarity Clinic script.

ORIGINAL SCRIPT:
{{SCRIPT}}

MODIFIER:
{{MODIFIER}}

Possible modifiers:
- more viral (TikTok-trend hook · faster pace · pattern interrupt)
- more calm (slower documentary mood · less emphasis)
- more scientific (add 1-2 technical terms · cite biology)
- more hopeful (lean into outcome aspiration)
- more emotional (patient voice · vulnerability)
- shorter (cut to specified length · 15s/30s/45s)
- more documentary (less first-person · more observation)
- more controversial (sharpen anti-mkt edge · without forbidden words)
- more consultation-oriented (heavier on "ปรึกษาฟรี" framing)

REQUIREMENTS (preserve):
- Clarity voice (หมอ Big · พูดตรงๆ · friendly · humor 5555 ok)
- Brand realism (no "หายขาด · 100% · อันดับ 1")
- Documentary pacing (even when "more viral" · still documentary base)
- Scientific honesty
- Dual tagline reference (at least 1x)
- Standard CTA template

ALLOW TO CHANGE:
- Word choice
- Sentence rhythm
- Hook opening
- Specific examples/metaphors
- Length (per modifier)
- Emphasis distribution

DO NOT CHANGE:
- Core message / claim
- Pricing (5,000 stays 5,000)
- Location (ราชเทวี ใกล้ BTS)
- Forbidden word avoidance
- Brand pillars (30/70 · ทุกชั้นผิว · ไม่ขายคอร์ส)
- CTA destination (LINE @clarityclinic)

OUTPUT:
Rewritten final TTS script only.
At end · 1-line note:
"Changes: [what shifted vs original]"
```

---

## Real Use Cases

### Case 1: Make AM1 shorter for ad cut

**Input:**
```
SCRIPT: [paste AM1 full 75s script]
MODIFIER: shorter (15s for Meta cold)
```

**Expected output:** 15-second cut · preserves hook + 1 main message + CTA · drops education middle

### Case 2: Make PE6 more viral for TikTok

**Input:**
```
SCRIPT: [paste PE6 80% มีคนทัก]
MODIFIER: more viral (TikTok-trend hook)
```

**Expected output:** Same content · new opening matches TT pattern · faster early pace · same closing

### Case 3: Make PS4 more emotional

**Input:**
```
SCRIPT: [paste PS4 รอ 6 อาทิตย์]
MODIFIER: more emotional
```

**Expected output:** Open with patient voice/feeling first · doctor reflection second · vulnerability surfaced

---

## Don't Use Rewrite When...

- Topic is completely different → use Script Generator (02) instead
- Want different hook on same topic → use Hook Generator (03)
- Original script has forbidden words → fix manually first
- More than 2 modifiers needed → break into 2 sequential rewrites

---

## Quality Check After Rewrite

1. Read both side-by-side · sense of "same speaker · different mood"?
2. Hook still stops scroll in 1-3 seconds?
3. Length actually matches modifier target?
4. CTA still matches standard?
5. Voice still feels like หมอ Big (not generic AI)?

If any fail · re-run with sharper modifier or revert to original.
