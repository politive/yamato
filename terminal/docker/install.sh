log_section "Install Docker"

if command -v docker &>/dev/null; then
  log_skipped "docker"
else
  run brew install docker
  log_installed "docker"
fi
