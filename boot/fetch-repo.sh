fetch_repo() {
  # Fetch or Clone Source Code
  log_section "Fetch or Clone Source Code"

  # Set default repository if not specified
  YAMATO_REPO="${YAMATO_REPO:-politive/yamato}"
  YAMATO_URL="https://github.com/${YAMATO_REPO}.git"

  if [ -d "$HOME/.local/share/yamato/.git" ]; then
    if [ "$SKIP_PULL" -eq 0 ]; then
      git -C "$HOME/.local/share/yamato" pull --ff-only >/dev/null 2>&1
      log_applied "yamato"
    else
      log_skipped "git pull"
    fi
  else
    git clone "$YAMATO_URL" "$HOME/.local/share/yamato" >/dev/null 2>&1
    log_installed "yamato"
  fi
}
