#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────
# sync-external.sh
# Sync external plugins → plugins/
# Sync external skills   → plugins/essentials/skills/
# ──────────────────────────────────────────────────────────
set -euo pipefail

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# ── Helpers ──────────────────────────────────────────────

copy_dir() {
  # copy_dir <src> <dest> [label]
  local src="$1"
  local dest="$2"
  local label="${3:-$(basename "$dest")}"
  if [ -d "$src" ]; then
    rm -rf "$dest"
    cp -r "$src" "$dest"
    echo "  ✓ ${label} synced"
  else
    echo "  ⚠ WARNING: source directory not found — ${src}"
  fi
}

clone_shallow() {
  # clone_shallow <repo-url> <dest-dir>
  local url="$1"
  local dest="$2"
  local name
  name=$(basename "$url" .git)
  echo ""
  echo "Cloning ${name} (shallow)..."
  git clone --depth 1 --quiet "$url" "$dest"
}

# ═══════════════════════════════════════════════════════════
# PLUGINS — sync to plugins/
# ═══════════════════════════════════════════════════════════
echo ""
echo "=== Syncing External Plugins ==="

# ── 1. anthropics/claude-plugins-official ──
#    → external_plugins/playwright
#    → plugins/skill-creator
clone_shallow "https://github.com/anthropics/claude-plugins-official.git" \
              "$TEMP_DIR/claude-plugins-official"

copy_dir "$TEMP_DIR/claude-plugins-official/external_plugins/playwright" \
         "plugins/playwright" \
         "playwright (plugin)"

copy_dir "$TEMP_DIR/claude-plugins-official/plugins/skill-creator" \
         "plugins/skill-creator" \
         "skill-creator (plugin)"

# ── 2. obra/superpowers ──
#    → entire repo, excluding .git and .github
clone_shallow "https://github.com/obra/superpowers.git" \
              "$TEMP_DIR/superpowers"

echo "  → Syncing superpowers plugin (excluding .git / .github)..."
rm -rf plugins/superpowers
mkdir -p plugins/superpowers
rsync -a --exclude='.git' --exclude='.github' \
  "$TEMP_DIR/superpowers/" plugins/superpowers/
echo "  ✓ superpowers synced"

# ── 3. alirezarezvani/claude-skills (finance) ──
clone_shallow "https://github.com/alirezarezvani/claude-skills.git" \
              "$TEMP_DIR/claude-skills"

copy_dir "$TEMP_DIR/claude-skills/finance" \
         "plugins/finance" \
         "finance (plugin)"

# ═══════════════════════════════════════════════════════════
# SKILLS — sync to plugins/essentials/skills/
# ═══════════════════════════════════════════════════════════
echo ""
echo "=== Syncing External Skills to essentials ==="

# ── 4. anthropics/skills (docx, pdf, pptx, xlsx) ──
clone_shallow "https://github.com/anthropics/skills.git" \
              "$TEMP_DIR/anthropics-skills"

mkdir -p plugins/essentials/skills

for skill in docx pdf pptx xlsx; do
  copy_dir "$TEMP_DIR/anthropics-skills/skills/${skill}" \
           "plugins/essentials/skills/${skill}" \
           "${skill} (skill)"
done

echo ""
echo "=== Sync finished ==="
