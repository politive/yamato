brew_install() {
  local brew_name="$1"
  local check_type="$2"
  local check_value="$3"
  local tool_index="$4"

  # Run tap if needed
  brew_tap "$tool_index" "$check_type" "$check_value"

  case "$check_type" in
    command)
      # log_section is now handled by caller
      if command -v "$check_value" >/dev/null 2>&1; then
        log_skipped "$brew_name"
      else
        run brew install "$brew_name"
        log_installed "$brew_name"
      fi
      ;;
    path)
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

brew_tap() {
  local tool_index="$1"
  local check_type="$2"
  local check_value="$3"

  case "$check_type" in
    command)
      if ! command -v "$check_value" >/dev/null 2>&1; then
        # Tool not installed, check if tap is needed
        local tap=$(yq ".tools[$tool_index].tap" "$PRESET_FILE" 2>/dev/null)
        if [ "$tap" != "null" ] && [ -n "$tap" ]; then
          run brew tap "$tap"
        fi
      fi
      ;;
    path)
      if [ ! -e "$check_value" ]; then
        # Tool not installed, check if tap is needed
        local tap=$(yq ".tools[$tool_index].tap" "$PRESET_FILE" 2>/dev/null)
        if [ "$tap" != "null" ] && [ -n "$tap" ]; then
          run brew tap "$tap"
        fi
      fi
      ;;
  esac
}

brew_install_cask() {
  local cask="$1"
  local app_name="$2"
  local check_type="$3"
  local check_value="$4"
  local tool_index="$5"

  # Run tap if needed
  brew_tap "$tool_index" "$check_type" "$check_value"

  case "$check_type" in
    command)
      # log_section is now handled by caller
      if command -v "$check_value" >/dev/null 2>&1; then
        log_skipped "$cask"
      else
        run brew install --cask "$cask"
        log_installed "$cask"
      fi
      ;;
    path)
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
