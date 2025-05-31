log_section "Install libyaml"

if brew list libyaml &>/dev/null; then
  log_skipped "libyaml"
else
  run brew install libyaml
  log_installed "libyaml"
fi
