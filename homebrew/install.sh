log_section "Install Homebrew"

if command -v brew >/dev/null 2>&1; then
  log_skipped "Homebrew"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  log_installed "Homebrew"
fi
