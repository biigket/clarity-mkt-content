# Local Setup · Claude Code

ใช้ Claude Code local แทน cloud · unlocks:
- ✅ Direct Phaya API calls (cloud sandbox blocks api.phaya.io)
- ✅ File system access to generated images
- ✅ ffmpeg automation (animate · convert)
- ✅ Real-time iteration · no push/pull cycles
- ✅ Run any CLI tool

---

## One-time setup

### 1. Install Claude Code

```bash
# macOS / Linux
brew install --cask claude-code

# Or via npm (cross-platform)
npm install -g @anthropic-ai/claude-code

# Login (one-time)
claude login
```

Docs: https://docs.claude.com/en/docs/claude-code

### 2. Install CLI tools

```bash
# macOS
brew install curl jq ffmpeg

# Linux (Debian/Ubuntu)
sudo apt update && sudo apt install -y curl jq ffmpeg

# Verify
make check-env
```

### 3. Clone repo

```bash
git clone https://github.com/biigket/clarity-mkt-content.git
cd clarity-mkt-content
```

### 4. Set up env vars

```bash
make setup           # copies .env.example → .env
$EDITOR .env         # fill in your API keys
source .env          # load into current shell
make check-env       # verify
```

**Required:**
- `PHAYA_API_KEY` — get from https://phaya.io/dashboard

**Optional (recommended):**
- `REFERENCE_URL` — for i2i generation (host your v3 diagram first · see below)
- `IMGUR_CLIENT_ID` — for quick image hosting (`make upload-ref`)
- `ELEVENLABS_API_KEY` — for TTS voiceover generation

### 5. Auto-source on cd (optional)

If you want env vars loaded automatically when you `cd` into the project, add this to `~/.zshrc` or `~/.bashrc`:

```bash
# Auto-source .env when entering clarity-mkt-content
chpwd() {
  if [[ -f .env ]]; then
    set -a; source .env; set +a
  fi
}
```

Or use a tool like `direnv` for per-directory env loading.

---

## Common workflows

### Generate condo TV silent loop (i2i mode · recommended)

```bash
# 1. Host your v3 diagram (one-time)
# Option A · GitHub raw (reproducible)
mkdir -p ads/assets
cp ~/Downloads/clarity-v3-diagram.png ads/assets/v3-diagram.png
git add ads/assets/v3-diagram.png
git commit -m "Add v3 diagram reference"
git push

# Then in .env:
# REFERENCE_URL=https://raw.githubusercontent.com/biigket/clarity-mkt-content/main/ads/assets/v3-diagram.png

# Option B · Imgur (quick)
make upload-ref IMG=~/Downloads/clarity-v3-diagram.png
# → copy printed REFERENCE_URL into .env · source .env

# 2. Generate 3 cuts
source .env
make generate-i2i

# 3. Animate into 15s MP4
make animate-loop

# 4. Output ready
open ads/condo-tv-loop-15s/clarity-condo-loop-15s.mp4
```

### Generate from prompt only (t2i mode)

```bash
source .env
make generate-t2i
make animate-loop
```

### Working with Claude Code

```bash
cd ~/clarity-mkt-content
claude

# Inside claude session:
> Run i2i generation with my current REFERENCE_URL · then audit each cut
> Compose the 3 cuts into a 15s loop
> Update Cut 2 to use larger price font · regenerate
```

Claude will run scripts · read PNG outputs · audit them · iterate · all without context-switching.

### Iterate on a single cut

If only Cut 2 needs regeneration:

```bash
# Manual single-cut call
source .env
prompt=$(cat ads/condo-tv-loop-15s/prompts/cut2-i2i.txt | jq -Rs .)
body=$(jq -n --arg p "$(cat ads/condo-tv-loop-15s/prompts/cut2-i2i.txt)" \
              --arg u "$REFERENCE_URL" \
   '{prompt: $p, input_urls: [$u], aspect_ratio: "16:9", resolution: "2K"}')

curl -X POST https://api.phaya.io/api/v1/gpt-image-2-image-to-image/create \
  -H "Authorization: Bearer $PHAYA_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$body"
```

---

## Available Makefile targets

```bash
make help              # show all commands
make setup             # create .env from .env.example
make check-env         # verify tools + API keys
make upload-ref IMG=.. # upload image to Imgur
make generate-t2i      # text-to-image · 3 cuts
make generate-i2i      # image-to-image · 3 cuts (needs REFERENCE_URL)
make animate-loop      # compose 3 cuts → 15s MP4
make clean             # remove generated files
```

---

## Folder reference

```
clarity-mkt-content/
├── .env                          ← your secrets (gitignored)
├── .env.example                  ← template
├── Makefile                      ← workflow shortcuts
├── BRAND.md · AUDIENCE.md · etc  ← brand doctrine
├── ai-prompts/                   ← AI generation system
├── ads/
│   ├── assets/                   ← reference images (for i2i)
│   ├── condo-tv-loop-15s/
│   │   ├── generate.sh           ← t2i script
│   │   ├── generate-i2i.sh       ← i2i script
│   │   ├── prompts/              ← per-cut prompts
│   │   ├── clarity-condo-cut*.png ← generated frames
│   │   └── clarity-condo-loop-15s.mp4 ← final output
│   ├── scripts/AD01-06.md        ← ad scripts
│   ├── month-1-hook-bank.md      ← 50 hook variants
│   ├── static-poster-acne-scar-v3-diagram.md
│   ├── carousel-ig-acne-scar-skin-layers.md
│   └── video-reel-acne-scar-skin-layers.md
├── content/                      ← clip briefs (Pillar 1-4)
├── video-briefs/                 ← HeyGen briefs
├── scripts/                      ← utility scripts
│   ├── animate-condo-loop.sh
│   ├── upload-to-imgur.sh
│   └── setup-mcp.sh
└── docs/
    └── local-setup.md            ← this file
```

---

## Troubleshooting

### `make check-env` shows ✗ for ffmpeg

```bash
# macOS
brew install ffmpeg

# Linux
sudo apt install ffmpeg

# Verify
ffmpeg -version
```

### `Host not in allowlist` when calling Phaya

You're running in cloud mode (code.claude.com) · not local. Switch to local CLI:
```bash
cd ~/clarity-mkt-content
claude
```

### Phaya returns `failed` status

Common causes:
- Prompt too long (>20,000 chars) — shorten
- `input_urls` not accessible — test in browser first
- Invalid aspect_ratio + resolution combo (e.g. `auto` + `4K` not allowed)
- Out of credits — check phaya.io dashboard

### Generated text has Thai spelling errors

AI image generators often misspell Thai. Workarounds:
1. Regenerate · sometimes fixes itself
2. Composite text overlay in Canva/Photoshop
3. Use shorter Thai phrases · they get spelled more reliably

---

## Security

- 🔑 **Never commit `.env`** · already in `.gitignore`
- 🔄 **Rotate API keys regularly** at provider dashboards
- 🚫 **Don't share API keys in chat/Slack** · use env vars or secret managers
- 📋 **Audit generated content** before publishing · check brand compliance + legal/regulatory

---

## Cross-reference

- Brand doctrine → [`BRAND.md`](../BRAND.md)
- AI master prompt → [`ai-prompts/01-master-system.md`](../ai-prompts/01-master-system.md)
- Ad content cluster → [`ads/`](../ads/)
- Phaya API docs → https://phaya.io/docs
- Claude Code docs → https://docs.claude.com/en/docs/claude-code
