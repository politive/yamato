log_section "Install mise"

if command -v mise &>/dev/null; then
  log_skipped "mise"
else
  run brew install mise
  log_installed "mise"
fi
