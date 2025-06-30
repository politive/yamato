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

brew_install_command() {
  local brew_name="$1"
  local cmd_name="$2"
  local cask_flag="${3:-false}"
  local app_name="${4:-}"

  log_section "Install $brew_name"
  if [ "$cask_flag" = "true" ]; then
    # caskの場合はapp_name必須
    if [ -z "$app_name" ]; then
      log_failure "brew_install_command: app_name must be specified for cask '$brew_name'"
      return 1
    fi
    local app_path="/Applications/$app_name"
    if [ -d "$app_path" ]; then
      log_skipped "$brew_name"
    else
      run brew install --cask "$brew_name"
      log_installed "$brew_name"
    fi
  else
    if command -v "$cmd_name" >/dev/null 2>&1; then
      log_skipped "$brew_name"
    else
      run brew install "$brew_name"
      log_installed "$brew_name"
    fi
  fi
}

brew_install_path() {
  local brew_name="$1"
  local path="$2"
  local cask_flag="${3:-false}"
  local app_name="${4:-}"

  log_section "Install $brew_name"
  if [ "$cask_flag" = "true" ]; then
    if [ -z "$app_name" ]; then
      log_failure "brew_install_path: app_name must be specified for cask '$brew_name'"
      return 1
    fi
    local app_path="/Applications/$app_name"
    if [ -d "$app_path" ]; then
      log_skipped "$brew_name"
    else
      run brew install --cask "$brew_name"
      log_installed "$brew_name"
    fi
  else
    if [ -e "$path" ]; then
      log_skipped "$brew_name"
    else
      run brew install "$brew_name"
      log_installed "$brew_name"
    fi
  fi
}

brew_install_cask() {
  local cask="$1"
  local app_name="$2"
  if [ -z "$app_name" ]; then
    log_failure "brew_install_cask: app_name must be specified for cask '$cask'"
    return 1
  fi
  local app_path="/Applications/$app_name"
  log_section "Install $cask"
  if [ -d "$app_path" ]; then
    log_skipped "$cask"
  else
    run brew install --cask "$cask"
    log_installed "$cask"
  fi
}
