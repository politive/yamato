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
USER_PATH="$YAMATO_PATH/user"
YAMATO_D_PATH="$YAMATO_PATH/yamato.d"
USER_D_PATH="$USER_PATH/yamato.d"
for file in $YAMATO_D_PATH/tools/*/export.zsh; do [[ -f "$file" ]] && source "$file"; done
