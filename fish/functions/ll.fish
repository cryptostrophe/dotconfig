if in-path exa
  alias ll 'ls --long'
else
  function ll --description 'List files vertically, info-heavy'
    set params -l -h
    #           │  └─ human-readable sizes
    #           └──── long-list output

    if [ $COLUMNS -le 100 ]
      set -a params -g -o
      #              │  └─ omit owner
      #              └──── omit group
      if is-gnu ls
        # shorter timestamps
        set -a params --time-style='+%y-%m-%d %H:%M'
      end
    end

    ls $params $argv
  end
end