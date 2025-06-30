# Check the distribution name and version and abort if incompatible
source $YAMATO_PATH/check-version.sh

# Install Homebrew
source $YAMATO_PATH/homebrew/install.sh

# Apply MacOS Settings
for f in $YAMATO_PATH/settings/*.sh; do source "$f"; done

# Install Bootstrap tools
source "$YAMATO_PATH/bootstrap/install.$MODE.sh"

if [[ "$MODE" == "interactive" ]]; then
  # Install Desktop App, Docker, Terminal, Browser
  for category in desktop docker terminal browser; do
    script="$YAMATO_PATH/$category/install.interactive.sh"
    if [ -f "$script" ]; then
      source "$script"
    fi
  done
fi

tool_names=()
tool_cmds=()
tool_check_types=()
tool_check_values=()
tool_symlinks=()

while IFS= read -r line; do tool_names+=("$line"); done < <(yq '.tools[].name' "$PRESET_FILE")
while IFS= read -r line; do tool_cmds+=("$line"); done < <(yq '.tools[].command' "$PRESET_FILE")
while IFS= read -r line; do tool_check_types+=("$line"); done < <(yq '.tools[].check.type' "$PRESET_FILE")
while IFS= read -r line; do tool_check_values+=("$line"); done < <(yq '.tools[].check.value' "$PRESET_FILE")

tool_count=${#tool_names[@]}

for ((i=0; i<tool_count; i++)); do
  name="${tool_names[$i]}"
  cmd="${tool_cmds[$i]}"
  check_type="${tool_check_types[$i]}"
  check_value="${tool_check_values[$i]}"

  case "$check_type" in
    command)
      brew_install_command "$cmd" "$check_value"
      ;;
    path)
      brew_install_path "$cmd" "$check_value"
      ;;
    *)
      log_failure "Unknown check type: $check_type for $name"
      ;;
  esac

  # symlinks
  symlink_count=$(yq ".tools[$i].symlinks | length" "$PRESET_FILE" 2>/dev/null || echo 0)
  if [ "$symlink_count" -gt 0 ]; then
    for ((j=0; j<symlink_count; j++)); do
      src_rel=$(yq ".tools[$i].symlinks[$j].source" "$PRESET_FILE")
      tgt_rel=$(yq ".tools[$i].symlinks[$j].target" "$PRESET_FILE")
      src=$(expand_path "$src_rel")
      tgt=$(expand_path "$tgt_rel")
      create_symlink "$src" "$tgt"
    done
  fi
done
