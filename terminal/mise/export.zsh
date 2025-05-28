eval "$(mise activate zsh)"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/libpq/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/libpq/include $CPPFLAGS"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig:$PKG_CONFIG_PATH"
