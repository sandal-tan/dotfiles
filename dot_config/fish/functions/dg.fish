function dg
    #set project (fd -L --hidden -d 3 ".git\$" $USER_DEVELOPMENT | fzf --preview 'git --git-dir {} log --all --decorate --graph --color=always')
    set project (fd -L --hidden -d 3 ".git\$" $USER_DEVELOPMENT | fzf --preview 'git --git-dir {} log --all --decorate --graph --color=always')
    set project_path (echo $project | cut -d"." -f1)
    cd $project_path
end
