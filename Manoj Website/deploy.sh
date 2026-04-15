#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
#  Manoj Kumar Portfolio — Zoho Catalyst deploy helper
#  Usage:  bash deploy.sh
# ─────────────────────────────────────────────────────────────
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLIENT_DIR="$SCRIPT_DIR/client/manoj-portfolio/app"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   Manoj Kumar Portfolio — Catalyst Deploy  ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# ── 1. Check Catalyst CLI ────────────────────────────────────
if ! command -v catalyst &>/dev/null; then
  echo "⏳  Catalyst CLI not found. Installing..."
  npm install -g zcatalyst-cli
  echo "✅  Catalyst CLI installed."
else
  echo "✅  Catalyst CLI found: $(catalyst --version 2>/dev/null || echo 'installed')"
fi

# ── 2. Check catalyst.json is configured ─────────────────────
if grep -q "YOUR_PROJECT_ID" "$SCRIPT_DIR/catalyst.json"; then
  echo ""
  echo "⚠️  catalyst.json still has placeholder values."
  echo ""
  echo "   Please:"
  echo "   1. Go to https://catalyst.zoho.com"
  echo "   2. Create / open your project"
  echo "   3. Copy Project ID & Project Key from Settings → Project Details"
  echo "   4. Edit catalyst.json and replace YOUR_PROJECT_ID and YOUR_PROJECT_KEY"
  echo "   5. Re-run:  bash deploy.sh"
  echo ""
  exit 1
fi

# ── 3. Sync static files into Catalyst client folder ─────────
echo ""
echo "📂  Syncing files to client folder..."
mkdir -p "$CLIENT_DIR"
cp "$SCRIPT_DIR/index.html" "$CLIENT_DIR/index.html"

# Copy Images folder (contains the PDF CV)
if [ -d "$SCRIPT_DIR/Images" ]; then
  cp -r "$SCRIPT_DIR/Images" "$CLIENT_DIR/"
  echo "   ✓ Images/"
fi

# Copy assets folder (SVG icons, placeholders)
if [ -d "$SCRIPT_DIR/assets" ]; then
  cp -r "$SCRIPT_DIR/assets" "$CLIENT_DIR/"
  echo "   ✓ assets/"
fi

echo "   ✓ index.html"
echo "✅  Files synced to: $CLIENT_DIR"

# ── 4. Login check ───────────────────────────────────────────
echo ""
echo "🔐  Checking Catalyst login..."
if ! catalyst whoami &>/dev/null 2>&1; then
  echo "   Not logged in. Opening browser for login..."
  catalyst login
fi
echo "✅  Logged in."

# ── 5. Deploy ────────────────────────────────────────────────
echo ""
echo "🚀  Deploying to Zoho Catalyst..."
cd "$SCRIPT_DIR"
catalyst deploy --only web_client

echo ""
echo "🎉  Done! Your site is live."
echo "    URL: https://$(node -e "const c=require('./catalyst.json');console.log(c.projectName+'-'+c.projectId+'.catalystapps.com')" 2>/dev/null || echo '<project>-<id>.catalystapps.com')"
echo ""
