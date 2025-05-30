log_section "Installing Slack"
if brew list --cask slack &>/dev/null; then
  log_skipped "Slack"
else
  run brew install --cask slack
  log_installed "Slack"
fi
