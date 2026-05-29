# Meta Feed Static Ads · 1:1 Square

> **Format:** 1:1 square (2K · 2048×2048 native · resize to 1080 for upload)
> **Use case:** Facebook Feed · Instagram Feed · LINE OA broadcast image · email hero
> **Sibling:** `../condo-tv-loop-15s-9x16/` (9:16 vertical condo TV variant)
> **Generation:** Phaya GPT Image 2 (image-to-image · v3 diagram as style reference)

---

## Why 1:1

- Meta Feed default crop = 1:1 · 4:5 portrait OK · 9:16 gets letterboxed
- Reusable across FB/IG feed/LINE OA broadcast/email hero
- Center-crop to 4:5 produces clean portrait variant (no loss of hero content)

---

## 4 Statics · Test phase rotation (Week 1-2)

| ID | Angle | Hero copy | Persona |
|---|---|---|---|
| **ST01** | Authority | "หลุมสิวต้องรักษาทุกชั้นผิว" + 4-layer diagram | A · C · D |
| **ST02** | Anti-scarcity | "ราคาคงที่ตลอดปี · ไม่มีลดราคา" | A · D |
| **ST03** | Doctor-Philosophy | "หมอ 30% — คนไข้ 70%" (text-only) | D · A |
| **ST04** | Transparency | "ราคาบนเว็บ · ไม่ขายคอร์ส" + QR | A · D |

→ 4 angles cover the 4 brand strength axes: Layered treatment · Anti-scarcity · Doctor-led · Price transparency

---

## How to (re-)generate

```bash
# Load env (PHAYA_API_KEY + REFERENCE_URL)
source .env

# Generate all 4 (sequential · 8 credits total · ~8 min)
make generate-static-1x1

# Or one at a time
bash scripts/phaya-single-i2i.sh \
  ads/feed-static-1x1/prompts/ST02-anti-scarcity-1x1.txt \
  ads/feed-static-1x1/ST02-anti-scarcity-1x1.png \
  1:1 2K
```

---

## Crop to 4:5 (Meta portrait) — free, no Phaya credits

```bash
for f in ads/feed-static-1x1/ST*-1x1.png; do
  out="${f/-1x1.png/-4x5.png}"
  ffmpeg -y -i "$f" -vf "crop=iw:iw*5/4" "$out"
done
```

→ produces `ST01-4x5.png`, `ST02-4x5.png`, etc. centered crop · no Phaya call

---

## Files

| File | Purpose |
|------|---------|
| `prompts/ST01-authority-1x1.txt` | Authority brand line + 4-layer diagram preserved |
| `prompts/ST02-anti-scarcity-1x1.txt` | Anti-scarcity tile · text-only (no diagram) |
| `prompts/ST03-philosophy-1x1.txt` | Doctor-Philosophy quote-card (text-only) |
| `prompts/ST04-transparency-1x1.txt` | "ราคาบนเว็บ · ไม่ขายคอร์ส" + QR |
| `ST0X-authority-1x1.png` etc. | Generated outputs (2K square) |

---

## Brand Compliance Checklist (per BRAND.md)

- [x] Espresso/brown palette · single (no sage green)
- [x] Bronze-gold accents · cream text
- [x] No equipment / device imagery
- [x] No brand machine names
- [x] No scarcity language ("จำกัด" · "เหลือ" · "หมดเขต")
- [x] No discount language ("ลด" · "ปกติ" · strikethrough)
- [x] No forbidden words (หายขาด · การันตี · 100% · อันดับ 1 · ที่สุด · ครั้งเดียวจบ)
- [x] No before/after photos
- [x] No body parts / face / silhouette
- [x] No founder face (text-only attribution per current preference)
- [x] Subcision shown as manual (when referenced) · no machine icon
- [x] Brand promise badge present
- [x] Location anchor (ราชเทวี · ใกล้ BTS)

---

## Before publish

- [ ] Overlay ว.61395 + ฉสพ. license number (when issued) · text-only footer
- [ ] Disclaimer overlay "ผลลัพธ์เฉพาะบุคคล" (สบส. requirement)
- [ ] Verify Thai spelling pixel-perfect on each output
- [ ] Real LINE QR overlay on ST04 (placeholder is blank white square)
- [ ] Resize to 1080×1080 for upload (Meta accepts up to 1200×1200 · 1080 is safe)

---

## Cross-reference

- 9:16 condo TV variants → `../condo-tv-loop-15s-9x16/`
- Reference diagram → `../assets/v3-diagram.png`
- Brand doctrine → `../../BRAND.md`
- Budget allocation → `../../BUDGET.md`
- Audience personas → `../../AUDIENCE.md`
- Phaya helper → `../../scripts/phaya-single-i2i.sh`
