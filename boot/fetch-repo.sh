fetch_repo() {
  # Fetch or Clone Source Code
  log_section "Fetch or Clone Source Code"
  if [ -d "$HOME/.local/share/yamato/.git" ]; then
    if [ "$SKIP_PULL" -eq 0 ]; then
      git -C "$HOME/.local/share/yamato" pull --ff-only >/dev/null 2>&1
      log_applied "yamato"
    else
      log_skipped "git pull"
    fi
  else
    git clone https://github.com/politive/yamato.git "$HOME/.local/share/yamato" >/dev/null 2>&1
    log_installed "yamato"
  fi
}
