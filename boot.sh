#!/bin/bash
set -euo pipefail

ascii_art='
_____.___.                      __
\__  |   |____    _____ _____ _/  |_  ____
 /   |   \__  \  /     \\__  \\   __\/  _ \
 \____   |/ __ \|  Y Y  \/ __ \|  | (  <_> )
 / ______(____  /__|_|  (____  /__|  \____/
 \/           \/      \/     \/
'
echo -e "$ascii_art"
echo ""

echo "Cloning Yamato..."
rm -rf $HOME/.local/share/yamato
git clone https://github.com/politive/yamato.git $HOME/.local/share/yamato >/dev/null 2>&1

YAMATO_PATH="$HOME/.local/share/yamato"

echo "Loading library: log"
source "$YAMATO_PATH/lib/log.sh"

echo "Loading library: args"
source "$YAMATO_PATH/lib/args.sh" "$@"

echo "Loading library: run"
source "$YAMATO_PATH/lib/run.sh"

echo "Installation starting..."
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
