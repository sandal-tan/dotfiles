function __wallpaper_help
    echo "\
wallpapers: Set Wallpaper and Colorscheme from CLI on macOS

Usage:
    wallpaper ls
    wallpaper ls maria_medem
    wallpaper set eloise_dorr shadows  
    wallpaper help
    wallpaper version
"
end

set -l commands set edit ls help version

function  __wallpaper_version
    echo "0.0.1"
end

function __wallpaper_set
    set -l author $argv[1]
    set -l work $argv[2]
    if not jq -r ".$author.$work" "$WALLPAPER_HOME/config.json" > /dev/null
        ansi --red "Cannot find '$work' by $author"
        return 1
    else
        set url (jq -r ".$author.$work" "$WALLPAPER_HOME/config.json")
        set img_path "$WALLPAPER_HOME/wallpapers/$author""_$work"
        if not [ -e "$img_path" ]
            revolver start "Downloading '$work' by $author"
            mkdir $WALLPAPER_HOME/wallpapers ^ /dev/null
            curl --silent "$url" > "$img_path"
            revolver stop
            ansi --green "Downloaded '$work' by $author"
        end
        m wallpaper $img_path
        cs -i "$img_path"
    end
end

function __wallpaper_ls
    set -l artist $argv[1]
    if not test -z $artist
        cat $WALLPAPER_HOME/config.json | jq ".$artist" | jq -r 'keys[]'
    else
        cat $WALLPAPER_HOME/config.json | jq -r 'keys[]'
    end
end

function wallpaper --d "Set Wallpaper and Colorscheme from CLI on macOS"

    set -l artist
    set -l work

    set -l subcommand $argv[1]

    if not test -z subcommand
        switch $subcommand
            case set
                __wallpaper_set $argv[2..-1]
            case ls
                __wallpaper_ls $argv[2..-1]
            case help
                __wallpaper_help
            case edit
                $EDITOR $WALLPAPER_HOME/config.json
            case version
                __wallpaper_version
            case '*'
                ansi --red "A subcommand must be given."""
                __wallpaper_help
                exit 1
        end
    else
        ansi --red "A subcommand must be given."""
        __wallpaper_help
        exit 1
    end
end

set -l artists (__wallpaper_ls)
complete -c wallpaper -f
complete -c wallpaper -n "__fish_seen_subcommand_from set; and __fish_seen_subcommand_from $artists" -a "(__wallpaper_ls (commandline | cut -d' ' -f3))"
complete -c wallpaper -n "not __fish_seen_subcommand_from $commands" -a "$commands"
# complete artist
complete -c wallpaper -n "__fish_seen_subcommand_from set; and not __fish_seen_subcommand_from $artists" -a "(__wallpaper_ls)"
complete -c wallpaper -n "__fish_seen_subcommand_from ls" -a "(__wallpaper_ls)"
# Complete work
