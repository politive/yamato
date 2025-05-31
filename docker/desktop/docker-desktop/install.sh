log_section "Install Docker Desktop for Mac"

if brew list --cask "docker" &>/dev/null; then
  log_skipped "docker"
else
  run brew install --cask docker
  log_installed "docker"
fi
