# -----------------------------------------------------------------------------
# Localization: Canadian English, UTF-8
# -----------------------------------------------------------------------------

if [ -z "$LANGUAGE" ]; then
  export LANGUAGE='en_CA:en_US:en'
fi

# LANG: used as a substitute for any unset LC_* variable.
# Some systems have 'en_CA.UTF-8', some have 'en_CA.utf8' -- search locales
# to find whichever is available, and cache the result.
lang_file="$XDG_DATA_HOME/locale/LANG"

if [ ! -f "$lang_file" ]; then
  mkdir -pv "${lang_file%/*}"
  locale -a 2>/dev/null \
  | command grep -Ei "${LANGUAGE%%:*}\\.utf-?8" \
  > "$lang_file"
fi

if [ -z "$LANG" ]; then
  read -r LANG < "$lang_file"
fi

unset -v lang_file

if [ -z "$LC_ALL" ]; then
  # LC_COLLATE="$LANG"  # collation information for regular expressions and sorting
  # LC_CTYPE="$LANG"    # character type and classification information
  # LC_MESSAGES="$LANG" # conventions for messages, incl. yes/no responses
  # LC_MONETARY="$LANG" # money-related numeric formatting
  # LC_NUMERIC="$LANG"  # other numeric formatting (e.g. thousands separator)
  # LC_TIME="$LANG"     # date and time formatting
  export LC_ALL="$LANG" # overrides the above (in most cases)
fi

# time zone
if [ -z "$TZ" ]; then
  export TZ='America/Edmonton'
fi

if [ -z "$TIME_STYLE" ]; then
  export TIME_STYLE='long-iso'
fi
