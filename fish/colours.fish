# -----------------------------------------------------------------------------
# syntax highlighting
# -----------------------------------------------------------------------------

# the default color
set -g fish_color_normal normal

# the color for commands
set -g fish_color_command white --bold

# the color for quoted blocks of text
set -g fish_color_quote cyan

# the color for IO redirections
set -g fish_color_redirection yellow

# the color for process separators like ';' and '&'
set -g fish_color_end yellow

# the color used to highlight "potential errors"
set -g fish_color_error red

# the color for regular command parameters
set -g fish_color_param normal

# the color used for code comments
set -g fish_color_comment brblack --italics

# the color used to highlight matching parentheses
set -g fish_color_match magenta

# the color used when selecting text (in vi visual mode)
set -g fish_color_selection --background=brblack white

# the color used to highlight history search matches (must be a background)
set -g fish_color_search_match --background=black

# the color for parameter expansion operators like '*' and '~'
set -g fish_color_operator brcyan

# the color used to highlight character escapes like '\n' and '\x70'
set -g fish_color_escape brmagenta

# the color used for the current working directory in the default prompt
set -g fish_color_cwd brwhite

# the color used for autosuggestions
set -g fish_color_autosuggestion brblack

# the color used to print the current username in some of fish default prompts
set -g fish_color_user blue

# the color used to print the current host system in some of fish default prompts
set -g fish_color_host brblack

# the color for the '^C' indicator on a canceled command
set -g fish_color_cancel red

# -----------------------------------------------------------------------------
# completion highlighting
# -----------------------------------------------------------------------------

# the color of the prefix string, i.e. the string that is to be completed
set -g fish_pager_color_prefix brblack

# the color of the completion itself
set -g fish_pager_color_completion white

# the color of the completion description
set -g fish_pager_color_description brblack --italics

# the color of the progress bar at the bottom left corner
set -g fish_pager_color_progress blue

# the background color of the every second completion
set -g fish_pager_color_secondary --background=normal

# -----------------------------------------------------------------------------
# undocumented
# -----------------------------------------------------------------------------

set -g fish_color_valid_path blue --underline
set -g fish_color_history_current brmagenta --bold
set -g fish_color_cwd_root red

set -g fish_color_status brmagenta
set -g fish_color_dimmed normal
set -g fish_color_separator brwhite

# -----------------------------------------------------------------------------
# prompt
# -----------------------------------------------------------------------------

set -g fish_color_user_root $fish_color_cwd_root
set -g __fish_prompt_color_clock brblack
set -g __fish_prompt_color_duration --dim
set -g __fish_prompt_color_exit red
set -g __fish_prompt_color_git_branch brblack
set -g __fish_prompt_color_git_stashed brblack
set -g __fish_prompt_color_git_needs_add red
set -g __fish_prompt_color_git_needs_commit yellow
set -g __fish_prompt_color_git_needs_push cyan
set -g __fish_prompt_color_git_clean green
set -g __fish_prompt_color_jobs yellow

# -----------------------------------------------------------------------------
# LS_COLORS
# -----------------------------------------------------------------------------

set ls_colors_file "$XDG_CACHE_HOME/dircolors/thirty2k.ls_colors.fish"

if not [ -f "$ls_colors_file" ]
  cd "$XDG_CONFIG_HOME/dircolors"
  and make --quiet all
  cd -
end

set -gx LS_COLORS (string replace -a "'" "" < $ls_colors_file | string split ' ')[3]

set --erase ls_colors_file

if in-path exa
  set EXA_COLORS (string replace -a "=9" "=1;3" "$LS_COLORS")
end

if not is-gnu ls
  # Generated at http://geoff.greer.fm/lscolors/
  set -gx CLICOLOR 1
  set -gx LSCOLORS 'exFxdacabxgagaabadHbHd'
end

# -----------------------------------------------------------------------------
# colourize man pages
# -----------------------------------------------------------------------------

# begin/end "bold" mode -- used for man page headers
set -gx LESS_TERMCAP_md (set_color green)
set -gx LESS_TERMCAP_me (set_color normal)

# begin/end "underline" mode -- used to highlight variables
set -gx LESS_TERMCAP_us (set_color yellow)
set -gx LESS_TERMCAP_ue (set_color normal)

# reset everything
set -gx LESS_TERMEND (set_color normal)

# -----------------------------------------------------------------------------
# other
# -----------------------------------------------------------------------------

set -gx GCC_COLORS  "error=91:warning=33:note=34:caret=95:locus=90:quote=36"
set -gx GREP_COLORS "sl=0:cx=90:mt=4;35:ms=4;95:mc=4;35:fn=34:ln=36:bn=32:se=90"