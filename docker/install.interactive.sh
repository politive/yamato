docker_options=(
  "Docker Desktop (All-in-one)"
  "Rancher Desktop (All-in-one)"
  "Podman Desktop (All-in-one)"
  "Custom (Choose components individually)"
)
docker_choice=$(printf "%s\n" "${docker_options[@]}" | gum choose --limit=1 --header="Select your Docker setup:")

case "$docker_choice" in
  "Docker Desktop (All-in-one)")
    brew_install_path docker "/Applications/Docker.app" "true" "Docker.app"
    ;;
  "Rancher Desktop (All-in-one)")
    brew_install_path rancher "/Applications/Rancher.app" "true" "Rancher.app"
    ;;
  "Podman Desktop (All-in-one)")
    brew_install_path podman-desktop "/Applications/Podman Desktop.app" "true" "Podman Desktop.app"
    ;;
  "Custom (Choose components individually)")
    # CLI
    brew_install docker
    brew_install docker-compose

    # Daemon
    daemon_items=(
      "Colima:colima"
      "Lima:lima"
      "None:"
    )
    daemon_labels=()
    for item in "${daemon_items[@]}"; do
      IFS=":" read -r label cask <<< "$item"
      daemon_labels+=("$label")
    done
    daemon_choice=$(printf "%s\n" "${daemon_labels[@]}" | gum choose --limit=1 --header="Select a Docker daemon:")
    for item in "${daemon_items[@]}"; do
      IFS=":" read -r label cask <<< "$item"
      if [[ "$label" == "$daemon_choice" && -n "$cask" ]]; then
        brew_install "$cask"
      fi
    done

    # TUI (optional)
    tui_items=(
      "ctop:ctop"
      "dive:dive"
      "dockly:dockly"
      "docui:docui"
      "lazydocker:lazydocker"
      "lazyjournal:lazyjournal"
      "oxker:oxker"
      "None:"
    )
    tui_labels=()
    for item in "${tui_items[@]}"; do
      IFS=":" read -r label cask <<< "$item"
      tui_labels+=("$label")
    done
    tui_choice=$(printf "%s\n" "${tui_labels[@]}" | gum choose --no-limit --header="Select Docker TUI tools (multi-select possible, Space to select, Enter to confirm):")

    IFS=$'\n'
    for label in $tui_choice; do
      for item in "${tui_items[@]}"; do
        IFS=":" read -r l cask <<< "$item"
        if [[ "$l" == "$label" && -n "$cask" ]]; then
          brew_install "$cask"
        fi
      done
    done
    unset IFS
    ;;
esac
