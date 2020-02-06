# I want a fish prompt that contains the following information
#
# Key:
# []: conditional
# (): always
# [return_status] [pythonvenv] [tfws] (pwd) @ (hostname) [git] $
function fish_prompt
    set -l return_status $status
    set -l _basename (pwd_info | head -1)
    set -l _dirname (pwd_info / | head -2 | tail -1)

    printf " "

    set_color green
    if pwd_is_home
        printf "~"
    end

    if not test -z $_dirname
        printf "/$_dirname"
    end

    if not test -z $_basename
        printf "/$_basename"
    end

    set_color blue
    printf " @ $hostname "
    set_color normal

    if test "$return_status" -ne 0
        printf "["(ansi --red $return_status)"]"
    end
    
   printf "\$ " 
end
