log_section "Installing Slack"

if [ -d "/Applications/Slack.app" ]; then
  log_skipped "Slack"
else
  run brew install --cask slack
  log_installed "Slack"
fi
