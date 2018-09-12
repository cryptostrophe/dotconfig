_inPath dayone || return

d1import()
{ #: imports a file into Day One
  #: $ d1import <file>
  local entry_file="$1"
  local entry_date

  if [[ -z $entry_file ]]; then
    fx_usage >&2
    return 64
  elif [[ -r $entry_file ]]; then
    if entry_date=$(stat --printf=%y "$entry_file"); then
      dayone -d="$entry_date" new < "$entry_file"
    else
      scold "${FUNCNAME[0]}: failed to get date from $entry_file"
      return 65
    fi
  else
    scold "${FUNCNAME[0]}: failed to read $entry_file"
    return 74
  fi
}
