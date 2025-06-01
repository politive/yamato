log_section "Install libpq"

if command -v pg_config >/dev/null 2>&1; then
  log_skipped "libpq"
else
  run brew install libpq
  log_installed "libpq"
fi
