function fish_user_key_bindings
  # This only works if [ $fish_key_bindings = "fish_default_key_bindings" ].
  # TODO: Make this work in vi or hybrid mode.
  bind '!' bind_bang
  bind '$' bind_dollar

  bind \c_ 'commandline -f repaint' # This is Ctrl + /
end