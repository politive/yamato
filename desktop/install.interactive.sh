desktop_items=(
  "1Password:1password"
  "Figma:figma"
  "Slack:slack"
  "Spotify:spotify"
  "Microsoft Teams:microsoft-teams"
  "Visual Studio Code:visual-studio-code"
)

labels=()
for item in "${desktop_items[@]}"; do
  IFS=":" read -r label cask <<< "$item"
  labels+=("$label")
done

selected=$(printf "%s\n" "${labels[@]}" | gum choose --no-limit --header="Select desktop apps to install (Space to select, Enter to confirm):")

IFS=$'\n'
for label in $selected; do
  for item in "${desktop_items[@]}"; do
    IFS=":" read -r l cask <<< "$item"
    if [[ "$l" == "$label" ]]; then
      app_name="$l.app"
      brew_install_cask "$cask" "$app_name"
    fi
  done
done
unset IFS

if command -v code >/dev/null 2>&1; then
  source "$YAMATO_PATH/desktop/visual-studio-code/setup.sh"
fi
