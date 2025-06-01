PRESET_FILE="${PRESET_FILE:-$YAMATO_PATH/yamato.yml}"

browsers=$(yq '.browser' "$PRESET_FILE")

if [ -z "$browsers" ] || [ "$browsers" = "null" ]; then
  log_alert "No browser specified in $PRESET_FILE (browser)."
  exit 0
fi

for browser in $(yq '.browser[]' "$PRESET_FILE"); do
  run brew install --cask "$browser"
  log_installed "$browser"
done
