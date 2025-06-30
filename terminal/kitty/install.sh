log_section "Install Kitty"

brew_install_path "kitty" "/Applications/Kitty.app" "true" "Kitty.app"

SOURCE="$YAMATO_PATH/terminal/kitty/kitty.conf"
TARGET="$HOME/.config/kitty/kitty.conf"
create_symlink "$SOURCE" "$TARGET"
