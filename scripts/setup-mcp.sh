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
if [ -n "$GOOGLE_CREDENTIALS_B64" ]; then
  echo "Restoring Google credentials..."
  mkdir -p "$HOME/.secrets"
  echo "$GOOGLE_CREDENTIALS_B64" | base64 -d > "$HOME/.secrets/google-creds.json"
  chmod 600 "$HOME/.secrets/google-creds.json"
  echo "✅ Credentials written to $HOME/.secrets/google-creds.json"
else
  echo "⚠️  GOOGLE_CREDENTIALS_B64 not set — Google Sheets MCP will fail"
fi

# 3. Pre-cache mcp-google-sheets (faster first call)
echo "Pre-caching mcp-google-sheets..."
uvx mcp-google-sheets@latest --help > /dev/null 2>&1 || true

echo "✅ MCP environment ready"
