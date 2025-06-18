docker_options=(
  "Docker Desktop (All-in-one)"
  "Rancher Desktop (All-in-one)"
  "Podman Desktop (All-in-one)"
  "Custom (Choose components individually)"
)
docker_choice=$(printf "%s\n" "${docker_options[@]}" | gum choose --limit=1 --header="Select your Docker setup:")

case "$docker_choice" in
  "Docker Desktop (All-in-one)")
    brew_install_cask docker "Docker.app"
    ;;
  "Rancher Desktop (All-in-one)")
    brew_install_cask rancher "Rancher.app"
    ;;
  "Podman Desktop (All-in-one)")
    brew_install_cask podman-desktop "Podman Desktop.app"
    ;;
  "Custom (Choose components individually)")
    # CLI
    brew_install docker
    brew_install docker-compose

    # Daemon
    daemon_labels=("Colima" "Lima" "None")
    daemon_casks=("colima" "lima" "")
    daemon_choice=$(printf "%s\n" "${daemon_labels[@]}" | gum choose --limit=1 --header="Select a Docker daemon:")
    for i in "${!daemon_labels[@]}"; do
      if [[ "${daemon_labels[$i]}" == "$daemon_choice" && -n "${daemon_casks[$i]}" ]]; then
        brew_install "${daemon_casks[$i]}"
      fi
    done

    # TUI (optional)
    tui_labels=("ctop" "dive" "dockly" "docui" "lazydocker" "lazyjournal" "oxker" "None")
    tui_casks=("ctop" "dive" "dockly" "docui" "lazydocker" "lazyjournal" "oxker" "")
    tui_choice=$(printf "%s\n" "${tui_labels[@]}" | gum choose --no-limit --header="Select Docker TUI tools (multi-select possible, Space to select, Enter to confirm):")

    IFS=$'\n'
    for label in $tui_choice; do
      for i in "${!tui_labels[@]}"; do
        if [[ "${tui_labels[$i]}" == "$label" && -n "${tui_casks[$i]}" ]]; then
          brew_install "${tui_casks[$i]}"
        fi
      done
    done
    unset IFS
    ;;
esac
