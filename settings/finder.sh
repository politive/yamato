defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
log_applied "Disabled .DS_Store on network drives"

defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
log_applied "Disabled .DS_Store on USB/removable drives"
