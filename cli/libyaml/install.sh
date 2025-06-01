log_section "Install libyaml"

if [ -e "/usr/local/include/yaml.h" ] || [ -e "/opt/homebrew/include/yaml.h" ]; then
  log_skipped "libyaml"
else
  run brew install libyaml
  log_installed "libyaml"
fi
