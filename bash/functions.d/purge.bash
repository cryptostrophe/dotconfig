_isGNU find || return

purge()
{ # find and delete files under current directory

  local scope="$PWD"

  if [[ $1 == -y ]]; then
    shift
    local term="$1"
    find -H "$scope" -xtype f -iname '*'"$term"'*' -exec rm -fv {} + 2>/dev/null
  else
    printf ">> %s\n" "Searching..."
    local term="$1"
    find -H "$scope" -xtype f -iname '*'"$term"'*' -print 2>/dev/null \
    | command grep -i --colour=auto "$term"

    printf ">> %s\n" "No files deleted." \
                     "Use \`$FUNCNAME -y $1\` to confirm."
  fi
}
