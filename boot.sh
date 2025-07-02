#!/bin/bash
set -euo pipefail

ascii_art='
 ___ ___   _______   _______   _______   _______   _______
|   |   | |   _   | |   |   | |   _   | |_     _| |       |
 \     /  |       | |       | |       |   |   |   |   -   |
  |___|   |___|___| |__|_|__| |___|___|   |___|   |_______|
'
echo "$ascii_art"

if [ -d "$HOME/.local/share/yamato/.git" ]; then
  git -C "$HOME/.local/share/yamato" pull --ff-only >/dev/null 2>&1
else
  git clone https://github.com/politive/yamato.git "$HOME/.local/share/yamato" >/dev/null 2>&1
fi

YAMATO_PATH="$HOME/.local/share/yamato"
OVERRIDES_PATH="$YAMATO_PATH/overrides"

YAMATO_D_PATH="$YAMATO_PATH/yamato.d"
OVERRIDES_D_PATH="$OVERRIDES_PATH/yamato.d"

for libfile in "$YAMATO_PATH/lib/"*.sh; do
  [ -f "$libfile" ] && source "$libfile"
done

CACHE_PATH="$YAMATO_PATH/.cache"
mkdir -p "$CACHE_PATH"
MERGED_YAML="$CACHE_PATH/yamato.yaml"

if [ -f "$YAMATO_PATH/yamato.overrides.yaml" ]; then
  merge_yaml "$YAMATO_PATH/yamato.yaml" "$YAMATO_PATH/yamato.overrides.yaml" "$MERGED_YAML"
else
  cp "$YAMATO_PATH/yamato.yaml" "$MERGED_YAML"
fi

log_section "Installation starting..."
source "$YAMATO_PATH/install.sh"

echo ""
echo "========================================================"
echo ""
echo "🔄 Please log out and log back in to apply all changes."
echo ""
echo "👉 Shortcut: Command (⌘) + Shift (⇧) + Q"
echo ""
echo "========================================================"
echo ""
