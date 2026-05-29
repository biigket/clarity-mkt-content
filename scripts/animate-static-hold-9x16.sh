#!/usr/bin/env bash
# Animate the v3 static poster into a 15s 9:16 MP4 with subtle Ken Burns zoom
# For condo TV vertical screens · single-frame hold variant (no Phaya generation)
#
# Source:  ads/assets/v3-diagram.png  (9:16 source · 941×1672)
# Output:  ads/condo-tv-loop-15s-9x16/clarity-condo-static-15s.mp4  (1080×1920 H.264)
# Motion:  palindromic zoom 1.00→1.05→1.00 over 15s · seamless loop continuity
#
# Why palindromic: condo TV players loop the MP4 end→start. Ending at zoom=1.00
# (same as start) eliminates the visible "jump" at loop boundary.
#
# Usage:
#   bash scripts/animate-static-hold-9x16.sh
#   # or: make animate-static-9x16
#
# Requires: ffmpeg

set -euo pipefail

SRC="${SRC:-ads/assets/v3-diagram.png}"
OUT="${OUT:-ads/condo-tv-loop-15s-9x16/clarity-condo-static-15s.mp4}"
DURATION="${DURATION:-15}"
ZOOM_MAX="${ZOOM_MAX:-1.05}"   # 1.05 = 5% subtle · 1.08 = more visible

# ─── Preflight ─────────────────────────────────────────────
if [[ ! -f "$SRC" ]]; then
  echo "✗ Source not found: $SRC"
  exit 1
fi

if ! command -v ffmpeg &>/dev/null; then
  echo "✗ ffmpeg not installed"
  echo "  Mac:   brew install ffmpeg"
  echo "  Linux: sudo apt install ffmpeg"
  exit 1
fi

mkdir -p "$(dirname "$OUT")"

# zoompan uses on (output frame counter). Total frames = DURATION * 30
TOTAL_FRAMES=$((DURATION * 30))
HALF_FRAMES=$((TOTAL_FRAMES / 2))
ZOOM_DELTA=$(awk -v z="$ZOOM_MAX" 'BEGIN{print z-1}')

echo "Composing static-hold MP4 with Ken Burns zoom..."
echo "  Source:    $SRC"
echo "  Duration:  ${DURATION}s · ${TOTAL_FRAMES} frames @ 30fps"
echo "  Motion:    palindromic zoom 1.00 → ${ZOOM_MAX} → 1.00"
echo ""

# ─── Compose ───────────────────────────────────────────────
# Pipeline:
#   1. -loop 1 -i SRC          → repeat single image as continuous video stream
#   2. scale 2× to 2160×3840   → give zoompan headroom for crisp zoom
#   3. zoompan with sin curve  → palindromic zoom · seamless loop
#       z = 1 + ZOOM_DELTA * sin(π * on / TOTAL_FRAMES)
#       at on=0 → sin(0)=0 → z=1.00 (start)
#       at on=HALF → sin(π/2)=1 → z=ZOOM_MAX (midpoint)
#       at on=TOTAL → sin(π)=0 → z=1.00 (end = start ✓)
#   4. output 1080×1920 30fps · H.264 yuv420p · faststart

ffmpeg -y -loglevel error -stats \
  -loop 1 -i "$SRC" \
  -vf "scale=2160:3840:flags=lanczos,zoompan=z='1+${ZOOM_DELTA}*sin(PI*on/${TOTAL_FRAMES})':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=${TOTAL_FRAMES}:s=1080x1920:fps=30,format=yuv420p" \
  -c:v libx264 \
  -preset medium \
  -crf 20 \
  -pix_fmt yuv420p \
  -r 30 \
  -movflags +faststart \
  -t "$DURATION" \
  "$OUT"

# ─── Report ────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════"
echo "  ✓ Static-hold MP4 ready"
echo "═══════════════════════════════════════════"
echo "  File:     $OUT"
echo "  Duration: ${DURATION}s"
echo "  Format:   H.264 · 30fps · yuv420p · 1080×1920 (9:16)"
echo "  Motion:   palindromic zoom 1.00 → ${ZOOM_MAX} → 1.00 (seamless loop)"
echo "  Size:     $(du -h "$OUT" | cut -f1)"
echo ""
echo "Preview:"
echo "  open $OUT          # macOS"
echo "  xdg-open $OUT      # Linux"
echo ""
echo "Tuning (env vars):"
echo "  DURATION=20  bash scripts/animate-static-hold-9x16.sh   # longer hold"
echo "  ZOOM_MAX=1.08 bash scripts/animate-static-hold-9x16.sh  # more visible motion"
echo "  SRC=path/to/other.png OUT=path/to/output.mp4 bash ..."
echo ""
echo "Before publish:"
echo "  - Overlay ว.61395 + ฉสพ. license number (when issued)"
echo "  - Test on real vertical condo TV · 2-3m viewing distance"
