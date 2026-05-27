#!/bin/bash
# Setup script for code.claude.com environment
# Paste this into Environment Settings → Setup Script
#
# Required env vars:
#   GOOGLE_CREDENTIALS_B64 — base64-encoded Google service account JSON
#
# Generate b64 locally:
#   base64 -w 0 < /path/to/creds.json    # Linux
#   base64 -i /path/to/creds.json        # Mac

set -e

echo "🔧 Setting up MCP environment..."

# 1. Install uv (Python package manager for uvx command)
if ! command -v uvx &> /dev/null; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# 2. Restore Google credentials from base64 env var
mkdir -p "$HOME/.secrets"
if [ -n "$GOOGLE_CREDENTIALS_B64" ]; then
  echo "Restoring Google credentials..."
  # Use printf to avoid trailing newline that breaks base64 decode
  printf '%s' "$GOOGLE_CREDENTIALS_B64" | base64 -d > "$HOME/.secrets/google-creds.json"
  chmod 600 "$HOME/.secrets/google-creds.json"

  # Verify file is non-empty
  if [ ! -s "$HOME/.secrets/google-creds.json" ]; then
    echo "❌ Credentials file is empty after decode"
    exit 1
  fi

  # Verify valid JSON
  python3 -c "import json; json.load(open('$HOME/.secrets/google-creds.json'))" 2>/dev/null || {
    echo "❌ Credentials JSON invalid"
    exit 1
  }

  SIZE=$(wc -c < "$HOME/.secrets/google-creds.json")
  echo "✅ Credentials restored ($SIZE bytes)"
else
  echo "⚠️  GOOGLE_CREDENTIALS_B64 not set — Google Sheets MCP will fail"
  exit 1
fi

# 3. Pre-cache mcp-google-sheets (faster first call)
echo "Pre-caching mcp-google-sheets..."
uvx mcp-google-sheets@latest --help > /dev/null 2>&1 || true

echo "✅ MCP environment ready"
