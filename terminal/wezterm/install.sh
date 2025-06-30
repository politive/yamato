log_section "Install WezTerm"

brew_install_command "wezterm" "wezterm"

SOURCE="$YAMATO_PATH/terminal/wezterm/wezterm.lua"
TARGET="$HOME/.config/wezterm/wezterm.lua"
create_symlink "$SOURCE" "$TARGET"
