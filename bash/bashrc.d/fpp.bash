# fpp + tmux integration
# >> https://github.com/facebook/PathPicker
# >> https://github.com/tmux-plugins/tmux-fpp

(_inTmux && _inPath fpp) || return

# add `set -g @fpp_key f` to .tmux.conf
fpp_key=$(tmux show-option -gvq "@fpp_key") || fpp_key="f"
fpp_buffer="$FPP_DIR/tmux-buffer"
fpp_log="$HOME/var/log/fpp.sh.log"

tmux bind-key "$fpp_key" \
     capture-pane -J \\\; \
     save-buffer "$fpp_buffer" \\\; \
     delete-buffer \\\; \
     new-window -n fpp -c "#{pane_current_path}" \
       "sh -c 'fpp < \"$fpp_buffer\" 2>>\"$fpp_log\"; rm \"$fpp_buffer\"'"

unset -v fpp_key fpp_buffer fpp_log
