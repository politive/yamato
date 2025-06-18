terminal_items=(
  "iTerm2:iterm2"
  "WezTerm:wezterm"
  "Warp:warp"
  "Alacritty:alacritty"
  "Kitty:kitty"
)

labels=()
for item in "${terminal_items[@]}"; do
  IFS=":" read -r label dir <<< "$item"
  labels+=("$label")
done

terminal_choice=$(printf "%s\n" "${labels[@]}" | gum choose --limit=1 --header="Select a terminal emulator to install:")

for item in "${terminal_items[@]}"; do
  IFS=":" read -r label dir <<< "$item"
  if [[ "$label" == "$terminal_choice" ]]; then
    script="$YAMATO_PATH/terminal/$dir/install.sh"
    [ -f "$script" ] && source "$script"
  fi
done
