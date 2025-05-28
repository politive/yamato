log_section "Install Colima"

if command -v colima &>/dev/null; then
  log_skipped "colima"
else
  run brew install colima
  log_installed "colima"
fi
