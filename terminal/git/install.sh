log_section "Install Git"

BREW_GIT_PATH="$(brew --prefix)/bin/git"

if [[ -x "$BREW_GIT_PATH" ]]; then
  log_skipped "Git already installed at $BREW_GIT_PATH"
else
  run brew install git
  log_installed "Git"
  run brew install gnupg
  log_installed "GnuPG"
fi
