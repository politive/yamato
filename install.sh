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
