desktop_labels=("1Password" "Figma" "Slack" "Spotify" "Microsoft Teams" "Visual Studio Code")
desktop_casks=("1password" "figma" "slack" "spotify" "microsoft-teams" "visual-studio-code")

selected=$(printf "%s\n" "${desktop_labels[@]}" | gum choose --no-limit --header="Select desktop apps to install (Space to select, Enter to confirm):")

IFS=$'\n'
for label in $selected; do
  for i in "${!desktop_labels[@]}"; do
    if [[ "${desktop_labels[$i]}" == "$label" ]]; then
      app_name="${desktop_labels[$i]}.app"
      brew_install_cask "${desktop_casks[$i]}" "$app_name"
    fi
  done
done
unset IFS

if command -v code >/dev/null 2>&1; then
  source "$YAMATO_PATH/desktop/visual-studio-code/setup.sh"
fi
