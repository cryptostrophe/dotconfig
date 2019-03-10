function pp -a file --description 'Pretty-print data and source code'
  switch "$file"
  case ''
    echo >&2 'Usage: pp <file>'
    return 1
  case '*.json'
    jq . < $file
  case '*.plist'
    plutil -p $file
  case '*.fish'
    fish_indent --ansi < $file
  case '*'
    if in-path src-hilite-lesspipe.sh
      src-hilite-lesspipe.sh $file
    else
      set -l ext (string split -r -m1 . $file)[-1]
      echo >&2 "error: don't know how to print .$ext files"
      return 1
    end
  end
end
