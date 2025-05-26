log_section "Visual Studio Code"
if ! command -v code >/dev/null 2>&1; then
  log_install "Visual Studio Code"
  brew install visual-studio-code >/dev/null 2>&1 && log_success "Visual Studio Code" || log_failure "Visual Studio Code"
else
  log_skipped "Visual Studio Code"
fi

source "$YAMATO_PATH/desktop/visual-studio-code/extensions.sh"
