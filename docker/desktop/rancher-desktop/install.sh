log_section "Install Rancher Desktop for Mac"

if [ -d "/Applications/Rancher Desktop.app" ]; then
  log_skipped "Rancher Desktop"
else
  run brew install --cask rancher
  log_installed "Rancher Desktop"
fi
