docker_options=(
  "Docker Desktop (All-in-one)"
  "Rancher Desktop (All-in-one)"
  "Podman Desktop (All-in-one)"
  "Custom (Choose components individually)"
)
docker_choice=$(printf "%s\n" "${docker_options[@]}" | gum choose --limit=1 --header="Select your Docker setup:")

case "$docker_choice" in
  "Docker Desktop (All-in-one)")
    dir="$YAMATO_PATH/docker/desktop/docker-desktop"
    [ -f "$dir/install.sh" ] && source "$dir/install.sh"
    ;;
  "Rancher Desktop (All-in-one)")
    dir="$YAMATO_PATH/docker/desktop/rancher-desktop"
    [ -f "$dir/install.sh" ] && source "$dir/install.sh"
    ;;
  "Podman Desktop (All-in-one)")
    dir="$YAMATO_PATH/docker/desktop/podman-desktop"
    [ -f "$dir/install.sh" ] && source "$dir/install.sh"
    ;;
  "Custom (Choose components individually)")
    # 1. CLI
    cli_dir="$YAMATO_PATH/docker/cli/docker"
    [ -f "$cli_dir/install.sh" ] && source "$cli_dir/install.sh"

    cli_dir="$YAMATO_PATH/docker/cli/docker-compose"
    [ -f "$cli_dir/install.sh" ] && source "$cli_dir/install.sh"

    # 2. Daemon
    daemon_labels=("Colima" "Lima" "None")
    daemon_dirs=("colima" "lima" "")
    daemon_choice=$(printf "%s\n" "${daemon_labels[@]}" | gum choose --limit=1 --header="Select a Docker daemon:")
    for i in "${!daemon_labels[@]}"; do
      if [[ "${daemon_labels[$i]}" == "$daemon_choice" && -n "${daemon_dirs[$i]}" ]]; then
        dir="$YAMATO_PATH/cli/${daemon_dirs[$i]}"
        [ -f "$dir/install.sh" ] && source "$dir/install.sh"
      fi
    done

    # 3. UI (optional)
    ui_labels=("ctop" "dive" "dockly" "docui" "lazydocker" "lazykournal" "oxker" "None")
    ui_dirs=("ctop" "dive" "dockly" "docui" "lazydocker" "lazykournal" "oxker" "")

    while :; do
      ui_choice=$(printf "%s\n" "${ui_labels[@]}" | gum choose --no-limit --header="Select Docker TUI tools (multi-select possible, Space to select, Enter to confirm):")
      if [ -n "$ui_choice" ]; then
        break
      fi
      log_alert "Please select at least one tool (use Space to select)."
    done

    for label in $ui_choice; do
      for i in "${!ui_labels[@]}"; do
        if [[ "${ui_labels[$i]}" == "$label" && -n "${ui_dirs[$i]}" ]]; then
          dir="$YAMATO_PATH/docker/tui/${ui_dirs[$i]}"
          [ -f "$dir/install.sh" ] && source "$dir/install.sh"
        fi
      done
    done
esac
