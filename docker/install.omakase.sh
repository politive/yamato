if yq '.docker.all_in_one' "$PRESET_FILE" | grep -qv null; then
  cask=$(yq '.docker.all_in_one.cask' "$PRESET_FILE")
  app=$(yq '.docker.all_in_one.app' "$PRESET_FILE")
  brew_install_cask "$cask" "$app"
else
  for cli in $(yq '.docker.cli[]' "$PRESET_FILE"); do
    brew_install "$cli"
    if [ "$cli" = "docker-compose" ] && [ -f "$YAMATO_PATH/docker/docker-compose.sh" ]; then
      source "$YAMATO_PATH/docker/docker-compose.sh"
    fi
  done

  for daemon in $(yq '.docker.daemon[]' "$PRESET_FILE"); do
    brew_install "$daemon"
  done

  for tui in $(yq '.docker.tui[]' "$PRESET_FILE"); do
    brew_install "$tui"
  done
fi
