PRESET_FILE="${PRESET_FILE:-$YAMATO_PATH/yamato.yml}"

terminal_emulator=$(yq '.terminal.emulator' "$PRESET_FILE")

if [ -n "$terminal_emulator" ] && [ "$terminal_emulator" != "null" ]; then
  dir="$YAMATO_PATH/terminal/$terminal_emulator"
  [ -f "$dir/install.sh" ] && source "$dir/install.sh"
else
  log_alert "No terminal emulator specified in $PRESET_FILE (terminal.emulator)."
fi
