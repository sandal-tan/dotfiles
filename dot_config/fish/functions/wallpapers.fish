function wallpapers
    set author $argv[1]
    set work $argv[2]
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

