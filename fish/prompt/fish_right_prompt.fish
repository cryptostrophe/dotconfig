function fish_right_prompt --description 'Display the right side of the interactive prompt'
  set -l exit $status
  set -l time $CMD_DURATION

  if test $exit -ne 0
    set_color $fish_prompt_color_exit
    __fish_right_prompt_signal $exit
    echo -ns (set_color normal) " "
  end

  begin
    set_color $fish_prompt_color_duration
    __fish_right_prompt_timer $time
    and echo -ns (set_color normal) " "
  end

  if test -n "$__fish_prompt_show_vi_mode"
    __fish_right_prompt_mode
  end
end
