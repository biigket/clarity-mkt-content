#!/usr/bin/env bash
# Single-cut Phaya i2i helper (one prompt → one PNG)
# Used for ad-hoc angle variants without invoking the full 3-cut generator.
#
# Usage:
#   source .env
#   bash scripts/phaya-single-i2i.sh <prompt_file> <output_png> [aspect_ratio] [resolution]
#
# Defaults: aspect 9:16 · resolution 2K (matches condo TV vertical pipeline)
#
# Examples:
#   bash scripts/phaya-single-i2i.sh \
#     ads/condo-tv-loop-15s-9x16/prompts/transparency-i2i.txt \
#     ads/condo-tv-loop-15s-9x16/clarity-condo-transparency.png
#
#   bash scripts/phaya-single-i2i.sh prompts/x.txt out/x.png 16:9 4K

set -euo pipefail

PROMPT_FILE="${1:?Usage: $0 <prompt_file> <output_png> [aspect] [res]}"
OUTPUT="${2:?Usage: $0 <prompt_file> <output_png> [aspect] [res]}"
ASPECT="${3:-9:16}"
RES="${4:-2K}"

API_BASE="https://api.phaya.io/api/v1"
ENDPOINT="$API_BASE/gpt-image-2-image-to-image"

[[ -n "${PHAYA_API_KEY:-}" ]] || { echo "✗ PHAYA_API_KEY not set · run: source .env"; exit 1; }
[[ -n "${REFERENCE_URL:-}" ]] || { echo "✗ REFERENCE_URL not set · run: source .env"; exit 1; }
[[ -f "$PROMPT_FILE" ]] || { echo "✗ Prompt not found: $PROMPT_FILE"; exit 1; }

for cmd in curl jq; do
  command -v "$cmd" >/dev/null || { echo "✗ '$cmd' not installed"; exit 1; }
done

mkdir -p "$(dirname "$OUTPUT")"

echo "═══════════════════════════════════════════"
echo "  Phaya i2i · single cut"
echo "═══════════════════════════════════════════"
echo "  Prompt:   $PROMPT_FILE"
echo "  Output:   $OUTPUT"
echo "  Aspect:   $ASPECT · Resolution: $RES"
echo "  Ref:      $REFERENCE_URL"
echo ""

PROMPT=$(cat "$PROMPT_FILE")
BODY=$(jq -n \
  --arg p "$PROMPT" \
  --arg u "$REFERENCE_URL" \
  --arg ar "$ASPECT" \
  --arg res "$RES" \
  '{prompt:$p, input_urls:[$u], aspect_ratio:$ar, resolution:$res}')

RESP=$(curl -sS -X POST "$ENDPOINT/create" \
  -H "Authorization: Bearer $PHAYA_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$BODY")

JOB=$(echo "$RESP" | jq -r '.job_id // empty')
[[ -n "$JOB" ]] || { echo "✗ Submit failed:"; echo "$RESP" | jq .; exit 1; }

CREDITS=$(echo "$RESP" | jq -r '.credits_used // "?"')
echo "✓ Job submitted: $JOB  (credits: $CREDITS)"

for i in $(seq 1 80); do
  sleep 3
  S=$(curl -sS "$ENDPOINT/status/$JOB" -H "Authorization: Bearer $PHAYA_API_KEY")
  ST=$(echo "$S" | jq -r '.status // "unknown"')
  case "$ST" in
    completed)
      URL=$(echo "$S" | jq -r '.image_url')
      MS=$(echo "$S" | jq -r '.processing_time_ms // 0')
      echo ""
      echo "✓ Completed in ${MS}ms"
      curl -sS "$URL" -o "$OUTPUT"
      echo "✓ Saved: $OUTPUT"
      ls -lh "$OUTPUT"
      exit 0
      ;;
    failed)
      echo ""
      echo "✗ Generation failed:"
      echo "$S" | jq .
      exit 1
      ;;
    processing)
      printf "  [%2d/80] processing...\r" "$i"
      ;;
    *)
      echo ""
      echo "✗ Unknown status: $ST"
      echo "$S" | jq .
      exit 1
      ;;
  esac
done

echo ""
echo "✗ Timeout after 240s (80 × 3s)"
exit 1
