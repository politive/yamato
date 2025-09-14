PRESET_FILE="$YAMATO_PATH/yamato.yaml"


log_section "Install Homebrew"
if command -v brew >/dev/null 2>&1; then
  log_skipped "Homebrew"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
while IFS= read -r line; do default_values+=("$line"); done < <(yq '.defaults[].value | @json' "$PRESET_FILE")
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
    run defaults write "$domain" "$key" "-$type" "$value"
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

  # symlinks from dotfiles/<command>/
  dotfiles_dir="$YAMATO_D_PATH/dotfiles/$cmd"
  if [ -d "$dotfiles_dir" ]; then
    find "$dotfiles_dir" -type f | while read -r src_file; do
      # Get relative path from dotfiles/<command>/
      rel_path="${src_file#$dotfiles_dir/}"
      tgt_file="$HOME/$rel_path"

      # Create target directory if needed
      tgt_dir=$(dirname "$tgt_file")
      if [ ! -d "$tgt_dir" ]; then
        mkdir -p "$tgt_dir"
      fi

      create_symlink "$src_file" "$tgt_file"
    done
  fi

  # copy files
  copy_count=$(yq ".tools[$i].copies | length" "$PRESET_FILE" 2>/dev/null || echo 0)
  for ((j=0; j<copy_count; j++)); do
    src_rel=$(yq ".tools[$i].copies[$j].source" "$PRESET_FILE")
    tgt_rel=$(yq ".tools[$i].copies[$j].target" "$PRESET_FILE")
    force=$(yq ".tools[$i].copies[$j].force" "$PRESET_FILE")
    src=$(expand_path "$src_rel")
    tgt=$(expand_path "$tgt_rel")

    if [ "$force" = "true" ]; then
      cp "$src" "$tgt"
      log_applied "$tgt"
    elif [ ! -e "$tgt" ]; then
      cp "$src" "$tgt"
      log_applied "$tgt"
    else
      log_skipped "$tgt"
    fi
  done

  # custom script
  post_script=$(yq ".tools[$i].hooks.post" "$PRESET_FILE")
  if [ -n "$post_script" ]; then
    post_script_path=$(expand_path "$post_script")
    if [ -f "$post_script_path" ]; then
      source "$post_script_path"
    fi
  fi
done


log_section "Create symlinks"
symlink_count=$(yq '.symlinks | length' "$PRESET_FILE" 2>/dev/null || echo 0)
if [ "$symlink_count" -gt 0 ]; then
  for ((i=0; i<symlink_count; i++)); do
    src_rel=$(yq ".symlinks[$i].source" "$PRESET_FILE")
    tgt_rel=$(yq ".symlinks[$i].target" "$PRESET_FILE")
    src=$(expand_path "$src_rel")
    tgt=$(expand_path "$tgt_rel")
    create_symlink "$src" "$tgt"
  done
fi


log_section "Copy files"
copy_count=$(yq '.copies | length' "$PRESET_FILE" 2>/dev/null || echo 0)
if [ "$copy_count" -gt 0 ]; then
  for ((i=0; i<copy_count; i++)); do
    src_rel=$(yq ".copies[$i].source" "$PRESET_FILE")
    tgt_rel=$(yq ".copies[$i].target" "$PRESET_FILE")
    force=$(yq ".copies[$i].force" "$PRESET_FILE")
    src=$(expand_path "$src_rel")
    tgt=$(expand_path "$tgt_rel")

    if [ "$force" = "true" ]; then
      cp "$src" "$tgt"
      log_applied "$tgt"
    elif [ ! -e "$tgt" ]; then
      cp "$src" "$tgt"
      log_applied "$tgt"
    else
      log_skipped "$tgt"
    fi
  done
fi
