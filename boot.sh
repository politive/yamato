#!/bin/bash
set -euo pipefail

ascii_art='
 ___ ___   _______   _______   _______   _______   _______
|   |   | |   _   | |   |   | |   _   | |_     _| |       |
 \     /  |       | |       | |       |   |   |   |   -   |
  |___|   |___|___| |__|_|__| |___|___|   |___|   |_______|
'
echo "$ascii_art"

YAMATO_PATH="$HOME/.local/share/yamato"
USER_PATH="$YAMATO_PATH/user"
YAMATO_D_PATH="$YAMATO_PATH/yamato.d"
USER_D_PATH="$USER_PATH/yamato.d"

for libfile in "$YAMATO_PATH/lib/"*.sh; do
  [ -f "$libfile" ] && source "$libfile"
done

log_section "Fetch or Clone Source Code"
if [ -d "$HOME/.local/share/yamato/.git" ]; then
  if [ "$SKIP_PULL" -eq 0 ]; then
    git -C "$HOME/.local/share/yamato" pull --ff-only >/dev/null 2>&1
    log_applied "yamato"
  else
    log_skipped "git pull"
  fi
else
  git clone https://github.com/politive/yamato.git "$HOME/.local/share/yamato" >/dev/null 2>&1
  log_installed "yamato"
fi

CACHE_PATH="$YAMATO_PATH/.cache"
mkdir -p "$CACHE_PATH"
PRESET_FILE="$CACHE_PATH/yamato.yaml"

if [ -f "$YAMATO_PATH/user/yamato.yaml" ]; then
  cp "$YAMATO_PATH/user/yamato.yaml" "$CACHE_PATH/yamato.yaml"
else
  cp "$YAMATO_PATH/yamato.yaml" "$CACHE_PATH/yamato.yaml"
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
