# Check the distribution name and version and abort if incompatible
source $YAMATO_PATH/check-version.sh

# Install Homebrew
source $YAMATO_PATH/homebrew/install.sh

# Apply MacOS Settings
for f in $YAMATO_PATH/settings/*.sh; do source "$f"; done

# Install Bootstrap tools
for dir in $YAMATO_PATH/bootstrap/*; do [ -f "$dir/install.sh" ] && source "$dir/install.sh"; done

# Install Terminal tools
for dir in $YAMATO_PATH/cli/*; do [ -f "$dir/install.sh" ] && source "$dir/install.sh"; done

# Install Desktop App
for dir in $YAMATO_PATH/desktop/*; do [ -f "$dir/install.sh" ] && source "$dir/install.sh"; done

# Install Docker
if [ "$MODE" = "omakase" ] || [ "$MODE" = "interactive" ]; then
  if [ -f "$YAMATO_PATH/docker/install.$MODE.sh" ]; then
    source "$YAMATO_PATH/docker/install.$MODE.sh"
  else
    source "$YAMATO_PATH/docker/install.sh"
  fi
else
  source "$YAMATO_PATH/docker/install.sh"
fi

# Install Terminal
source $YAMATO_PATH/terminal/install.sh

# Install Browser
source $YAMATO_PATH/browser/install.sh


# Create Symlink
log_section "Create Symlinks"
for f in "$YAMATO_PATH"/dotfiles/.*; do
  base="$(basename "$f")"

  case "$base" in
    .|..|.DS_Store) continue ;;
  esac

  [ -f "$f" ] || continue

  target="$HOME/$base"

  if [ -L "$target" ]; then
    if [ "$(readlink "$target")" = "$f" ]; then
      log_synlink_skipped "$base"
    else
      rm -f "$target"
      ln -s "$f" "$target"
      log_synlink_replaced "$base"
    fi
  elif [ -e "$target" ]; then
    log_skipped "$base"
  else
    ln -s "$f" "$target"
    log_symlink "$base"
  fi
done
