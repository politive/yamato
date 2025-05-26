EZA_IGNORE_PATTERN="\
node_modules|\
.git|\
.cache|\
dist|\
.next|\
.DS_Store|\
venv|\
__pycache__|\
target|\
.terraform|\
storage|"

alias ei="eza --icons --git"
alias ea="eza -ahl --icons --git"
alias ee="eza -hl --icons --git"

et() {
  eza -T -L 3 -a -I "$EZA_IGNORE_PATTERN" --icons "$@"
}

eta() {
  eza -T -a -I "$EZA_IGNORE_PATTERN" --color=always --icons "$@" | less -r
}

alias ls=ei
alias la=ea
alias ll=ee
alias lt=et
alias lta=eta
