if type brew &>/dev/null; then
  brew_prefix="$(brew --prefix)"
  fpath=("$brew_prefix/share/zsh-completions" $fpath)

  if [[ -f "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  fi

  if [[ -f "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  fi

  fpath=("$brew_prefix/share/zsh/site-functions" $fpath)

  autoload -Uz compinit
  compinit
fi
