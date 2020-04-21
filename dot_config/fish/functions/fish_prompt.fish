# I want a fish prompt that contains the following information
#
# Key:
# []: conditional
# (): always
# [return_status] [pythonvenv] [tfws] (pwd) @ (hostname) [git] $

function transition
    set_color $argv[2]
    set_color -b $argv[1]
    set RET $argv[1]
    printf "$RIGHT_SYMBOL "
    set_color black
end


function fish_prompt
    set -l return_status $status
    set -l _basename (pwd_info | head -1)
    set -l _dirname (pwd_info / | head -2 | tail -1)
    set -l _projdir (pwd_info / | tail -1)

    set BG "green"
    set_color -b $BG
    set_color black

    printf " "         

    if pwd_is_home
        printf "~"
    end

    if not test -z $_dirname
        printf "/$_dirname"
    end

    if not test -z $_basename
        printf "/$_basename"
    end

    if not test -z "$_projdir"
        transition "yellow" $BG
        set BG "yellow"
        printf "$_projdir"
    end

    if set -q SSH_CLIENT
        transition "blue" $BG
        set BG "blue"
        printf (hostname)
    end

    if git_is_repo
        transition "cyan" $BG
        set BG "cyan"
        printf (git_branch_name)

        if git_is_dirty
            printf "\ue0b5 *"
        end
        #if git_is_stashed
            #printf "..."
        #end
        #printf (git_ahead)
    end
    

    if test "$return_status" -ne 0
        transition  "red" $BG
        set BG "red"
        printf $return_status
    end


    # Can't use transition here because of the timing of
    # resetting colors
    set_color $BG
    set_color -b black
    printf "$RIGHT_SYMBOL"
    set_color normal
    printf " "
end
