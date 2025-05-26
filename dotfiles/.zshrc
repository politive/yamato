# Locale
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history inc_append_history append_history

# export
YAMATO_PATH="$HOME/.local/share/yamato"
for file in $YAMATO_PATH/terminal/*/export.zsh; do [[ -f "$file" ]] && source "$file"; done
