create_symlink() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ]; then
    if [ "$(readlink "$target")" = "$source" ]; then
      log_synlink_skipped "$target"
    else
      run ln -sf "$source" "$target"
      log_synlink_replaced "$target"
    fi
  else
    run ln -sf "$source" "$target"
    log_symlink "$target"
  fi
}

expand_path() {
  local path="$1"
  path="${path//\$HOME/$HOME}"
  path="${path//\$YAMATO_PATH/$YAMATO_PATH}"
  echo "$path"
}
