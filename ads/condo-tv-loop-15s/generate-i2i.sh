#!/usr/bin/env bash
# Generate 3 Clarity Condo TV Silent Loop frames via Phaya GPT Image 2 IMAGE-TO-IMAGE
#
# Usage:
#   export PHAYA_API_KEY="pk_xxx"
#   export REFERENCE_URL="https://your-host/v3-diagram.png"
#   cd ads/condo-tv-loop-15s/
#   ./generate-i2i.sh
#
# Output:
#   clarity-condo-cut1.png · cut2.png · cut3.png (16:9 · 2K)
#
# Reference image hosting options:
#   1. Commit v3 diagram to repo · use raw.githubusercontent.com URL
#   2. Upload to Imgur · get direct link
#   3. Upload to S3/Cloudinary/any public host
#
# Constraints (per Phaya docs):
#   - input_urls: 1-5 URLs · JPEG/PNG/WEBP · ≤30MB each
#   - aspect_ratio="auto" works only with resolution="1K"
#   - aspect_ratio="1:1" does NOT support resolution="4K"

set -euo pipefail

# ─── Config ────────────────────────────────────────────────
API_KEY="${PHAYA_API_KEY:-}"
REFERENCE_URL="${REFERENCE_URL:-}"
API_BASE="https://api.phaya.io/api/v1"
ASPECT_RATIO="16:9"
RESOLUTION="2K"             # 1K · 2K · 4K
POLL_INTERVAL=3
MAX_ATTEMPTS=80             # 80 × 3s = 4 minutes max
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── Preflight ─────────────────────────────────────────────
if [[ -z "$API_KEY" ]]; then
  echo "ERROR: set PHAYA_API_KEY env var first"
  echo "  export PHAYA_API_KEY='pk_xxx'"
  exit 1
fi

if [[ -z "$REFERENCE_URL" ]]; then
  echo "ERROR: set REFERENCE_URL env var (public URL to source image)"
  echo ""
  echo "Examples:"
  echo "  export REFERENCE_URL='https://raw.githubusercontent.com/biigket/clarity-mkt-content/main/ads/assets/v3-diagram.png'"
  echo "  export REFERENCE_URL='https://i.imgur.com/abc123.png'"
  exit 1
fi

if ! [[ "$REFERENCE_URL" =~ ^https?:// ]]; then
  echo "ERROR: REFERENCE_URL must start with http:// or https://"
  echo "  Got: $REFERENCE_URL"
  exit 1
fi

for cmd in curl jq; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "ERROR: '$cmd' not installed"
    exit 1
  fi
done

# ─── Generate one frame ────────────────────────────────────
generate_frame() {
  local name="$1"
  local prompt_file="$2"
  local output="$3"

  echo "═══════════════════════════════════════════"
  echo "  Generating: $name (i2i)"
  echo "═══════════════════════════════════════════"

  if [[ ! -f "$prompt_file" ]]; then
    echo "ERROR: prompt file not found: $prompt_file"
    return 1
  fi

  local prompt_content
  prompt_content=$(cat "$prompt_file")

  # Build JSON body using jq for proper escaping
  local body
  body=$(jq -n \
    --arg prompt "$prompt_content" \
    --arg url "$REFERENCE_URL" \
    --arg ar "$ASPECT_RATIO" \
    --arg res "$RESOLUTION" \
    '{prompt: $prompt, input_urls: [$url], aspect_ratio: $ar, resolution: $res}')

  # Submit create job
  local create_response
  create_response=$(curl -sS -X POST "$API_BASE/gpt-image-2-image-to-image/create" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "$body")

  local job_id
  job_id=$(echo "$create_response" | jq -r '.job_id // empty')

  if [[ -z "$job_id" ]]; then
    echo "ERROR submitting job:"
    echo "$create_response" | jq .
    return 1
  fi

  local credits
  credits=$(echo "$create_response" | jq -r '.credits_used // "?"')
  echo "✓ Job submitted: $job_id  (credits: $credits)"

  # Poll status
  local attempt=0
  while [[ $attempt -lt $MAX_ATTEMPTS ]]; do
    sleep "$POLL_INTERVAL"
    local status_response
    status_response=$(curl -sS "$API_BASE/gpt-image-2-image-to-image/status/$job_id" \
      -H "Authorization: Bearer $API_KEY")

    local status
    status=$(echo "$status_response" | jq -r '.status // "unknown"')

    case "$status" in
      completed)
        local image_url
        image_url=$(echo "$status_response" | jq -r '.image_url')
        local ms
        ms=$(echo "$status_response" | jq -r '.processing_time_ms // 0')
        echo "✓ Completed in ${ms}ms"
        echo "  Downloading → $output"
        curl -sS "$image_url" -o "$output"
        echo "✓ Saved: $output"
        return 0
        ;;
      failed)
        echo "✗ Generation failed:"
        echo "$status_response" | jq .
        return 1
        ;;
      processing)
        printf "  [%2d/%d] processing...\r" "$((attempt+1))" "$MAX_ATTEMPTS"
        ;;
      *)
        echo "✗ Unknown status: $status"
        echo "$status_response" | jq .
        return 1
        ;;
    esac
    attempt=$((attempt+1))
  done

  echo "✗ Timeout after $((MAX_ATTEMPTS * POLL_INTERVAL))s"
  return 1
}

# ─── Run 3 cuts ────────────────────────────────────────────
cd "$SCRIPT_DIR"

echo ""
echo "Reference image: $REFERENCE_URL"
echo "Aspect ratio:    $ASPECT_RATIO"
echo "Resolution:      $RESOLUTION"
echo ""

generate_frame "Cut 1 · Education (diagram + headline)" \
  prompts/cut1-i2i.txt clarity-condo-cut1.png

generate_frame "Cut 2 · Price + Brand promise" \
  prompts/cut2-i2i.txt clarity-condo-cut2.png

generate_frame "Cut 3 · Location + QR + CTA" \
  prompts/cut3-i2i.txt clarity-condo-cut3.png

echo ""
echo "═══════════════════════════════════════════"
echo "  ✓ Done · 3 i2i cuts ready"
echo "═══════════════════════════════════════════"
echo ""
echo "Files:"
ls -la clarity-condo-cut*.png 2>/dev/null
echo ""
echo "Next steps:"
echo "  1. Review PNG outputs · regenerate cuts if needed"
echo "  2. Overlay real LINE QR on cut3"
echo "  3. Animate in CapCut/Premiere · 5s per cut · crossfade · loop"
echo "  4. Add ฉสพ. license number · export final 15s MP4"
