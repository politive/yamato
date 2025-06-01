log_section "Install kimigayo "

if command -v kimigayo >/dev/null 2>&1; then
  log_skipped "kimigayo"
else
  run brew tap politive/kimigayo
  run brew install kimigayo
  log_installed "kimigayo"
fi
