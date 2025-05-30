log_section "Microsoft Teams"

if brew list --cask microsoft-teams &>/dev/null; then
  log_skipped "Microsoft Teams"
else
  run brew install --cask microsoft-teams
  log_installed "Microsoft Teams"
fi
