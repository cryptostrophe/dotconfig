function newwin --description 'Open a command in a new tmux window'
  argparse --name=newwin 't/title=' -- $argv

  if not in-tmux
    return 1
  else if [ (count $argv) -eq 0 ]
    command tmux new-window
    return
  end

  set -q _flag_title
  or set _flag_title (string split -r -m1 / $argv[1])[-1]

  command tmux new-window -n $_flag_title (string escape "$argv")
end