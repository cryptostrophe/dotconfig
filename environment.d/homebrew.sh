# Homebrew
# >> http://brew.sh/

HOMEBREW_BREW_FILE="$(command -v brew)"
if [ -n "$HOMEBREW_BREW_FILE" ]; then
  export HOMEBREW_PREFIX="${HOMEBREW_BREW_FILE%/bin/brew}"
else
  return
fi
unset -v HOMEBREW_BREW_FILE

if [ "${HOMEBREW_PREFIX#*linuxbrew}" != "$HOMEBREW_PREFIX" ]; then
  # HOME-based paths for Linuxbrew
  export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
  export HOMEBREW_LOGS="$HOME/var/log/homebrew"
  export HOMEBREW_TEMP="$XDG_RUNTIME_DIR/homebrew"
fi

# Only auto-update every 10 minutes (default is 5 minutes)
export HOMEBREW_AUTO_UPDATE_SECS=600

# Use `bat` for `brew cat`
export HOMEBREW_BAT=1
export HOMEBREW_BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/config_homebrew"

# `brew bundle`
export HOMEBREW_BUNDLE_FILE="$XDG_CONFIG_HOME/brew/Brewfile"

# Delete cached files after 30 days (default is 120 days)
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30

# Print install times for each formula
export HOMEBREW_DISPLAY_INSTALL_TIMES=1

# File listing default formulae for `brew livecheck` to check
export HOMEBREW_LIVECHECK_WATCHLIST="$XDG_CONFIG_HOME/brew/livecheck_watchlist"

# `brew update` will only mention installed formulae
export HOMEBREW_UPDATE_REPORT_ONLY_INSTALLED=1

# Always use the latest stable tag (even if developer commands have been run)
export HOMEBREW_UPDATE_TO_TAG=1

# Check for macOS/iOS terminal clients w/ emoji support
case $TERM_PROGRAM in
  Apple_Terminal|iTerm*|Prompt_2|vscode)
    case "$(date +%B)" in
      "October")
        # Pumpkin Spice Homebrew!
        # >> https://twitter.com/MacHomebrew/status/783028298351730688
        HOMEBREW_INSTALL_BADGE="🎃" # $'\xf0\x9f\x8e\x83'
        ;;
      "December")
        # Santa brought me a bunch of software upgrades
        HOMEBREW_INSTALL_BADGE="🎁" # $'\xf0\x9f\x8e\x81'
        ;;
    esac
    export HOMEBREW_INSTALL_BADGE
    ;;
  *)
    # don't print beer emoji
    export HOMEBREW_NO_EMOJI=1
    ;;
esac

if [ -n "$SSH_CONNECTION" ]; then
  # make `brew home` et al. print the URL instead of launching a browser
  export HOMEBREW_BROWSER=/bin/echo
fi
