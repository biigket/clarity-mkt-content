#!/usr/bin/env bash
# Generate 3 Clarity Condo TV Silent Loop frames via Phaya GPT Image 2 (text-to-image)
#
# Usage:
#   export PHAYA_API_KEY="pk_xxx"
#   cd ads/condo-tv-loop-15s/
#   ./generate.sh
#
# Output:
#   clarity-condo-cut1.png · cut2.png · cut3.png (16:9 · 2K)
#
# Async pattern: POST create → poll GET status → download image_url

set -euo pipefail

# ─── Config ────────────────────────────────────────────────
API_KEY="${PHAYA_API_KEY:-}"
API_BASE="https://api.phaya.io/api/v1"
ASPECT_RATIO="16:9"
RESOLUTION="2K"             # options: 1K · 2K · 4K
POLL_INTERVAL=3             # seconds between status checks
MAX_ATTEMPTS=80             # 80 × 3s = 4 minutes max wait
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── Preflight ─────────────────────────────────────────────
if [[ -z "$API_KEY" ]]; then
  echo "ERROR: Set PHAYA_API_KEY env var first"
  echo "  export PHAYA_API_KEY='pk_xxx'"
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
  echo "  Generating: $name"
  echo "═══════════════════════════════════════════"

  if [[ ! -f "$prompt_file" ]]; then
    echo "ERROR: prompt file not found: $prompt_file"
    return 1
  fi

  # JSON-escape the prompt
  local prompt_json
  prompt_json=$(jq -Rs . < "$prompt_file")

  # Submit create job
  local create_response
  create_response=$(curl -sS -X POST "$API_BASE/gpt-image-2-text-to-image/create" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"prompt\": $prompt_json, \"aspect_ratio\": \"$ASPECT_RATIO\", \"resolution\": \"$RESOLUTION\"}")

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
    status_response=$(curl -sS "$API_BASE/gpt-image-2-text-to-image/status/$job_id" \
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

generate_frame "Cut 1 · Education (diagram + headline)" \
  prompts/cut1.txt clarity-condo-cut1.png

generate_frame "Cut 2 · Price + Brand promise" \
  prompts/cut2.txt clarity-condo-cut2.png

generate_frame "Cut 3 · Location + QR + CTA" \
  prompts/cut3.txt clarity-condo-cut3.png

echo ""
echo "═══════════════════════════════════════════"
echo "  ✓ Done · 3 cuts ready"
echo "═══════════════════════════════════════════"
echo ""
echo "Files:"
ls -la clarity-condo-cut*.png 2>/dev/null
echo ""
echo "Next steps:"
echo "  1. Review PNG outputs · regenerate cuts if needed"
echo "  2. Add LINE QR overlay to cut3 (use real QR code)"
echo "  3. Animate in CapCut/Premiere · 5s per cut · seamless loop"
echo "  4. Export final 15s MP4 · upload to condo screen system"
