log_section "Install zsh"

BREW_ZSH_PATH="$(brew --prefix)/bin/zsh"

if [[ -x "$BREW_ZSH_PATH" ]]; then
  log_skipped "Homebrew zsh is already installed at $BREW_ZSH_PATH."
else
  brew install zsh >/dev/null 2>&1
  log_installed "zsh installed at $BREW_ZSH_PATH."
fi

if ! grep -q "^$BREW_ZSH_PATH\$" /etc/shells; then
  log_item "Adding $BREW_ZSH_PATH to /etc/shells (requires sudo)"
  echo "$BREW_ZSH_PATH" | sudo tee -a /etc/shells >/dev/null 2>&1
fi

if [[ "$SHELL" != "$BREW_ZSH_PATH" ]]; then
  log_item "Changing default shell to $BREW_ZSH_PATH"
  chsh -s "$BREW_ZSH_PATH" >/dev/null 2>&1
  log_installed "Default shell updated. Please open a new terminal tab to continue using the new shell."
fi

source $YAMATO_PATH/terminal/zsh/completion.sh
