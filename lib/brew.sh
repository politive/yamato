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
