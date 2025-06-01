PLUGIN_DIR="$HOME/.docker/cli-plugins"
PLUGIN_PATH="$PLUGIN_DIR/docker-compose"
BREW_COMPOSE_BIN="$(brew --prefix docker-compose)/bin/docker-compose"

run mkdir -p "$PLUGIN_DIR"

if [ -L "$PLUGIN_PATH" ]; then
  if [ "$(readlink "$PLUGIN_PATH")" = "$BREW_COMPOSE_BIN" ]; then
    log_synlink_skipped "docker-compose plugin"
  else
    run ln -sf "$BREW_COMPOSE_BIN" "$PLUGIN_PATH"
    log_synlink_replaced "docker-compose plugin"
  fi
elif [ -e "$PLUGIN_PATH" ]; then
  log_skipped "docker-compose plugin"
else
  run ln -s "$BREW_COMPOSE_BIN" "$PLUGIN_PATH"
  log_symlink "docker-compose plugin"
fi
