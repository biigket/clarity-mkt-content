# Clarity MKT Content · local workflow shortcuts
#
# Usage:
#   source .env && make <target>
#
# Or set the auto-source habit:
#   set -a; source .env; set +a

.PHONY: help check-env setup generate-t2i generate-i2i animate-loop upload-ref clean

# Default target
help:
	@echo "Clarity MKT Content · local workflow"
	@echo ""
	@echo "Setup:"
	@echo "  make setup            One-time · cp .env.example → .env"
	@echo "  make check-env        Verify env vars + tools installed"
	@echo ""
	@echo "Image hosting (for i2i):"
	@echo "  make upload-ref IMG=path/to/image.png    Upload to Imgur · prints REFERENCE_URL"
	@echo ""
	@echo "Generation (condo TV 15s loop):"
	@echo "  make generate-t2i     Text-to-image · no ref needed · 3 cuts"
	@echo "  make generate-i2i     Image-to-image · uses REFERENCE_URL · 3 cuts"
	@echo ""
	@echo "Post-production:"
	@echo "  make animate-loop     Compose 3 cuts → 15s MP4 (H.264 · 30fps)"
	@echo ""
	@echo "Cleanup:"
	@echo "  make clean            Remove generated PNG/MP4 files"
	@echo ""
	@echo "Files generated in: ads/condo-tv-loop-15s/"

# ─── Setup ───────────────────────────────────────────────────
setup:
	@if [ -f .env ]; then \
		echo "✗ .env already exists · backup first if you want to overwrite"; \
		exit 1; \
	fi
	@cp .env.example .env
	@echo "✓ Created .env from .env.example"
	@echo "→ Edit .env with your real API keys"
	@echo "→ Then: source .env && make check-env"

check-env:
	@command -v curl >/dev/null 2>&1 || (echo "✗ curl not installed" && exit 1)
	@command -v jq >/dev/null 2>&1 || (echo "✗ jq not installed · brew install jq" && exit 1)
	@command -v ffmpeg >/dev/null 2>&1 || (echo "✗ ffmpeg not installed · brew install ffmpeg" && exit 1)
	@test -n "$$PHAYA_API_KEY" || (echo "✗ PHAYA_API_KEY not set · source .env first" && exit 1)
	@echo "✓ curl · jq · ffmpeg installed"
	@echo "✓ PHAYA_API_KEY set"
	@test -n "$$REFERENCE_URL" && echo "✓ REFERENCE_URL set (i2i ready)" || echo "○ REFERENCE_URL not set (only t2i available)"
	@test -n "$$IMGUR_CLIENT_ID" && echo "✓ IMGUR_CLIENT_ID set (upload helper ready)" || echo "○ IMGUR_CLIENT_ID not set (optional)"

# ─── Image hosting ───────────────────────────────────────────
upload-ref:
	@test -n "$(IMG)" || (echo "Usage: make upload-ref IMG=path/to/image.png" && exit 1)
	@bash scripts/upload-to-imgur.sh "$(IMG)"

# ─── Generation ──────────────────────────────────────────────
generate-t2i: check-env
	@cd ads/condo-tv-loop-15s && ./generate.sh

generate-i2i: check-env
	@test -n "$$REFERENCE_URL" || (echo "✗ REFERENCE_URL not set · run: make upload-ref IMG=..." && exit 1)
	@cd ads/condo-tv-loop-15s && ./generate-i2i.sh

# ─── Animation ───────────────────────────────────────────────
animate-loop:
	@test -f ads/condo-tv-loop-15s/clarity-condo-cut1.png || (echo "✗ Run 'make generate-t2i' or 'make generate-i2i' first" && exit 1)
	@bash scripts/animate-condo-loop.sh

# ─── Cleanup ─────────────────────────────────────────────────
clean:
	@rm -f ads/condo-tv-loop-15s/clarity-condo-cut*.png
	@rm -f ads/condo-tv-loop-15s/clarity-condo-loop*.mp4
	@rm -f ads/condo-tv-loop-15s/*-output.json
	@echo "✓ Cleaned generated files in ads/condo-tv-loop-15s/"
