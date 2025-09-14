log_section "Install zsh"

BREW_ZSH_PATH="$(brew --prefix)/bin/zsh"

if [[ -x "$BREW_ZSH_PATH" ]]; then
  log_skipped "$BREW_ZSH_PATH"
else
  run brew install zsh
  log_installed "zsh"
fi

if ! grep -q "^$BREW_ZSH_PATH\$" /etc/shells; then
  log_item "Adding $BREW_ZSH_PATH to /etc/shells (requires sudo)"
  echo "$BREW_ZSH_PATH" | sudo tee -a /etc/shells >/dev/null 2>&1
  log_item "$BREW_ZSH_PATH added to /etc/shells"
fi

if [[ "$SHELL" != "$BREW_ZSH_PATH" ]]; then
  log_item "Changing default shell to $BREW_ZSH_PATH"
  chsh -s "$BREW_ZSH_PATH" >/dev/null 2>&1
  log_item "Default shell updated. Please open a new terminal tab to continue using the new shell."
fi


# Zsh completions and enhancements
log_section "Installing Zsh completions and enhancements..."

packages=(
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

installed=$(brew list)
for pkg in "${packages[@]}"; do
  if echo "$installed" | grep -q "^$pkg$"; then
    log_skipped "$pkg"
  else
    run brew install "$pkg"
    log_installed "$pkg"
  fi
done

chmod go-w "$(brew --prefix)/share" || true
chmod -R go-w "$(brew --prefix)/share/zsh" || true
