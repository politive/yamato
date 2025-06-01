log_section "Install Alacritty"

if command -v alacritty >/dev/null 2>&1; then
  log_skipped "Alacritty"
else
  run brew install --cask alacritty
  log_installed "Alacritty"
fi


TARGET="$HOME/.config/alacritty/alacritty.toml"
SOURCE="$YAMATO_PATH/terminal/alacritty/alacritty.toml"

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
