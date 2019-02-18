function __fish_right_prompt_signal --description 'Converts an exit code into a named signal or sysexit'
  set -l code $argv[1]

  # Source: `kill -l`
  set -l signals  HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE \
                  ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ \
                  VTALRM PROF WINCH INFO USR1 USR2
  # Source: `man 3 sysexits`
  set -l sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
                  OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  if test $code -gt 128 -a $code -le 165
    echo -n $signals[(math "$code - 128")]
  else if test $code -ge 64 -a $code -le 78
    echo -n $sysexits[(math "$code - 63")]
  else
    echo -n $code
  end
end
