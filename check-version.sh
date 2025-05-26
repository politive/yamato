MACOS_VERSION=$(sw_vers -productVersion)
MACOS_MAJOR=$(echo "$MACOS_VERSION" | cut -d '.' -f 1-2)

REQUIRED_VERSION="14"

if [ "$(echo "$MACOS_MAJOR < $REQUIRED_VERSION" | bc)" = "1" ]; then
  echo "$(tput setaf 1)Error: macOS $REQUIRED_VERSION or later is required."
  echo "You are running: macOS $MACOS_VERSION"
  exit 1
fi

ARCH=$(uname -m)
if [ "$ARCH" != "arm64" ]; then
  echo "$(tput setaf 1)Error: Unsupported architecture: $ARCH"
  echo "Only Apple Silicon and Intel Macs are supported."
  exit 1
fi
