log_section "Spotify"

if brew list --cask spotify &>/dev/null; then
  log_skipped "Spotify"
else
  run brew install spotify
  log_installed "Spotify"
fi
