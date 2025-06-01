terminal_labels=("iTerm2" "WezTerm" "Warp" "Alacritty" "Kitty")
terminal_dirs=("iterm2" "wezterm" "warp" "alacritty" "kitty")

terminal_choice=$(printf "%s\n" "${terminal_labels[@]}" | gum choose --limit=1 --header="Select a terminal emulator to install:")

for i in "${!terminal_labels[@]}"; do
  if [[ "${terminal_labels[$i]}" == "$terminal_choice" ]]; then
    dir="$YAMATO_PATH/terminal/${terminal_dirs[$i]}"
    [ -f "$dir/install.sh" ] && source "$dir/install.sh"
  fi
done
