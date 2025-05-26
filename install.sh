# Check the distribution name and version and abort if incompatible
source $YAMATO_PATH/check-version.sh

# Install Homebrew
source $YAMATO_PATH/homebrew/install.sh

# Apply MacOS Settings
for f in $YAMATO_PATH/settings/*.sh; do source "$f"; done

# Install Terminal tools
for dir in $YAMATO_PATH/terminal/*; do [ -f "$dir/install.sh" ] && source "$dir/install.sh"; done

# Install Desktop App
for dir in $YAMATO_PATH/desktop/*; do [ -f "$dir/install.sh" ] && source "$dir/install.sh"; done

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
    rm -f "$target"
    ln -s "$f" "$target"
    log_synlink_replaced "$base"
  elif [ -e "$target" ]; then
    log_skipped "$base"
  else
    ln -s "$f" "$target"
    log_symlink "$base"
  fi
done
