function tag_if_defined
    set VAR $argv[1]
    set BACKGROUND $argv[2]
    if not test -z $argv[4]
        set ICON $argv[4]
    end
    if set -q $VAR
        set BODY (fish -c "$argv[3]")
        set_color $BACKGROUND
        printf "$LEFT_SYMBOL"
        set_color -b $BACKGROUND
        set_color black
        printf " $BODY "
        if set -q ICON
            printf "$ICON"
        end
        set_color normal
        set_color $BACKGROUND
        printf "$RIGHT_SYMBOL"
        set_color normal
    end
end

#function print_venv
    #if not test -z $VIRTUAL_ENV
        #set_color blue
        #printf "$LEFT_SYMBOL"
        #set_color black -b blue
        #printf " "(basename $VIRTUAL_ENV)" "
        #set_color normal
        #set_color blue
        #printf "$RIGHT_SYMBOL"
        #set_color normal
    #end
#end


function fish_right_prompt
    tag_if_defined VIRTUAL_ENV "blue" "basename \$VIRTUAL_ENV" "\uF81F"
    printf " "
end
