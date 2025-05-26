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
    brew install "$pkg" >/dev/null 2>&1
    log_installed "$pkg."
  fi
done

chmod go-w "$(brew --prefix)/share" || true
chmod -R go-w "$(brew --prefix)/share/zsh" || true
