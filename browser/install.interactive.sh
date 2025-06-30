browser_items=(
  "Arc:arc"
  "Brave Browser:brave-browser"
  "Google Chrome:google-chrome"
  "Microsoft Edge:microsoft-edge"
  "Opera:opera"
  "Vivaldi:vivaldi"
  "Firefox:firefox"
  "None:"
)

labels=()
for item in "${browser_items[@]}"; do
  IFS=":" read -r label cask <<< "$item"
  labels+=("$label")
done

selected=$(printf "%s\n" "${labels[@]}" | gum choose --no-limit --header="Select browsers to install (Space to select, Enter to confirm):")

IFS=$'\n'
for label in $selected; do
  for item in "${browser_items[@]}"; do
    IFS=":" read -r l cask <<< "$item"
    if [[ "$l" == "$label" && -n "$cask" ]]; then
      brew_install_path "$cask" "/Applications/$app" "true" "$app"
    fi
  done
done
unset IFS
