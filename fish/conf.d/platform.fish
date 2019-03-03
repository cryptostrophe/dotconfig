function "macos?" --description 'Returns true if running on macOS'
  uname -s | string match -eq 'Darwin'
end

function "cygwin?" --description 'Returns true if running on Cygwin'
  uname -s | string match -eq 'CYGWIN'
end

function "linux?" --description 'Returns true if running on Linux'
  uname -s | string match -eq 'Linux'
end
