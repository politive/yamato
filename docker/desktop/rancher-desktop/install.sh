log_section "Install Rancher Desktop for Mac"

if brew list --cask "rancher" &>/dev/null; then
  log_skipped "Rancher Desktop"
else
  run brew install --cask rancher
  log_installed "Rancher Desktop"
fi
