log_section "Install Spotify"

if [ -d "/Applications/Spotify.app" ]; then
  log_skipped "Spotify"
else
  run brew install spotify
  log_installed "Spotify"
fi
