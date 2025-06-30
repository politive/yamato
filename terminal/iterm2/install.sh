log_section "Install iTerm2"

brew_install_path "iterm2" "/Applications/iTerm.app" "true" "iTerm.app"

SOURCE="$YAMATO_PATH/terminal/iterm2/com.googlecode.iterm2.plist"
TARGET="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
create_symlink "$SOURCE" "$TARGET"
