log_section "Install Warp"

if [ -d "/Applications/Warp.app" ]; then
  log_skipped "Warp"
else
  run brew install --cask warp
  log_installed "Warp"
fi
