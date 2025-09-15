install_command() {
  # Create symlink for yamato command
  LOCAL_BIN_PATH="$HOME/.local/bin"
  if [ ! -L "$LOCAL_BIN_PATH/yamato" ]; then
    mkdir -p "$LOCAL_BIN_PATH"
    ln -sf "$YAMATO_PATH/yamato" "$LOCAL_BIN_PATH/yamato"
    log_applied "yamato command installed to $LOCAL_BIN_PATH/yamato"
  fi
}
