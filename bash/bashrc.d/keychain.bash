_inPath keychain || return

export GPG_TTY="$(tty)"

if [[ -z $SSH_AGENT_PID ]]; then
  if [[ ! -d ~/var/run ]]; then
    mkdir -p ~/var/run 1>/dev/null || return
  fi

  ### ZGM disabled 2016-06-10 -- deal with it, princess
  # _isFunction . && printf "\r\e[K"

  _set noclobber || trap 'set -o noclobber; trap - RETURN;' RETURN
  set +o noclobber

  if keychain_env=$(keychain --agents ssh --dir ~/var/run --eval \
                    --ignore-missing --inherit any \
                    --quick --quiet \
                    id_rsa)
  then
    eval "$keychain_env"
    ### ZGM disabled 2016-06-10 -- deal with it, princess
    # _isFunction . && printf "\eM\e[K"
  fi
  
  unset -v keychain_env
fi
