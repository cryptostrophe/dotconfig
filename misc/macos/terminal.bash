# -----------------------------------------------------------------------------
# Terminal.app
# -----------------------------------------------------------------------------

# Only use UTF-8
defaults write -app Terminal StringEncodings -array 4

# Enable Secure Keyboard Entry
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Always show tab bar
defaults write -app Terminal ShowTabBar -bool true
