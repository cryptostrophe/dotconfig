# -----------------------------------------------------------------------------
# header
# -----------------------------------------------------------------------------

if [[ ${BASH_VERSINFO[0]} -lt 4 ]]; then
    return
fi

# TODO:
# - comments

# instructions

# configuration

_z_bg="${solarized:-dark}"

# -----------------------------------------------------------------------------
# colours
# -----------------------------------------------------------------------------

if [[ -z $_z_rst ]] && _z_rst="$(tput sgr0 2>/dev/null)"; then
    read _z_{blk,red,grn,yel,blu,mag,cyn,wht} \
    < <(for i in {0..7}; do tput setaf $i; printf '\t'; done)
fi

_z_true="$_z_grn"
_z_false="$_z_red"

_z_alias_name="$_z_blu"
_z_alias_value="$_z_cyn"
_z_function_name="$_z_blu"
_z_function_file="$_z_grn"
_z_function_line="$_z_yel"
_z_special_name="$_z_mag"
_z_file_name="$_z_yel"
_z_file_path="$_z_grn"
_z_var_name="$_z_blu"
_z_var_value="$_z_cyn"

_z_man_cmd="${LESS_TERMCAP_md:-$_z_grn}"
_z_man_var="${LESS_TERMCAP_us:-$_z_yel}"

case $_z_bg in
    dark)
        _z_punct="$_z_wht"
        ;;
    light)
        _z_punct="$_z_blk"
        _z_true="$_z_cyn"
        ;;
    *)
        _z_punct="$_z_rst"
        ;;
esac

# -----------------------------------------------------------------------------
# secondary functions
# -----------------------------------------------------------------------------

# helper functions

zhelp::print()
{   # echo to stdout
    if [[ -t 1 ]]; then
        printf "${_z_rst}%b${_z_rst}" "$@"
    else
        # strip colours if we're in a pipe or something
        printf "%b" "$@" \
        | sed -E "s|\[[0-9;]*m?||g"
    fi
}

zhelp::scold()
{   # echo to stderr
    zhelp::print "$@\n" >&2
}

zhelp::shoptSet()
{   # return 0 if all shell options in $@ are set
    shopt -pq $*
}

zhelp::isFunction()
{   # return 0 if $1 is defined as a shell function
    declare -f "$1" &>/dev/null
}

# info functions

zhelp::help()
{   # return a short description of $1 (via `help`)

    declare thing="$1" help_string name desc

    builtin help -d "$thing" &>/dev/null \
        || return

    while read help_string; do
        name="${help_string% - *}"
        desc="${help_string#* - }"

        if [[ -n $name && -n $desc ]]; then
            zhelp::print "${_z_special_name}${name}"
            zhelp::print "${thing_type:+ ($thing_type)}${_z_punct}: "
            zhelp::print "${desc}\n"
        fi
    done < <(builtin help -d "$thing" 2>/dev/null)
}

zhelp::file()
{
    declare name="$1" filename

    if [[ $_all == true ]]; then
        declare -a filenames=($(type -ap "$name"))
    else
        declare -a filenames=($(type -p "$name"))
    fi

    for filename in ${filenames[@]}; do
        if [[ $_short == true ]]; then
            zhelp::print "${filename}\n"
        else
            zhelp::print "${_z_file_name}${name}"
            zhelp::print " is "
            zhelp::print "${_z_file_path}${filename}"
            zhelp::print "\n"
        fi
    done
}

zhelp::alias()
{
    declare name="$1" target

    target="$(builtin alias "$name")" \
        || return

    target="${target#*=\'}"         # remove beginning
    target="${target%\'}"           # remove end
    target="${target//\'\\\'\'/\'}" # unescape single quotes
    target="${target//\\/\\\\}"     # escape backslashes

    if [[ -n $target ]]; then
        if [[ $_short == true ]]; then
            zhelp::print "${target}\n"
        else
            zhelp::print "${_z_alias_name}${name} "
            zhelp::print "is aliased to '"
            zhelp::print "${_z_alias_value}${target}"
            zhelp::print "'\n"
        fi
    fi
}

zhelp::where()
{   # return filename and line number where function $1 was defined

    declare func="$1" location line _extdebug_toggled

    if ! zhelp::isFunction "$func"; then
        zhelp::scold "${_z_false}${func}${_z_rst}: not a function"
        return 1
    fi

    # enable debugging behaviour if necessary
    if ! zhelp::shoptSet extdebug; then
        shopt -s extdebug \
            && _extdebug_toggled='true'
    fi

    location="$(declare -F "$func")"    # get [name] [line no.] [file path]
    location="${location#$func }"       # remove function name
    line="${location% *}"               # isolate line number
    location="${location#* }"           # remove line number

    zhelp::print "${_z_function_file}${location}"
    zhelp::print "${_z_punct}:"
    zhelp::print "${_z_function_line}${line}"

    # disable debugging behaviour if we enabled it
    if [[ $_extdebug_toggled == true ]]; then
        shopt -u extdebug
    else
        return 0
    fi
}

zhelp::function()
{
    declare func="$1"

    # display source file and line number
    zhelp::where "$func"
    zhelp::print "\n"

    # print source, colourizing function name
    declare -f "$func" \
    | sed -E "s/^${func}\b/${_z_function_name}\0${_z_rst}/"
}

zhelp::whatis()
{   # return a short description of $1 (via the whatis database)

    declare thing="$1" line _extglob_toggled _found='false'
    declare regex_fail='nothing appropriate$'
    declare regex_pass="^${thing}[[:space:](]"
    declare regex_trouble='[]\[()]'

    # escape characters that sed won't like
    if [[ $thing =~ $regex_trouble ]]; then
        printf -v thing '%q' "$thing"
    fi

    # check whatis database
    while read line; do
        # if not found in whatis database
        [[ $line =~ $regex_fail ]] \
            && continue

        # skip non-whole-word matches
        [[ ! $line =~ $regex_pass ]] \
            && continue

        # skip builtins
        [[ $line =~ 'built-in command' ]] \
            && continue

        _found='true'

        echo "$line" \
        | sed -E "s/^(${thing,,})[^\(]*(\([[:alnum:]]+\))[[:space:]-]+(.*)/${_z_file_name}\1${_z_rst}\2${_z_punct}:${_z_rst} \3/g"

    done < <(command whatis "$thing")

    [[ $_found == true ]]
}

zhelp::variable()
{   # like `type`, but for variables

    declare var="$1" article="a" var_type="variable"
    declare var_{flags,nature,property,content} string

    # disable case-sensitive matching if necessary
    if zhelp::shoptSet nocasematch; then
        shopt -u nocasematch \
            && declare _nocasematch_toggled='true'
    fi

    if ! string=$(declare -p "$var" 2>/dev/null); then
        [[ $_nocasematch_toggled == true ]] \
            && shopt -s nocasematch
        return 1
    fi

    string="${string/#declare }"
    var_flags="${string%% *}"
    var_value="${string#*=}"

    case $var_flags in
        *a*)    var_type="indexed array"     ;;&
        *A*)    var_type="associative array" ;;&
        *i*)    var_content="integer"   ;;&
        *r*)    var_property+="${var_property:+, }read-only" ;;&
        *t*)    var_property+="${var_property:+, }traced"    ;;&
        *x*)    var_property+="${var_property:+, }exported"  ;;&
        *l*)    var_content="lowercase" ;;&
        *u*)    var_content="uppercase" ;;&
        *)      : ;;
    esac

    var_nature="${var_property:+$var_property }${var_content:+$var_content }${var_type}"

    if [[ $var_value == '""' ]]; then
        var_nature="null ${var_nature}"
    elif [[ $var_value == "'()'" ]]; then
        var_nature="empty ${var_nature}"
    fi

    if [[ ${var_nature:0:1} =~ [aeiou] ]]; then
        article+="n"
    fi

    zhelp::print "${_z_var_name}${var} "
    zhelp::print "is ${article} ${var_nature}\n"

    # enable case-sensitive matching if we enabled it
    if [[ $_nocasematch_toggled == true ]]; then
        shopt -s nocasematch
    else
        return 0
    fi
}

# -----------------------------------------------------------------------------
# main functions
# -----------------------------------------------------------------------------

zhelp::define()
{
    declare thing="$1" thing_type="$2"

    if [[ -z $thing_type ]]; then
        # get the type (alias/keyword/function/builtin/file)
        thing_type=$(type -t "$thing" 2>/dev/null)
    fi

    case $thing_type in
        keyword|builtin)
            zhelp::print "${_z_special_name}${thing}"
            zhelp::print " is a shell ${thing_type}\n"
            ;;
        alias)
            zhelp::alias "$thing"
            ;;
        function)
            zhelp::print "${_z_function_name}${thing} "
            zhelp::print "is a function"
            zhelp::print " ("
            zhelp::where "$thing"
            zhelp::print ")"
            zhelp::print "\n"
            ;;
        file)
            zhelp::file "$thing"
            ;;
        *)
            return 1
            ;;
    esac
}

zhelp::describe()
{
    declare thing="$1" thing_type="$2"

    if [[ -z $thing_type ]]; then
        # get the type (alias/keyword/function/builtin/file)
        thing_type=$(type -t "$thing" 2>/dev/null)
    fi

    case $thing_type in
        keyword|builtin)
            zhelp::help "$thing"
            ;;
        alias)
            zhelp::alias "$thing"
            ;;
        function)
            zhelp::function "$thing"
            ;;
        file)
            zhelp::whatis "$thing"
            ;;
        *)
            return 1
            ;;
    esac
}

zhelp::wtf()
{
    while [[ $1 =~ ^- ]]; do
        case $1 in
            -a|--all)
                declare _all='true'
                shift
                ;;
            -s|--short)
                declare _short='true'
                shift
                ;;
            *)
                break 2
                ;;
        esac
    done

    declare thing="$1" thing_type whatis_string

    if [[ $_all == true ]]; then
        declare -a thing_types=($(type -at "$thing" | uniq))
    else
        declare -a thing_types=($(type -t "$thing"))
    fi

    if [[ ${#thing_types[@]} -gt 0 ]]; then
        for thing_type in ${thing_types[@]}; do
            case ${FUNCNAME[1]} in
                *which)
                    zhelp::define "$thing" "$thing_type"
                    ;;
                *what)
                    zhelp::describe "$thing" "$thing_type"
                    ;;
                *)
                    return 1
                    ;;
            esac
        done

        return 0
    elif [[ ${FUNCNAME[1]} =~ what ]]; then
        # system libraries & other non-command man pages
        zhelp::whatis "$thing" \
            && return 0

        # edge-case shell syntax items
        zhelp::help "$thing" \
            && return 0

        # variables
        zhelp::variable "$thing" \
            && return 0
    fi

    zhelp::scold "${_z_false}${thing}${_z_rst}: not found"
    return 1
}

# -----------------------------------------------------------------------------

for alias in which what where; do
    alias $alias &>/dev/null \
        && unalias $alias
done

unset alias

which() { zhelp::wtf "$@"; }
what()  { zhelp::wtf "$@"; }

where() {
    zhelp::where "$@" \
        && zhelp::print "\n"
}

whatvar()
{
    if [[ $# -eq 0 ]]; then
        zhelp::scold "Usage: ${_z_man_cmd}${FUNCNAME} ${_z_man_var}variable_name${_z_rst}"
        return 1
    fi

    declare objectvar="$1" var_type array

    if zhelp::variable "$objectvar"; then
        var_type="$(zhelp::variable "$objectvar")"

        case $var_type in
            *null*|*empty*)
                return 0
                ;;
            *variable)
                zhelp::print "${_z_var_value}${!objectvar//\\e}\n"
                ;;
            *array)
                array="$(declare -p "$objectvar")"
                array="${array#*\'(}"    # strip leading info
                array="${array%)\'}"     # strip trailing single-quote

                zhelp::print "${_z_var_value}${array}\n"
                ;;
        esac
    else
        zhelp::scold "${_z_false}${objectvar}${_z_rst} is not set"
        return 1
    fi
}
