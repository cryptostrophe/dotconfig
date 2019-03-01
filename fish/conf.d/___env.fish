if not set -q ENV; and string match -eq 'fish' "$SHELL"
  # Use sh(1) to populate the environment from ~/.config/environment.d.
  # Both the -l and -i flags are needed to prevent an infinite loop.
  exec sh -l -i -c "exec $SHELL"
end
