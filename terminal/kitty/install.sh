log_section "Install Kitty"

if command -v kitty >/dev/null 2>&1; then
  log_skipped "Kitty"
else
  run brew install --cask kitty
  log_installed "Kitty"
fi


TARGET="$HOME/.config/kitty/kitty.conf"
SOURCE="$YAMATO_PATH/terminal/kitty/kitty.conf"

mkdir -p "$(dirname "$TARGET")"

if [ -f "$SOURCE" ]; then
  if [ -L "$TARGET" ]; then
    if [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
      log_synlink_skipped "$(basename "$TARGET")"
    else
      ln -sf "$SOURCE" "$TARGET"
      log_synlink_replaced "$(basename "$TARGET")"
    fi
  elif [ -e "$TARGET" ]; then
    log_skipped "$(basename "$TARGET")"
  else
    ln -s "$SOURCE" "$TARGET"
    log_symlink "$(basename "$TARGET")"
  fi
fi
