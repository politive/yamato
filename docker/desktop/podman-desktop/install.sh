
log_section "Install Docker Desktop for Mac"

if brew list --cask "podman-desktop"; then
  log_skipped "podman-desktop"
else
  run brew install --cask podman-desktop
  log_installed "podman-desktop"
fi
