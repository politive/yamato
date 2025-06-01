log_section "Install Visual Studio Code"

if command -v code >/dev/null 2>&1; then
  log_skipped "Visual Studio Code"
else
  run brew install visual-studio-code
  log_installed "Visual Studio Code"
fi


TARGET="$HOME/Library/Application Support/Code/User/settings.json"
SOURCE="$YAMATO_PATH/desktop/visual-studio-code/settings.json"

mkdir -p "$(dirname "$TARGET")"

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
