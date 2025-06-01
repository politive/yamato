if yq '.docker.all_in_one' "$PRESET_FILE" | grep -qv null; then
  all_in_one=$(yq '.docker.all_in_one' "$PRESET_FILE")
  log_section "Install $all_in_one"
  run brew install --cask "$all_in_one"
  log_installed "$all_in_one"
else
  for cli in $(yq '.docker.cli[]' "$PRESET_FILE"); do
    log_section "Install $cli"
    if command -v "$cli" &>/dev/null; then
      log_skipped "$cli"
    else
      run brew install "$cli"
      log_installed "$cli"
    fi

    [ "$cli" = "docker-compose" ] && [ -f "$YAMATO_PATH/docker/cli/docker-compose.sh" ] && source "$YAMATO_PATH/docker/cli/docker-compose.sh"
  done

  for daemon in $(yq '.docker.daemon[]' "$PRESET_FILE"); do
    log_section "Install $daemon"
    if command -v "$daemon" &>/dev/null; then
      log_skipped "$daemon"
    else
      run brew install "$daemon"
      log_installed "$daemon"
    fi
  done

  for tui in $(yq '.docker.tui[]' "$PRESET_FILE"); do
    log_section "Install $tui"
    if command -v "$tui" &>/dev/null; then
      log_skipped "$tui"
    else
      run brew install "$tui"
      log_installed "$tui"
    fi
  done
fi
