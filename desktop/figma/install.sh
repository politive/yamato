log_section "Install Figma"

if brew list --cask figma &>/dev/null; then
  log_skipped "Figma"
else
  run brew install figma
  log_installed "Figma"
fi
