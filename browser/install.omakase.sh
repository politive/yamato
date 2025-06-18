for i in $(seq 0 $(($(yq '.browser.brew_cask | length' "$PRESET_FILE") - 1))); do
  cask=$(yq ".browser.brew_cask[$i].cask" "$PRESET_FILE")
  app=$(yq ".browser.brew_cask[$i].app" "$PRESET_FILE")
  [ -z "$cask" ] && continue
  [ -z "$app" ] && continue
  brew_install_cask "$cask" "$app"
done
