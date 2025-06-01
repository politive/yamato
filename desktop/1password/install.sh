log_section "Install 1Password"

if [ -d "/Applications/1Password.app" ]; then
  log_skipped "1Password"
else
  run brew install 1password
  log_installed "1Password"
fi
