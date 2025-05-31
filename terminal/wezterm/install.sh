log_section "Install WezTerm"

if command -v wezterm >/dev/null 2>&1; then
  log_skipped "WezTerm"
else
  run brew install WezTerm
  log_installed "WezTerm"
fi


TARGET="$HOME/.config/wezterm/wezterm.lua"
SOURCE="$YAMATO_PATH/terminal/wezterm/wezterm.lua"

mkdir -p "$(dirname "$TARGET")"

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
