complete -c multimarkdown -l help -d 'display this help and exit'
complete -c multimarkdown -l version -d 'display version info and exit'
complete -c multimarkdown -s b -l batch -d 'process each file separately'
complete -c multimarkdown -s f -l full -d 'force a complete document'
complete -c multimarkdown -s s -l snippet -d 'force a snippet'
complete -c multimarkdown -s c -l compatibility -d 'Markdown compatibility mode'
complete -c multimarkdown -l random -d 'use random numbers for footnote anchors'
complete -c multimarkdown -l nosmart -d 'Disable smart typography'
complete -c multimarkdown -l nolabels -d 'Disable id attributes for headers'
complete -c multimarkdown -l notransclude -d 'Disable file transclusion'
complete -c multimarkdown -l opml -d 'Convert OPML source to plain text before processing'
complete -c multimarkdown -s t -l to -d 'convert to FORMAT'
complete -c multimarkdown -s o -l output -d 'send output to FILE'
complete -c multimarkdown -s a -l accept -d 'accept all CriticMarkup changes'
complete -c multimarkdown -s r -l reject -d 'reject all CriticMarkup changes'
complete -c multimarkdown -s l -l lang -d 'language/smart quote localization'
complete -c multimarkdown -s m -l metadata-keys -d 'list all metadata keys'
complete -c multimarkdown -s e -l extract -d 'extract specified metadata key'
