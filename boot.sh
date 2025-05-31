#!/bin/bash
set -euo pipefail

ascii_art='
 ___ ___   _______   _______   _______   _______   _______
|   |   | |   _   | |   |   | |   _   | |_     _| |       |
 \     /  |       | |       | |       |   |   |   |   -   |
  |___|   |___|___| |__|_|__| |___|___|   |___|   |_______|
'
echo -e "$ascii_art"

if [ -d "$HOME/.local/share/yamato/.git" ]; then
  git -C "$HOME/.local/share/yamato" pull --ff-only >/dev/null 2>&1
else
  git clone https://github.com/politive/yamato.git "$HOME/.local/share/yamato" >/dev/null 2>&1
fi

YAMATO_PATH="$HOME/.local/share/yamato"
source "$YAMATO_PATH/lib/log.sh"

log_section "Loading library: args"
source "$YAMATO_PATH/lib/args.sh" "$@"

log_section "Loading library: run"
source "$YAMATO_PATH/lib/run.sh"

log_section "Installation starting..."
source $YAMATO_PATH/install.sh

echo ""
echo "========================================================"
echo ""
echo "🔄 Please log out and log back in to apply all changes."
echo ""
echo "👉 Shortcut: Command (⌘) + Shift (⇧) + Q"
echo ""
echo "========================================================"
echo ""
