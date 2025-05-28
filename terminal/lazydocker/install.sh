log_section "Install lazydocker"

if command -v lazydocker &>/dev/null; then
  log_skipped "lazydocker"
else
  run brew install lazydocker
  log_installed "Installed lazydocker"
fi
