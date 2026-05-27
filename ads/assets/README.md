# Reference Assets

Static images used as **i2i references** for content generation.

## Convention

Keep filenames stable · they're hardcoded into `.env` `REFERENCE_URL` paths.

| File | Use |
|------|-----|
| `v3-diagram.png` | Skin cross-section diagram poster · used by condo TV loop i2i + future variants |

## Add new reference

1. Save image (PNG/JPEG/WEBP · ≤30MB)
2. Place in this folder
3. Commit + push
4. URL becomes: `https://raw.githubusercontent.com/biigket/clarity-mkt-content/main/ads/assets/FILENAME`

## When to use ads/assets/ vs Imgur

| | ads/assets/ | Imgur (`make upload-ref`) |
|---|------------|---------------------------|
| Permanent · brand asset | ✅ here | ❌ |
| Quick one-off test | ❌ | ✅ |
| Version controlled | ✅ | ❌ |
| Need URL right now | requires git push | ✅ |
| Cost | free | free |

For brand-critical references (logos · approved variants) · use this folder.
For experimental/throwaway · use Imgur.
