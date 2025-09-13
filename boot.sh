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
YAMATO_D_PATH="$YAMATO_PATH/yamato.d"

for libfile in "$YAMATO_PATH/lib/"*.sh; do
  [ -f "$libfile" ] && source "$libfile"
done

# Load boot functions
for bootfile in "$YAMATO_PATH/boot/"*.sh; do
  [ -f "$bootfile" ] && source "$bootfile"
done

# Run boot sequence
check_version
fetch_repo
init_config
run_install


echo ""
echo "========================================================"
echo ""
echo "🔄 Please log out and log back in to apply all changes."
echo ""
echo "👉 Shortcut: Command (⌘) + Shift (⇧) + Q"
echo ""
echo "========================================================"
echo ""
