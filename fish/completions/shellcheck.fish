complete -c shellcheck -s s -d 'POSIX compliant'
complete -c shellcheck -s a -l check-sourced -d 'Include warnings from sourced files'
complete -c shellcheck -s C -l color -r -d 'Use color (auto, always, never)'
complete -c shellcheck -s e -l exclude -r -d 'Exclude types of warnings'
complete -c shellcheck -s f -l format -r -d 'Output format (checkstyle, gcc, json, tty)'
complete -c shellcheck -s s -l shell -r -d 'Specify dialect (sh, bash, dash, ksh)'
complete -c shellcheck -s S -l severity -r -d 'Minimum severity of errors to consider (error, warning, info, style)'
complete -c shellcheck -s V -l version -x -d 'Print version information and exit'
complete -c shellcheck -s W -l wiki-link-count -r -d 'The number of wiki links to show'
complete -c shellcheck -s x -l external-sources -d 'Allow \'source\' outside of FILES'
