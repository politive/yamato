log_section "Install Figma"

if [ -d "/Applications/Figma.app" ]; then
  log_skipped "Figma"
else
  run brew install figma
  log_installed "Figma"
fi
