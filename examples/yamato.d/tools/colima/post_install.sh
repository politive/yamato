if command -v colima >/dev/null 2>&1; then
  log_skipped "colima service start (already installed)"
else
  brew services start colima
  log_applied "colima service started"
fi
