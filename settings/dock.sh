log_section "Applying Dock settings..."

defaults write com.apple.dock autohide -bool true
log_applied "Enabling auto-hide"

defaults write com.apple.dock persistent-apps -array
log_applied "Removing pinned apps"

defaults write com.apple.dock orientation -string left
log_applied "Moving Dock to left side"

defaults write com.apple.dock tilesize -int 28
log_applied "Icon Size: 28px"
