# Condo TV Silent Loop · 15s · Acne Scar · 9:16 Vertical

> **Format:** 9:16 vertical · 15s silent loop · 3 cuts × 5s each
> **Use case:** Lift door panels · vertical lobby screens · portrait digital signage
> **Sibling:** `../condo-tv-loop-15s/` (16:9 horizontal variant)
> **Generation:** Phaya GPT Image 2 (image-to-image · v3 diagram reference)

---

## Why a separate folder

Vertical layouts need different visual hierarchies than horizontal — text stacks
top→bottom instead of side-by-side, diagram occupies the upper half instead of
the left third. The 16:9 prompts in the sibling folder would generate broken
compositions if simply re-rendered at 9:16, so the prompts are rewritten here.

The two folders share:
- Same reference image (`ads/assets/v3-diagram.png`)
- Same brand rules (palette · taglines · forbidden words · founder identity)
- Same 3-cut narrative (Education → Price → Location/CTA)
- Same animate timeline (5s per cut · 0.3s crossfade)

They differ in:
- Aspect ratio (9:16 here · 16:9 there)
- Prompt layouts (vertical stack here · horizontal split there)
- Output dimensions (1152×2048 here · 2048×1152 there)
- ffmpeg pad/scale (1080×1920 MP4 here · 1920×1080 there)

---

## Files

| File | Purpose |
|------|---------|
| `generate-i2i.sh` | i2i generator · aspect_ratio="9:16" · uses v3 diagram as reference |
| `prompts/cut1-i2i.txt` | Cut 1 · diagram top 55% · headline bottom 40% |
| `prompts/cut2-i2i.txt` | Cut 2 · price centered · brand-promise badge bottom |
| `prompts/cut3-i2i.txt` | Cut 3 · text top 40% · QR bottom 50% |

(No t2i variant yet · add if needed)

---

## Run

```bash
# From repo root
source .env
make generate-i2i-9x16             # generate 3 vertical PNGs
make animate-loop-9x16             # compose into 1080×1920 MP4
```

Outputs:
- `clarity-condo-cut1.png`, `cut2.png`, `cut3.png` (1152×2048 · 2K)
- `clarity-condo-loop-15s-9x16.mp4` (1080×1920 · H.264 · 15s)

Cost: ~6 credits per full regenerate (2 per cut)

---

## Brand compliance

Same checklist as 16:9 variant — see `../condo-tv-loop-15s/README.md` §
"Brand Compliance Checklist" and "Compliance · กฎหมายโฆษณาสถานพยาบาล".

Reminder before publish:
- [ ] Overlay real LINE QR on cut3 (placeholder is blank white square)
- [ ] Overlay ฉสพ. license number (compliance · bottom-corner small font)
- [ ] Confirm price 5,000 matches what's actually charged
- [ ] Verify on actual vertical screen at intended viewing distance

---

## Cross-reference

- 16:9 horizontal variant → `../condo-tv-loop-15s/`
- Reference diagram → `../assets/v3-diagram.png`
- Source diagram brief → `../static-poster-acne-scar-v3-diagram.md`
- Brand doctrine → `../../BRAND.md`
- Phaya API docs → https://phaya.io/docs
