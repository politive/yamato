log_section "Install yq"
if command -v yq >/dev/null 2>&1; then
  log_skipped "yq"
else
  run brew install yq
  log_installed "yq"
fi
