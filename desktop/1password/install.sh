log_section "1Password"
if brew list --cask | grep -Fxq "1password"; then
  log_skipped "1Password"
else
  brew install --cask 1password >/dev/null 2>&1
  log_installed "1Password"
fi
