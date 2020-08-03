function __scratch_save_workspace
    set -l valid_input 0
    while test $valid_input -eq 0
        read -P "Would you like to save the workspace? [y/n]: " resp
        switch $resp 
            case y Y
                set valid_input 1
                read -P "Where would you like to save the workspace: " save_path
                # TODO check if path exists
                mv $temp_dir $save_path
            case n N
                set valid_input 1
                rm -rf $temp_dir
            case '*'
                echo "Answer must be y or n"
        end
    end
end

function scratch
    set -l temp_dir (mktemp -d)
    fish -C "cd $temp_dir"
    __scratch_save_workspace
end

