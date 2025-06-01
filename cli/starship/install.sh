log_section "Install starship"

if command -v starship &>/dev/null; then
  log_skipped "starship"
else
  run brew install starship
  log_installed "starship"
fi

TARGET="$HOME/.config/starship.toml"
SOURCE="$YAMATO_PATH/cli/starship/starship.toml"

mkdir -p "$HOME/.config"

if [ -L "$TARGET" ]; then
  if [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
    log_synlink_skipped "$TARGET"
  else
    run ln -sf "$SOURCE" "$TARGET"
    log_synlink_replaced "$TARGET"
  fi
else
  run ln -sf "$SOURCE" "$TARGET"
  log_symlink "$TARGET"
fi
