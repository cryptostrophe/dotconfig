_inPath direnv || return

# use ~/.local
export DIRENV_CONFIG="$dir_local/direnv"

# don't show "direnv: un/loading" messages
export DIRENV_LOG_FORMAT=""

_direnv_hook()
{   # as would have been generated by `direnv hook bash`
    # (if I weren't such a control freak)
    # and added to the beginning of PROMPT_COMMAND
    # (the rest of which is set in prompt.bash)
    eval "$(direnv export bash)";
}
