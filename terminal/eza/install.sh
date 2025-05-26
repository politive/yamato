log_section "Install eza"

if command -v eza >/dev/null 2>&1; then
  log_skipped "eza"
else
  run brew install eza
  log_installed "eza"
fi
