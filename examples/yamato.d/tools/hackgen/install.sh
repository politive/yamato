log_section "Install HackGen Nerd Font"

TARGET_FONT="$HOME/Library/Fonts/HackGenConsoleNF-Regular.ttf"
if [ -f "$TARGET_FONT" ]; then
  log_skipped "HackGen Nerd Font"
  return 0
fi

FONT_URL="https://github.com/yuru7/HackGen/releases/download/v2.10.0/HackGen_NF_v2.10.0.zip"
TMP_DIR="$(mktemp -d)"
ZIP_PATH="$TMP_DIR/HackGen_NF_v2.10.0.zip"
FONT_DIR="$TMP_DIR/HackGen_NF_v2.10.0"

run curl -sL "$FONT_URL" -o "$ZIP_PATH"
run unzip -q "$ZIP_PATH" -d "$TMP_DIR"
run cp "$FONT_DIR/HackGenConsoleNF-Regular.ttf" ~/Library/Fonts/
run cp "$FONT_DIR/HackGenConsoleNF-Bold.ttf" ~/Library/Fonts/
log_installed "HackGen Nerd Font"

rm -rf "$TMP_DIR"
