browser_labels=("Arc" "Brave Browser" "Google Chrome" "Microsoft Edge" "Opera" "Vivaldi" "Firefox" "None")
browser_casks=("arc" "brave-browser" "google-chrome" "microsoft-edge" "opera" "vivaldi" "firefox" "")

browsers=$(yq '.browser[]' "$PRESET_FILE")

for browser in $browsers; do
  for i in "${!browser_casks[@]}"; do
    if [[ "${browser_casks[$i]}" == "$browser" ]]; then
      app_path="/Applications/${browser_labels[$i]}.app"
      log_section "Install ${browser_labels[$i]}"
      if [ -d "$app_path" ]; then
        log_skipped "${browser_labels[$i]}"
      else
        run brew install --cask "${browser_casks[$i]}"
        log_installed "${browser_labels[$i]}"
      fi
    fi
  done
done
