_inPath keychain || return

export GPG_TTY="$(tty)"

if [[ -z $SSH_AGENT_PID ]]; then
  if [[ ! -d ~/var/run ]]; then
    mkdir -vp ~/var/run || return
  fi

  _set noclobber || trap 'set -o noclobber; trap - RETURN;' RETURN
  set +o noclobber

  if keychain_env=$(keychain --agents ssh --dir ~/var/run --eval \
                    --ignore-missing --inherit any \
                    --quick --quiet \
                    id_rsa)
  then
    eval "$keychain_env"
  fi
  
  unset -v keychain_env
fi
