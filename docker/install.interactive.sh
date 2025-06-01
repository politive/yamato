docker_options=(
  "Docker Desktop (All-in-one)"
  "Rancher Desktop (All-in-one)"
  "Podman Desktop (All-in-one)"
  "Custom (Choose components individually)"
)
docker_choice=$(printf "%s\n" "${docker_options[@]}" | gum choose --limit=1 --header="Select your Docker setup:")

case "$docker_choice" in
  "Docker Desktop (All-in-one)")
    if [ -d "/Applications/Docker.app" ]; then
      log_skipped "Docker Desktop"
    else
      run brew install --cask docker
      log_installed "Docker Desktop"
    fi
    ;;
  "Rancher Desktop (All-in-one)")
    if [ -d "/Applications/Rancher.app" ]; then
      log_skipped "Rancher Desktop"
    else
      run brew install --cask rancher
      log_installed "Rancher Desktop"
    fi
    ;;
  "Podman Desktop (All-in-one)")
    if [ -d "/Applications/Podman.app" ]; then
      log_skipped "Podman Desktop"
    else
      run brew install --cask podman-desktop
      log_installed "Podman Desktop"
    fi
    ;;
  "Custom (Choose components individually)")
    # 1. CLI
    if command -v docker &>/dev/null; then
      log_skipped "docker CLI"
    else
      log_section "Install Docker CLI"
    fi

    run brew install docker-compose
    log_installed "docker-compose"

    # 2. Daemon
    daemon_labels=("Colima" "Lima" "None")
    daemon_casks=("colima" "lima" "")
    daemon_choice=$(printf "%s\n" "${daemon_labels[@]}" | gum choose --limit=1 --header="Select a Docker daemon:")
    for i in "${!daemon_labels[@]}"; do
      if [[ "${daemon_labels[$i]}" == "$daemon_choice" && -n "${daemon_casks[$i]}" ]]; then
        run brew install "${daemon_casks[$i]}"
        log_installed "${daemon_labels[$i]}"
      fi
    done

    # 3. UI (optional)
    ui_labels=("ctop" "dive" "dockly" "docui" "lazydocker" "lazyjournal" "oxker" "None")
    ui_casks=("ctop" "dive" "dockly" "docui" "lazydocker" "lazyjournal" "oxker" "")

    while :; do
      ui_choice=$(printf "%s\n" "${ui_labels[@]}" | gum choose --no-limit --header="Select Docker TUI tools (multi-select possible, Space to select, Enter to confirm):")
      if [ -n "$ui_choice" ]; then
        break
      fi
      log_alert "Please select at least one tool (use Space to select)."
    done

    IFS=$'\n'
    for label in $ui_choice; do
      for i in "${!ui_labels[@]}"; do
        if [[ "${ui_labels[$i]}" == "$label" && -n "${ui_casks[$i]}" ]]; then
          run brew install "${ui_casks[$i]}"
          log_installed "${ui_labels[$i]}"
        fi
      done
    done
    unset IFS
    ;;
esac
