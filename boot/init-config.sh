init_config() {
  # Initialize Configuration
  log_section "Initialize Configuration"

  # Update .gitignore for customization (unless dev mode)
  if [ "$DEV_MODE" -eq 0 ] && [ -f "$YAMATO_PATH/.gitignore" ]; then
    sed -i '' 's/^yamato\.d\/$/# yamato.d\//; s/^yamato\.yaml$/# yamato.yaml/' "$YAMATO_PATH/.gitignore"
    log_applied "Updated .gitignore for customization"
  elif [ "$DEV_MODE" -eq 1 ]; then
    log_skipped ".gitignore update (dev mode)"
  else
    log_skipped ".gitignore not found"
  fi

  # Remove yamato.d and yamato.yaml in dev mode
  if [ "$DEV_MODE" -eq 1 ]; then
    if [ -d "$YAMATO_PATH/yamato.d" ]; then
      rm -rf "$YAMATO_PATH/yamato.d"
      log_applied "yamato.d removed for dev mode"
    fi
    if [ -f "$YAMATO_PATH/yamato.yaml" ]; then
      rm -f "$YAMATO_PATH/yamato.yaml"
      log_applied "yamato.yaml removed for dev mode"
    fi
  fi

  # Copy yamato.d from examples
  if [ ! -d "$YAMATO_PATH/yamato.d" ]; then
    if [ -d "$YAMATO_PATH/examples/yamato.d" ]; then
      cp -r "$YAMATO_PATH/examples/yamato.d" "$YAMATO_PATH/yamato.d"
      log_applied "yamato.d created from examples"
    fi
  else
    log_skipped "yamato.d already exists"
  fi

  # Copy yamato.yaml from examples
  if [ ! -f "$YAMATO_PATH/yamato.yaml" ]; then
    if [ -f "$YAMATO_PATH/examples/yamato.yaml" ]; then
      cp "$YAMATO_PATH/examples/yamato.yaml" "$YAMATO_PATH/yamato.yaml"
      log_applied "yamato.yaml created from examples"
    fi
  else
    log_skipped "yamato.yaml already exists"
  fi
}
