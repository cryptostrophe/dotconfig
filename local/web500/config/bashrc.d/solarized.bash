# Solarized
if [[ -z $Z_SOLARIZED ]]; then
    export Z_SOLARIZED=dark
    . "${dir_config}/bash/colour.bash"
    . "${dir_config}/bash/bashrc.d/prompt.bash"
fi