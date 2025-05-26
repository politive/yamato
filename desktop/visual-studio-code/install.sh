log_section "Visual Studio Code"
if command -v code >/dev/null 2>&1; then
  log_skipped "Visual Studio Code"
else
  run brew install visual-studio-code
  log_installed "1Password"
fi

source "$YAMATO_PATH/desktop/visual-studio-code/extensions.sh"
