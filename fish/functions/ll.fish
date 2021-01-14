# Overrides $__fish_data_dir/functions/ll.fish
if in-path exa
    function ll --wraps exa --description 'List files vertically, info-heavy'
        ls --long $argv
    end
else
    function ll --wraps ls --description 'List files vertically, info-heavy'
        set params -l -h
        #           │  └─ human-readable sizes
        #           └──── long-list output

        if test $COLUMNS -le 100
            set -a params -g -o
            #              │  └─ omit owner
            #              └──── omit group
            if is-gnu ls
                # shorter timestamps
                set -a params --time-style=long-iso
            end
        end

        ls $params $argv
    end
end
