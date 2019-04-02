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

# # Old-style manual triggering of `brew cleanup`
# export HOMEBREW_NO_INSTALL_CLEANUP=1

# # Old-style manual triggering of `brew update`
# export HOMEBREW_NO_AUTO_UPDATE=1

# Only auto-update every 10 minutes (default is 60 secs, yikes)
export HOMEBREW_AUTO_UPDATE_SECS=600

# # Be verbose (for troubleshooting)
# export HOMEBREW_VERBOSE=1

# Always use the latest stable tag (even if developer commands have been run)
export HOMEBREW_UPDATE_TO_TAG=1

# Use a GUI text editor if available
export HOMEBREW_EDITOR="$VISUAL"

# Check for macOS/iOS terminal clients w/ emoji support
case $TERM_PROGRAM in
  Apple_Terminal|iTerm*|Prompt_2|Coda|vscode)
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
      *)
        HOMEBREW_INSTALL_BADGE="🍻"
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
