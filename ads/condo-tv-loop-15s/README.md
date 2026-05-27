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
| `generate.sh` | **Text-to-Image** · async script · no reference image needed |
| `generate-i2i.sh` | **Image-to-Image** · uses v3 diagram as reference (preserves brand visual) |
| `prompts/cut1.txt` | Cut 1 t2i · detailed full description with diagram |
| `prompts/cut2.txt` | Cut 2 t2i · price + brand promise badge |
| `prompts/cut3.txt` | Cut 3 t2i · location + QR + LINE @clarityclinic |
| `prompts/cut1-i2i.txt` | Cut 1 i2i · reformat ref diagram into 16:9 |
| `prompts/cut2-i2i.txt` | Cut 2 i2i · style guide only, no diagram in frame |
| `prompts/cut3-i2i.txt` | Cut 3 i2i · style guide only, no diagram in frame |

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

### 3. Pick mode · t2i or i2i

#### Mode A · Text-to-Image (no reference)

Quick · designed entirely from prompt · ไม่ต้อง host รูป

```bash
cd ads/condo-tv-loop-15s/
./generate.sh
```

#### Mode B · Image-to-Image (uses v3 diagram as reference) ⭐ recommended for brand consistency

Better brand match · uses your existing v3 diagram poster as style ref

```bash
# 1. Host the v3 diagram somewhere public (see "Hosting reference image" below)
export REFERENCE_URL="https://raw.githubusercontent.com/biigket/clarity-mkt-content/main/ads/assets/v3-diagram.png"

# 2. Run i2i script
cd ads/condo-tv-loop-15s/
./generate-i2i.sh
```

### Expected output (either mode)

- `clarity-condo-cut1.png` (16:9 · 2K)
- `clarity-condo-cut2.png`
- `clarity-condo-cut3.png`
- Each cut takes ~5-15s to process
- Total credits used: ~3 (1 per cut · depends on Phaya pricing)

---

## Hosting reference image (for i2i mode)

Phaya i2i needs `input_urls` (public URL · not file upload). Options:

### Option 1 · GitHub Raw (recommended · reproducible)

```bash
# 1. Save v3 diagram PNG locally
# 2. Move into repo
mv ~/Downloads/clarity-v3-diagram.png ads/assets/v3-diagram.png
git add ads/assets/v3-diagram.png
git commit -m "Add v3 diagram as i2i reference"
git push origin main

# 3. Use raw URL
export REFERENCE_URL="https://raw.githubusercontent.com/biigket/clarity-mkt-content/main/ads/assets/v3-diagram.png"
```

### Option 2 · Imgur (no commit · temporary)

1. Drag PNG to https://imgur.com
2. Right-click uploaded image → "Copy image address"
3. Use that URL:
```bash
export REFERENCE_URL="https://i.imgur.com/xxxxx.png"
```

### Option 3 · Cloudinary / S3 / any CDN

Any public HTTPS URL that returns a PNG/JPEG/WEBP works. Limit: ≤30MB per image, max 5 URLs.

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

### Endpoint A · Text-to-Image (async)

```bash
# Submit
POST https://api.phaya.io/api/v1/gpt-image-2-text-to-image/create
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "prompt": "...",
  "aspect_ratio": "16:9",
  "resolution": "2K"
}

# Poll
GET https://api.phaya.io/api/v1/gpt-image-2-text-to-image/status/{job_id}
```

### Endpoint B · Image-to-Image (async)

```bash
# Submit · requires input_urls
POST https://api.phaya.io/api/v1/gpt-image-2-image-to-image/create
Authorization: Bearer YOUR_API_KEY
Content-Type: application/json

{
  "prompt": "...",
  "input_urls": ["https://.../source.png"],
  "aspect_ratio": "16:9",
  "resolution": "2K"
}

# Poll
GET https://api.phaya.io/api/v1/gpt-image-2-image-to-image/status/{job_id}
```

### Common params

- `aspect_ratio` (string): `auto` · `1:1` · `5:4` · `9:16` · `21:9` · `16:9` · `4:3` · `3:2` · `4:5` · `3:4` · `2:3`
- `resolution` (string): `1K` · `2K` · `4K`
- `input_urls` (i2i only): array of 1-5 URLs · JPEG/PNG/WEBP · ≤30MB each

### Constraints

- `aspect_ratio="auto"` ใช้ได้เฉพาะ `resolution="1K"` เท่านั้น
- `aspect_ratio="1:1"` ไม่รองรับ `resolution="4K"`

### Response (submit)

```json
{
  "job_id": "f1c2...",
  "task_id": "281e...",
  "status": "processing",
  "credits_used": 1.0
}
```

### Response (status · completed)

```json
{
  "status": "completed",
  "image_url": "https://bvlk....supabase.co/.../...png",
  "processing_time_ms": 4820
}
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
