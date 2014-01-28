# -----------------------------------------------------------------------------
# ~zozo/.config/bash/functions
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

_inPath()
{   # exits 0 if $1 is installed in $PATH
    builtin type -P "$1" &>/dev/null
}

_isGNU()
{   # exits 0 if $1 uses GNU switches
    command "$1" --version &>/dev/null
}

_isFunction()
{   # exits 0 if $1 is defined as a function
    declare -f "$1" &>/dev/null
}

_isAlias()
{   # exits 0 if $1 is defined as an alias
    builtin alias "$1" &>/dev/null
}

_shoptSet()
{   # exits 0 if shell option $1 is set
    [[ $BASHOPTS =~ $1 ]]
}

getPath()
{   # returns the full path to $1
    builtin type -P "$1" 2>/dev/null
}

getGNU()
{   # return the path to the GNU version of $1, if available
    declare bin="$1"

    _isGNU "$bin" && {
        echo "$bin"
    } || {
        getPath "g$bin"
    }
}

scold()
{   # echo to standard error
    # Usage: scold [source] "message"

    printf "%b\n" >&2 "${2+$1: }${2-$1}"
}

z_require()
{
    declare switches='^-[adg]$'
    declare switch="$1" object="$2"

    [[ $switch =~ $switches ]] && [[ $# -eq 2 ]] || {
        scold "Usage: $FUNCNAME [-a application] [-d directory] [-g gnu_application]"
        return 1
    }

    case $1 in
        -a)
            _inPath "$object" || return 1
            ;;
        -d)
            [[ -d "$object" ]] || return 1
            ;;
        -g)
            getGNU "$object" &>/dev/null || return 1
            ;;
    esac
}

# -----------------------------------------------------------------------------
# separate function files
# -----------------------------------------------------------------------------

for subFile in $dir_config/bash/functions/*; do
    _source "$subFile"
    [[ $theseFunctions ]] && {
        export -f ${theseFunctions[@]} &>/dev/null
        unset theseFunctions
    }
done

# -----------------------------------------------------------------------------

fe()
{   # find and edit a function
    [[ $# -eq 1 ]] || return 1

    declare func="$1" sourceFile

    declare -f "$func" &>/dev/null || {
        printf "%s: %s: function not defined\n" "$FUNCNAME" "$func" 1>&2
        return 1
    }

    sourceFile="$(where "$func" | colourstrip | cut -d: -f1)"

    _edit "${sourceFile/#~/$HOME}"
}

