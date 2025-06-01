log_section "Install Microsoft Teams"

if [ -d "/Applications/Microsoft Teams.app" ]; then
  log_skipped "Microsoft Teams"
else
  run brew install --cask microsoft-teams
  log_installed "Microsoft Teams"
fi
