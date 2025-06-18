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
