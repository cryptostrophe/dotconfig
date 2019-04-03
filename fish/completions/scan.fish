complete -c scan --no-files
complete -c scan -a wifi --description 'List all public SSIDs nearby'
complete -c scan -a ssh --description 'List all SSH-enabled hosts on the current domain'
complete -c scan -a port --description 'Track access on <port>'
complete -c scan -a pid --description 'Track access by process ID'
complete -c scan -a fs --description 'Continuous stream of file system access info'
complete -c scan -a file --description 'Track access to a file'
