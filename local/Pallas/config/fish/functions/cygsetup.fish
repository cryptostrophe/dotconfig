function cygsetup --description 'Launch the Cygwin installer'
  set -l installer_dir "$HOME/Downloads/_Installers"
  set -l cyg_bin "$installer_dir/setup-x86_64.exe"
  set -l pkg_dir (cygpath -aw "$USERPROFILE/Cygwin")
  set -l log_dir "$HOME/var/log/cygwin"

  set -l cyg_root (cygpath -aw "/" | string escape)

  set -l params
  # Root installation directory (-R)
  set -a params --root $cyg_root
  # Directory to save downloaded packages in (-l)
  set -a params --local-package-dir $pkg_dir
  # Architecture to install: x86_64 or x86
  set -a params --arch x86_64
  # Semi-attended mode
  set -a params --package-manager
  # Also upgrade installed packages
  set -a params --upgrade-also
  # Don't verify setup.ini signature
  set -a params --no-verify
  # Don't create Desktop/Start menu shortcuts (-n)
  set -a params --no-shortcuts
  # Don't require admin privileges
  set -a params --no-admin

  if not test -x "$cyg_bin"
    echo >&2 "can't find $cyg_bin"
    return 1
  else if not mkdir -p "$log_dir"
    echo >&2 "can't create $log_dir"
    return 1
  else
    pushd $log_dir; and run $cyg_bin $params $argv; and popd
  end
end
