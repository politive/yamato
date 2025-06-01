log_section "Install iTerm2"

if [ -d "/Applications/iTerm.app" ]; then
  log_skipped "iTerm2"
else
  run brew install --cask iterm2
  log_installed "iTerm2"
fi


TARGET="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
SOURCE="$YAMATO_PATH/terminal/iterm2/com.googlecode.iterm2.plist"

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
