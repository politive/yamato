log_section "1Password"
if brew list --cask | grep -Fxq "1password"; then
  log_skipped "1Password"
else
  run brew install 1password
  log_installed "1Password"
fi
