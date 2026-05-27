#!/usr/bin/env bash
# Upload a local image to Imgur (anonymous) and print the public URL
# Useful for hosting i2i reference images
#
# Usage:
#   bash scripts/upload-to-imgur.sh path/to/image.png
#   # or: make upload-ref IMG=path/to/image.png
#
# Requires:
#   - IMGUR_CLIENT_ID env var (free at https://api.imgur.com/oauth2/addclient)
#   - curl · jq

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <path/to/image.png>"
  echo ""
  echo "Setup IMGUR_CLIENT_ID:"
  echo "  1. Visit https://api.imgur.com/oauth2/addclient"
  echo "  2. Choose 'Anonymous usage without user authorization'"
  echo "  3. Submit form (no callback URL needed)"
  echo "  4. Copy 'Client ID' → add to .env: IMGUR_CLIENT_ID=..."
  exit 1
fi

IMG="$1"

if [[ ! -f "$IMG" ]]; then
  echo "✗ File not found: $IMG"
  exit 1
fi

if [[ -z "${IMGUR_CLIENT_ID:-}" ]]; then
  echo "✗ IMGUR_CLIENT_ID not set"
  echo ""
  echo "Get one free at: https://api.imgur.com/oauth2/addclient"
  echo "Select 'Anonymous usage without user authorization'"
  echo "Then add to .env:  IMGUR_CLIENT_ID='your_id'"
  echo "Source it:  source .env"
  exit 1
fi

# File size check (Imgur limit: 10MB free / 20MB pro · Phaya limit: 30MB)
SIZE=$(stat -f%z "$IMG" 2>/dev/null || stat -c%s "$IMG")
SIZE_MB=$((SIZE / 1024 / 1024))
if [[ $SIZE_MB -gt 10 ]]; then
  echo "⚠ Image is ${SIZE_MB}MB · Imgur free tier limit is 10MB"
  echo "  Consider GitHub raw alternative for larger files"
fi

echo "Uploading $IMG (${SIZE_MB}MB) to Imgur..."

response=$(curl -sS -X POST "https://api.imgur.com/3/image" \
  -H "Authorization: Client-ID $IMGUR_CLIENT_ID" \
  -F "image=@$IMG" \
  -F "type=file")

success=$(echo "$response" | jq -r '.success // false')

if [[ "$success" != "true" ]]; then
  echo "✗ Upload failed:"
  echo "$response" | jq .
  exit 1
fi

url=$(echo "$response" | jq -r '.data.link')
delete_hash=$(echo "$response" | jq -r '.data.deletehash')

echo ""
echo "═══════════════════════════════════════════"
echo "  ✓ Uploaded"
echo "═══════════════════════════════════════════"
echo "  URL:    $url"
echo ""
echo "Use as i2i reference:"
echo "  export REFERENCE_URL='$url'"
echo ""
echo "Or add to .env:"
echo "  REFERENCE_URL=$url"
echo ""
echo "Delete later (if needed):"
echo "  curl -X DELETE https://api.imgur.com/3/image/$delete_hash -H \"Authorization: Client-ID \$IMGUR_CLIENT_ID\""
