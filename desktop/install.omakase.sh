apps=$(yq '.desktop.brew_cask[]' "$PRESET_FILE")
for i in $(seq 0 $(($(yq '.desktop.brew_cask | length' "$PRESET_FILE") - 1))); do
  cask=$(yq ".desktop.brew_cask[$i].cask" "$PRESET_FILE")
  app=$(yq ".desktop.brew_cask[$i].app" "$PRESET_FILE")
  [ -z "$cask" ] && continue
  [ -z "$app" ] && continue
  brew_install_cask "$cask" "$app"
done

if command -v code >/dev/null 2>&1; then
  source "$YAMATO_PATH/desktop/visual-studio-code/setup.sh"
fi
