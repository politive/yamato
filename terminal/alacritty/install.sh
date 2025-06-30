log_section "Install Alacritty"

brew_install_path "alacritty" "/Applications/Alacritty.app" "true" "Alacritty.app"

SOURCE="$YAMATO_PATH/terminal/alacritty/alacritty.toml"
TARGET="$HOME/.config/alacritty/alacritty.toml"

create_symlink "$SOURCE" "$TARGET"
