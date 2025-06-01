
log_section "Install Podman Desktop for Mac"

if [ -d "/Applications/Podman.app" ]; then
  log_skipped "Podman Desktop"
else
  run brew install --cask podman-desktop
  log_installed "Podman Desktop"
fi
