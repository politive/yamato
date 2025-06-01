log_section "Install Browsers"

browser_labels=("Google Chrome" "Microsoft Edge" "Brave" "Opera" "Vivaldi" "Arc")
browser_casks=("google-chrome" "microsoft-edge" "brave-browser" "opera" "vivaldi" "arc")

selected=$(printf "%s\n" "${browser_labels[@]}" | gum choose --no-limit --header="Select browsers to install (Space to select, Enter to confirm):")

IFS=$'\n'
for label in $selected; do
  for i in "${!browser_labels[@]}"; do
    if [[ "${browser_labels[$i]}" == "$label" ]]; then
      if [ -d "/Applications/${browser_labels[$i]}.app" ]; then
        log_skipped "${browser_labels[$i]}"
      else
        run brew install --cask "${browser_casks[$i]}"
        log_installed "${browser_labels[$i]}"
      fi
    fi
  done
done
unset IFS
