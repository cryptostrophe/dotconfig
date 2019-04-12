# bat <https://github.com/sharkdp/bat>
# Generated using help2man and fish_update_completions
complete -c bat -s l -l language -x -d 'Explicitly set the language for syntax highlighting'
complete -c bat -l list-languages -d 'Display a list of supported languages for syntax highlighting'
complete -c bat -s m -l map-syntax -d 'Map a file extension or file name to an existing syntax'
complete -c bat -l theme -d 'Set the theme for syntax highlighting'
complete -c bat -l list-themes -d 'Display a list of supported themes for syntax highlighting'
complete -c bat -l style -d 'Configure which elements to display in addition to file contents'
complete -c bat -s p -l plain -d 'Only show plain style, no decorations'
complete -c bat -s n -l number -d 'Only show line numbers, no other decorations'
complete -c bat -s A -l show-all -d 'Show non-printable characters like space, tab or newline'
complete -c bat -s r -x -l line-range -d 'Only print the specified range of lines for each file'
complete -c bat -s H -x -l highlight-line -x -d 'Highlight the N-th line with a different background color'
complete -c bat -l color -x -a 'auto never always' -d 'Specify when to use colored output'
complete -c bat -l italic-text -x -a 'always never' -d 'Specify when to use italic text in the output'
complete -c bat -l decorations -x -a 'auto never always' -d 'Specify when to use decorations specified via "--style"'
complete -c bat -l paging -x -a 'auto never always' -d 'Specify when to use the pager'
complete -c bat -l pager -x -d 'Determine which pager is used'
complete -c bat -l wrap -x -a 'auto never character' -d 'Specify the text-wrapping mode'
complete -c bat -l tabs -x -d 'Set the tab width to T spaces'
complete -c bat -s u -l unbuffered -d 'This option exists for POSIX-compliance reasons'
complete -c bat -l terminal-width -x -d 'Explicitly set the width of the terminal'
complete -c bat -s h -l help -d 'Print this help message'
complete -c bat -s V -l version -d 'Show version information'