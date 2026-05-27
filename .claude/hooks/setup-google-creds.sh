#!/usr/bin/env bash
# Decodes $GOOGLE_CREDENTIALS_B64 into ~/.secrets/google-creds.json so the
# Google Sheets MCP server can authenticate. Runs on every SessionStart.
set -euo pipefail

CREDS_PATH="${HOME}/.secrets/google-creds.json"

if [[ -z "${GOOGLE_CREDENTIALS_B64:-}" ]]; then
  echo "setup-google-creds: GOOGLE_CREDENTIALS_B64 not set; skipping" >&2
  exit 0
fi

mkdir -p "$(dirname "$CREDS_PATH")"
printf '%s' "$GOOGLE_CREDENTIALS_B64" | base64 -d > "$CREDS_PATH"
chmod 600 "$CREDS_PATH"

if ! python3 -c "import json,sys; json.load(open('$CREDS_PATH'))" 2>/dev/null; then
  echo "setup-google-creds: decoded file is not valid JSON" >&2
  exit 1
fi

echo "setup-google-creds: wrote $CREDS_PATH"
