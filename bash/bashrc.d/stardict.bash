# StarDict
# http://sdcv.sourceforge.net/

# Used for Webster's access, see ../functions.d/dictionary.bash

_inPath sdcv || return

export STARDICT_DATA_DIR="${HOME}/share/dict/stardict"
export SDCV_HISTSIZE=0
export SDCV_PAGER=$PAGER