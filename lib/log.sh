log_section() {
  echo ""
  echo "🚀 $1"
}

log_item() {
  echo "  $1"
}

log_installed() {
  echo "  ✅ $1 installed."
}

log_applied() {
  echo "  ✅ $1 settings applied."
}

log_symlink() {
  echo "  ✅ $1 create symlink."
}

log_synlink_replaced() {
  echo "  ♻️  $1 symlink replaced."
}

log_synlink_skipped() {
  echo "  ♻️  $1 already created. Skipping."
}

log_skipped() {
  echo "  ⏭️  $1 already installed. Skipping."
}

log_failure() {
  echo "  ❌ $1 installation failed."
}

log_dryrun() {
  echo "  📝 $1 (dry run)"
}

log_alert() {
  echo "  ❗ $1"
}
