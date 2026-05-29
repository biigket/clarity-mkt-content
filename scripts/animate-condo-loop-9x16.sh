#!/usr/bin/env bash
# Compose 3 vertical PNG cuts into a 15s seamless condo TV loop MP4 (9:16)
# Pair script of animate-condo-loop.sh (which targets 16:9)
#
# Usage:
#   bash scripts/animate-condo-loop-9x16.sh
#   # or: make animate-loop-9x16
#
# Requires:
#   - ffmpeg
#   - ads/condo-tv-loop-15s-9x16/clarity-condo-cut{1,2,3}.png (1152×2048 or any 9:16)

set -euo pipefail

CUTS_DIR="ads/condo-tv-loop-15s-9x16"
OUTPUT="$CUTS_DIR/clarity-condo-loop-15s-9x16.mp4"

# ─── Check inputs ──────────────────────────────────────────
for i in 1 2 3; do
  if [[ ! -f "$CUTS_DIR/clarity-condo-cut${i}.png" ]]; then
    echo "✗ Missing: $CUTS_DIR/clarity-condo-cut${i}.png"
    echo "→ Run: make generate-i2i-9x16"
    exit 1
  fi
done

if ! command -v ffmpeg &>/dev/null; then
  echo "✗ ffmpeg not installed"
  echo "  Mac:   brew install ffmpeg"
  echo "  Linux: sudo apt install ffmpeg"
  exit 1
fi

# ─── Compose ───────────────────────────────────────────────
# Timeline (same as 16:9 version):
#   0.0s ─ Cut 1 displayed
#   4.85s ─ Crossfade Cut 1 → Cut 2 (0.3s)
#   5.0s ─ Cut 2 displayed
#   9.7s ─ Crossfade Cut 2 → Cut 3 (0.3s)
#   10.0s ─ Cut 3 displayed
#   14.85s ─ Crossfade Cut 3 → Cut 1 (0.3s · for loop continuity)
#   15.0s ─ End
#
# Output: 1080×1920 (vertical 9:16 · standard FullHD portrait)

echo "Composing 3 vertical cuts → 15s loop (9:16)..."

ffmpeg -y -loglevel error -stats \
  -loop 1 -t 5.15 -i "$CUTS_DIR/clarity-condo-cut1.png" \
  -loop 1 -t 5.15 -i "$CUTS_DIR/clarity-condo-cut2.png" \
  -loop 1 -t 5.30 -i "$CUTS_DIR/clarity-condo-cut3.png" \
  -filter_complex "
    [0:v]format=yuv420p,fps=30,scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2:color=black[v0];
    [1:v]format=yuv420p,fps=30,scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2:color=black[v1];
    [2:v]format=yuv420p,fps=30,scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2:color=black[v2];
    [v0][v1]xfade=transition=fade:duration=0.3:offset=4.85[vf01];
    [vf01][v2]xfade=transition=fade:duration=0.3:offset=9.7[vfinal]
  " \
  -map "[vfinal]" \
  -c:v libx264 \
  -preset medium \
  -crf 20 \
  -pix_fmt yuv420p \
  -r 30 \
  -movflags +faststart \
  -t 15 \
  "$OUTPUT"

echo ""
echo "═══════════════════════════════════════════"
echo "  ✓ Output ready (9:16 vertical)"
echo "═══════════════════════════════════════════"
echo "  File:     $OUTPUT"
echo "  Duration: 15s"
echo "  Codec:    H.264 · 30fps · yuv420p"
echo "  Size:     $(du -h "$OUTPUT" | cut -f1)"
echo ""
echo "Preview:"
echo "  open $OUTPUT          # macOS"
echo "  xdg-open $OUTPUT      # Linux"
echo ""
echo "Next steps:"
echo "  - Overlay LINE QR on Cut 3 PNG · then re-animate · OR"
echo "  - Edit MP4 in CapCut/Premiere for QR overlay · OR"
echo "  - Add ฉสพ. license number overlay before publishing"
