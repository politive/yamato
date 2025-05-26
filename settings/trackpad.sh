log_section "Apply Trackpad settings"

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
log_applied "Enabling tap-to-click for built-in trackpad"

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
log_applied "Enabling tap-to-click for external Bluetooth trackpads"

defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
log_applied "Enabling tap-to-click system-wide"
