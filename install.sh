PRESET_FILE="$YAMATO_PATH/yamato.yaml"


log_section "Install Homebrew"
if command -v brew >/dev/null 2>&1; then
  log_skipped "Homebrew"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  log_installed "Homebrew"
fi


if command -v yq >/dev/null 2>&1; then
  log_skipped "yq"
else
  run brew install yq
  log_installed "yq"
fi


log_section "MacOS Settings"
default_domains=()
default_keys=()
default_types=()
default_values=()
default_comments=()

while IFS= read -r line; do default_domains+=("$line"); done < <(yq '.defaults[].domain' "$PRESET_FILE")
while IFS= read -r line; do default_keys+=("$line"); done < <(yq '.defaults[].key' "$PRESET_FILE")
while IFS= read -r line; do default_types+=("$line"); done < <(yq '.defaults[].type' "$PRESET_FILE")
while IFS= read -r line; do default_values+=("$line"); done < <(yq '.defaults[].value' "$PRESET_FILE")
while IFS= read -r line; do default_comments+=("$line"); done < <(yq '.defaults[].comment' "$PRESET_FILE")

default_count=${#default_domains[@]}

for ((i=0; i<default_count; i++)); do
  domain="${default_domains[$i]}"
  key="${default_keys[$i]}"
  type="${default_types[$i]}"
  value="${default_values[$i]}"
  comment="${default_comments[$i]}"

  if [ "$type" = "array" ]; then
    if [ "$value" = "[]" ]; then
      run defaults write "$domain" "$key" -array
    else
      arr=($(echo "$value" | jq -r '.[]'))
      run defaults write "$domain" "$key" -array "${arr[@]}"
    fi
  else
    run defaults write "$domain" "$key" -$type $value
  fi

  if [ -n "$comment" ]; then
    log_applied "$comment"
  else
    log_applied "$domain $key"
  fi
done


tool_cmds=()
while IFS= read -r line; do tool_cmds+=("$line"); done < <(yq '.tools[].command' "$PRESET_FILE")
tool_count=${#tool_cmds[@]}

for ((i=0; i<tool_count; i++)); do
  cmd="${tool_cmds[$i]}"

  # Start log section first
  log_section "Install $cmd"

  # Get check type with default value
  check_type=$(yq ".tools[$i].check.type" "$PRESET_FILE" 2>/dev/null)
  if [ "$check_type" = "null" ] || [ -z "$check_type" ]; then
    check_type="command"
  fi

  # Get check value with default value (use command if not specified)
  check_value=$(yq ".tools[$i].check.value" "$PRESET_FILE" 2>/dev/null)
  if [ "$check_value" = "null" ] || [ -z "$check_value" ]; then
    check_value="$cmd"
  fi

  # Get cask if specified
  cask=$(yq ".tools[$i].cask" "$PRESET_FILE" 2>/dev/null)
  if [ "$cask" = "true" ]; then
    brew_install_cask "$cmd" "$cmd" "$check_type" "$check_value" "$i"
  else
    brew_install "$cmd" "$check_type" "$check_value" "$i"
  fi

  # Auto-discover config files in tools/<command>/dotfiles/ and create symlinks
  tool_dotfiles_dir="$YAMATO_D_PATH/tools/$cmd/dotfiles"
  if [ -d "$tool_dotfiles_dir" ]; then
    find "$tool_dotfiles_dir" -type f | while read -r src_file; do
      # Get relative path from tools/<command>/dotfiles/
      rel_path="${src_file#$tool_dotfiles_dir/}"
      tgt_file="$HOME/$rel_path"

      # Create target directory if needed
      tgt_dir=$(dirname "$tgt_file")
      if [ ! -d "$tgt_dir" ]; then
        mkdir -p "$tgt_dir"
      fi

      create_symlink "$src_file" "$tgt_file"
    done
  fi

  # Auto-detect and run post_install.sh
  tool_post_install_script="$YAMATO_D_PATH/tools/$cmd/post_install.sh"
  if [ -f "$tool_post_install_script" ]; then
    source "$tool_post_install_script"
  fi
done
