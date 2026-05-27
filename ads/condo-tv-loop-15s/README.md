# Condo TV Silent Loop · 15s · Acne Scar

> **Format:** 16:9 horizontal · 15s silent loop · 3 cuts × 5s each
> **Use case:** Condo lobby TV · gym screens · public area digital signage
> **Generation:** Phaya GPT Image 2 (text-to-image) → animate locally

---

## Concept

Static-to-static silent loop · no audio · text readable from 2-3 meter viewing distance · low-key animation between cuts (crossfade only)

```
0s ━━━━━━━━━━━ 5s ━━━━━━━━━━ 10s ━━━━━━━━━━ 15s
│  CUT 1       │  CUT 2       │  CUT 3       │
│  Education   │  Price       │  Location+CTA │
│  Diagram     │  Brand promise│  QR · hold   │
└──────────────┴──────────────┴──────────────┘
                                           ↺ loop
```

---

## Files in this directory

| File | Purpose |
|------|---------|
| `prompts/cut1.txt` | Cut 1 · Education + 4-layer diagram + headline "หลุมสิว มี 4 ชั้น" |
| `prompts/cut2.txt` | Cut 2 · Price 5,000 + brand promise badge |
| `prompts/cut3.txt` | Cut 3 · Location + QR + LINE @clarityclinic |
| `generate.sh` | Async script · submits 3 jobs to Phaya · polls · downloads |

---

## How to generate

### 1. Prerequisites

- `curl` · `jq` installed
- Phaya API key (get from https://phaya.io/dashboard)
- Local machine with network access to api.phaya.io (cloud sandbox blocks it)

### 2. Set API key

```bash
export PHAYA_API_KEY="pk_xxx"
```

> ⚠️ **Never commit** your API key. The `.gitignore` already covers common patterns.

### 3. Run

```bash
cd ads/condo-tv-loop-15s/
./generate.sh
```

Expected output:
- `clarity-condo-cut1.png` (16:9 · 2K)
- `clarity-condo-cut2.png`
- `clarity-condo-cut3.png`
- Each cut takes ~5-15s to process
- Total credits used: ~3 (1 per cut · depends on Phaya pricing)

### 4. Review & iterate

- Check PNG outputs
- If Thai text spelling is wrong (AI image gens often misspell Thai):
  - Re-run that cut · sometimes fixes itself
  - OR composite text overlay in Canva/Figma manually
- If diagram is wrong (Cut 1): regenerate or use the v3 diagram from `static-poster-acne-scar-v3-diagram.md` as crop

### 5. Add real LINE QR (Cut 3)

The prompt instructs ChatGPT to leave a white square placeholder.
Open `clarity-condo-cut3.png` in Photoshop/Canva → paste real LINE QR over the placeholder.

### 6. Animate

Import 3 PNGs into CapCut / Premiere / After Effects:
- 5 seconds per cut
- Crossfade transition 0.3-0.5s between cuts
- Loop seamlessly (Cut 3 → Cut 1)
- Export 1920×1080 H.264 MP4 · 30fps (most condo TV systems support this)

---

## Phaya API reference

### Endpoint (text-to-image · async)

```bash
# Submit job
POST https://api.phaya.io/api/v1/gpt-image-2-text-to-image/create
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "prompt": "...",
  "aspect_ratio": "16:9",   # auto · 1:1 · 5:4 · 9:16 · 21:9 · 16:9 · 4:3 · 3:2 · 4:5 · 3:4 · 2:3
  "resolution": "2K"        # 1K · 2K · 4K
}

→ returns: { "job_id": "...", "task_id": "...", "status": "processing", "credits_used": 1.0 }
```

```bash
# Poll status
GET https://api.phaya.io/api/v1/gpt-image-2-text-to-image/status/{job_id}
Authorization: Bearer YOUR_API_KEY

→ returns: { "status": "completed", "image_url": "https://.../...png", "processing_time_ms": 4820 }
```

Status values: `processing` · `completed` · `failed`

---

## Brand Compliance Checklist

- [x] Espresso/brown single palette (no sage green)
- [x] Bronze-gold accents only
- [x] No equipment device images / silhouettes
- [x] No brand machine names
- [x] No scarcity ("จำกัด" / "เหลือ" / "หมดเขต")
- [x] No discount language ("ลด" / "ปกติ" / strikethrough)
- [x] No forbidden words (หายขาด · การันตี · 100% · อันดับ 1 · ที่สุด · ครั้งเดียวจบ)
- [x] No before/after photos
- [x] No body parts (in diagram or anywhere)
- [x] Brand promise badge present (Cut 2)
- [x] LINE ID text + QR placeholder (Cut 3)
- [x] Location anchor (Cut 3)

---

## Compliance · กฎหมายโฆษณาสถานพยาบาล

ก่อน publish บน condo TV ต้องเช็ค:

1. **เลขใบอนุญาตโฆษณา (ฉสพ.)** ต้องอยู่บนรูป (font จิ๋ว · มุมซ้ายล่าง · OK)
2. **ขออนุญาตจาก สบส.** (กรมสนับสนุนบริการสุขภาพ) สำหรับโฆษณาสถานพยาบาล
3. **ราคา 5,000** ที่แสดง = ราคาจริงที่เก็บ (verify)
4. **Brand promise "ราคาเดียวตลอดปี"** ต้องจริง (ไม่ขัด)

→ ถ้ายังไม่มี ฉสพ. · เพิ่ม overlay เลขใบอนุญาตที่ post-production step

---

## Variants for future

- **9:16 vertical** · for lift door panels · use same prompts but `"aspect_ratio": "9:16"`
- **4K resolution** · for premium condo TV · use `"resolution": "4K"` (more credits)
- **5-cut loop** · expand to 25s for high-traffic areas · add "social proof" cut + "trust badges" cut
- **Sound-on variant** · use TTS script from `ads/video-15s-acne-scar-tts.md` (if created) for FB/IG ads version

---

## Cross-Reference

- Source diagram → `ads/static-poster-acne-scar-v3-diagram.md`
- Carousel variant → `ads/carousel-ig-acne-scar-skin-layers.md`
- Reel variant → `ads/video-reel-acne-scar-skin-layers.md`
- Brand doctrine → `BRAND.md`
- Phaya API docs → https://phaya.io/docs
