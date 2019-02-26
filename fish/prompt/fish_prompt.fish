function fish_prompt --description 'Display the interactive prompt'
  if set -q SSH_CONNECTION
    set_color $fish_color_host
    if [ "$USER" != "$DEFAULT_USER" ]
      echo -ns $USER "@"
    end
    echo -ns (prompt_hostname) (set_color normal) ":"
  end

  echo -ns (set_color $fish_color_cwd) (prompt_pwd)

  __fish_prompt_git
  __fish_prompt_jobs

  if set -q fish_private_mode
    set color_user $fish_color_dimmed
    set glyph "?"
  else if [ (id -u) -ne 0 ]
    set color_user $fish_color_user
    set glyph "¶"
  else
    set color_user $fish_color_user_root
    set glyph "#"
  end

  echo -n (set_color $color_user) $glyph (set_color normal)
end
