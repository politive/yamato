log_section "Install Visual Studio Code Extensions"

EXT_FILE="$YAMATO_PATH/desktop/visual-studio-code/extensions.txt"
installed=$(code --list-extensions)

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" || "$line" == \#* ]] && continue

  if grep -Fxq "$line" <<< "$installed"; then
    log_skipped "$line"
  else
    if code --install-extension "$line" >/dev/null 2>&1; then
      log_installed "$line"
    else
      log_failure "$line"
      exit 1
    fi
  fi
done < "$EXT_FILE"
