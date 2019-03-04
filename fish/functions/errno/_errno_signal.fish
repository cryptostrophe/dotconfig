function _errno_signal --argument num
  test "$num" -gt 128 -a "$num" -le 165
  or return

  # Source: `kill -l`
  set -l signals HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE \
                 ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ \
                 VTALRM PROF WINCH INFO USR1 USR2

  # Source: https://www.gnu.org/software/libc/manual/html_node/Standard-Signals.html#Standard-Signals
  # {{{
    # Program error signals
    set -l sigFPE "Fatal arithmetic error"
    set -l sigILL "Illegal instruction"
    set -l sigSEGV "Segmentation violation"
    set -l sigBUS "Invalid pointer dereferenced"
    set -l sigABRT "The program itself detected an error and aborted"
    set -l sigTRAP "Generated by the machine's breakpoint instruction"
    set -l sigEMT "Unimplemented instruction in emulator, or other emulation failure"
    set -l sigSYS "Bad system call"

    # Termination signals
    set -l sigTERM "A 'polite' request to cause program termination"
    set -l sigINT "Program interrupt"
    set -l sigQUIT "Quit & produce core dump"
    set -l sigKILL "Fatal, unblockable termination"
    set -l sigHUP "Hang up: report disconnected terminal"

    # Alarm signals
    set -l sigALRM "Timer expired (real or clock time)"
    set -l sigVTALRM "Virtual timer expired (current process's CPU time)"
    set -l sigPROF "Profiling timer expired (system/process CPU time)"

    # Asynchronous I/O signals
    set -l sigIO "File descriptor ready for I/O"
    set -l sigURG "Urgent or out-of-band data has arrived on a socket"

    # Job control signals
    set -l sigCHLD "Child process has terminated"
    set -l sigCONT "Make a stopped process continue"
    set -l sigSTOP "Stop the process"
    set -l sigTSTP "Interactive stop signal"
    set -l sigTTIN "Background process has tried to read from terminal"
    set -l sigTTOU "Background process has tried to write to the terminal"

    # Operation error signals
    set -l sigPIPE "Broken pipe"
    set -l sigXCPU "CPU time limit exceeded"
    set -l sigXFSZ "File size limit exceeded"

    # Miscellaneous
    set -l sigWINCH "Window size has changed"
    set -l sigINFO "Information request"
    set -l sigUSR1 "User-defined signal"
    set -l sigUSR2 "User-defined signal"
  # }}}

  set -l signal $signals[(math "$num - 128")]
  echo -es "SIG" $signal "\n    " (eval "echo \$sig$signal") "."
end