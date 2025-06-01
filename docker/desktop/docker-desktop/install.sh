log_section "Install Docker Desktop for Mac"

if [ -d "/Applications/Docker.app" ]; then
  log_skipped "Docker Desktop"
else
  run brew install --cask docker
  log_installed "Docker Desktop"
fi
