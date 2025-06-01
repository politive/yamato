PRESET_FILE="${PRESET_FILE:-$YAMATO_PATH/yamato.yml}"

if yq '.docker.all_in_one' "$PRESET_FILE" | grep -qv null; then
  all_in_one=$(yq '.docker.all_in_one' "$PRESET_FILE")
  all_in_one_dir="$YAMATO_PATH/docker/desktop/$all_in_one"
  [ -f "$all_in_one_dir/install.sh" ] && source "$all_in_one_dir/install.sh"
else
  for cli in $(yq '.docker.cli[]' "$PRESET_FILE"); do
    cli_dir="$YAMATO_PATH/docker/cli/$cli"
    [ -f "$cli_dir/install.sh" ] && source "$cli_dir/install.sh"
  done

  daemon=$(yq '.docker.daemon' "$PRESET_FILE")
  daemon_dir="$YAMATO_PATH/docker/daemon/$daemon"
  [ -f "$daemon_dir/install.sh" ] && source "$daemon_dir/install.sh"

  for tui in $(yq '.docker.tui[]' "$PRESET_FILE"); do
    tui_dir="$YAMATO_PATH/docker/tui/$tui"
    [ -f "$tui_dir/install.sh" ] && source "$tui_dir/install.sh"
  done
fi
