log_section "Install libpq"

if brew list libpq &>/dev/null; then
  log_skipped "libpq"
else
  run brew install libpq
  log_installed "libpq"
fi
