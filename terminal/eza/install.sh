log_section "Install eza"

if command -v eza >/dev/null 2>&1; then
  log_skipped "eza"
else
  brew install eza >/dev/null 2>&1
  log_installed "eza"
fi
