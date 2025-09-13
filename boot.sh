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


log_section "Initialize Configuration"

# Update .gitignore for customization (unless dev mode)
if [ "$DEV_MODE" -eq 0 ] && [ -f "$YAMATO_PATH/.gitignore" ]; then
  sed -i '' 's/^yamato\.d\/$/# yamato.d\//; s/^yamato\.yaml$/# yamato.yaml/' "$YAMATO_PATH/.gitignore"
  log_applied "Updated .gitignore for customization"
elif [ "$DEV_MODE" -eq 1 ]; then
  log_skipped ".gitignore update (dev mode)"
else
  log_skipped ".gitignore not found"
fi

# Remove yamato.d and yamato.yaml in dev mode
if [ "$DEV_MODE" -eq 1 ]; then
  if [ -d "$YAMATO_PATH/yamato.d" ]; then
    rm -rf "$YAMATO_PATH/yamato.d"
    log_applied "yamato.d removed for dev mode"
  fi
  if [ -f "$YAMATO_PATH/yamato.yaml" ]; then
    rm -f "$YAMATO_PATH/yamato.yaml"
    log_applied "yamato.yaml removed for dev mode"
  fi
fi

# Copy yamato.d from examples
if [ ! -d "$YAMATO_PATH/yamato.d" ]; then
  if [ -d "$YAMATO_PATH/examples/yamato.d" ]; then
    cp -r "$YAMATO_PATH/examples/yamato.d" "$YAMATO_PATH/yamato.d"
    log_applied "yamato.d created from examples"
  fi
else
  log_skipped "yamato.d already exists"
fi

# Copy yamato.yaml from examples
if [ ! -f "$YAMATO_PATH/yamato.yaml" ]; then
  if [ -f "$YAMATO_PATH/examples/yamato.yaml" ]; then
    cp "$YAMATO_PATH/examples/yamato.yaml" "$YAMATO_PATH/yamato.yaml"
    log_applied "yamato.yaml created from examples"
  fi
else
  log_skipped "yamato.yaml already exists"
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
