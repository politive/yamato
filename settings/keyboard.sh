log_section "Applying keyboard settings..."

defaults write -g InitialKeyRepeat -int 15
log_applied "InitialKeyRepeat: 15"

defaults write -g KeyRepeat -int 2
log_applied "KeyRepeat: 2"

defaults write com.apple.inputmethod.Kotoeri JIMPrefLiveConversionKey 0
log_applied "Disabling live conversion (Japanese input)"

defaults write com.apple.inputmethod.Kotoeri JIMPrefAutocorrectionKey 0
log_applied "Disabling autocorrection (Japanese input)"

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
log_applied "Disabling automatic capitalization"

