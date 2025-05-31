log_section " Install 1Password"

if brew list --cask 1password &>/dev/null; then
  log_skipped "1Password"
else
  run brew install 1password
  log_installed "1Password"
fi
