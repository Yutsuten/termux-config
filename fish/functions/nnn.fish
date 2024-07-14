function nnn --wraps=nnn --description 'The unorthodox terminal file manager.'
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo 'nnn is already running' >&2
        return 1
    end
    set shortcuts
    set --append shortcuts 'f:!lftp $REMOTE*'
    set --append shortcuts 'l:-!less "$nnn"*'
    set --append shortcuts 'u:upload'
    set --append shortcuts 'y:-!termux-clipboard-set "$nnn"*'
    set --append shortcuts 'Y:-!termux-clipboard-set "$PWD/$nnn"*'
    set --export NNN_PLUG (string join ';' $shortcuts)

    set bookmarks
    set --append bookmarks 'b:~/storage/sd-card/Documents/Backup'
    set --append bookmarks 'i:~/storage/internal/Pictures/Screenshots'
    set --append bookmarks 'p:~/storage/internal/DCIM/Camera'
    set --append bookmarks 's:~/storage/sd-card/Sync'
    set --export NNN_BMS (string join ';' $bookmarks)

    command nnn -AeouUT v $argv

    if test -e "$HOME/.config/nnn/.lastd"
        source "$HOME/.config/nnn/.lastd"
        rm "$HOME/.config/nnn/.lastd"
    end
    return 0
end
