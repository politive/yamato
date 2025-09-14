# TODO: 移行後に削除
brew_install() {
  local name="$1"
  log_section "Install $name"
  if command -v "$name" >/dev/null 2>&1; then
    log_skipped "$name"
  else
    run brew install "$name"
    log_installed "$name"
  fi
}

brew_install() {
  local brew_name="$1"
  local check_type="$2"
  local check_value="$3"
  local tool_index="$4"

  case "$check_type" in
    command)
      # Run tap if needed
      brew_tap_command "$tool_index" "$check_value"

      # log_section is now handled by caller
      if command -v "$check_value" >/dev/null 2>&1; then
        log_skipped "$brew_name"
      else
        run brew install "$brew_name"
        log_installed "$brew_name"
      fi
      ;;
    path)
      # Run tap if needed
      brew_tap_path "$tool_index" "$check_value"

      # log_section is now handled by caller
      if [ -e "$check_value" ]; then
        log_skipped "$brew_name"
      else
        run brew install "$brew_name"
        log_installed "$brew_name"
      fi
      ;;
    *)
      log_failure "Unknown check type: $check_type for $brew_name"
      ;;
  esac
}

brew_tap_command() {
  local tool_index="$1"
  local cmd_name="$2"

  if ! command -v "$cmd_name" >/dev/null 2>&1; then
    # Tool not installed, check if tap is needed
    local tap=$(yq ".tools[$tool_index].tap" "$PRESET_FILE" 2>/dev/null)
    if [ "$tap" != "null" ] && [ -n "$tap" ]; then
      run brew tap "$tap"
    fi
  fi
}

brew_tap_path() {
  local tool_index="$1"
  local path="$2"

  if [ ! -e "$path" ]; then
    # Tool not installed, check if tap is needed
    local tap=$(yq ".tools[$tool_index].tap" "$PRESET_FILE" 2>/dev/null)
    if [ "$tap" != "null" ] && [ -n "$tap" ]; then
      run brew tap "$tap"
    fi
  fi
}

brew_install_cask() {
  local cask="$1"
  local app_name="$2"
  local check_type="$3"
  local check_value="$4"
  local tool_index="$5"

  case "$check_type" in
    command)
      # Run tap if needed
      brew_tap_command "$tool_index" "$check_value"

      # log_section is now handled by caller
      if command -v "$check_value" >/dev/null 2>&1; then
        log_skipped "$cask"
      else
        run brew install --cask "$cask"
        log_installed "$cask"
      fi
      ;;
    path)
      # Run tap if needed
      brew_tap_path "$tool_index" "$check_value"

      # log_section is now handled by caller
      if [ -e "$check_value" ]; then
        log_skipped "$cask"
      else
        run brew install --cask "$cask"
        log_installed "$cask"
      fi
      ;;
    *)
      log_failure "Unknown check type: $check_type for $cask"
      ;;
  esac
}
