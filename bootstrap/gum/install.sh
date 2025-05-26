log_section "Install gum"
if command -v gum >/dev/null 2>&1; then
  log_skipped "gum"
else
  run brew install gum
  log_installed "gum"
fi
