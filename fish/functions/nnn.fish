function nnn --wraps=nnn --description 'The unorthodox terminal file manager.'
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo 'nnn is already running' >&2
        return 1
    end
    set shortcuts
    set --append shortcuts 'l:-!less "$nnn"*'
    set --append shortcuts 's:-!termux-share "$nnn"*'
    set --append shortcuts 'y:-!termux-clipboard-set "$nnn"*'
    set --export NNN_PLUG (string join ';' $shortcuts)

    set bookmarks
    set --append bookmarks 'b:~/Storage/sd-card/Documents/Backup'
    set --append bookmarks 'i:~/Storage/internal/DCIM/Screenshots'
    set --append bookmarks 'p:~/Storage/internal/DCIM/Camera'
    set --append bookmarks 's:~/Storage/sd-card/Sync'
    set --export NNN_BMS (string join ';' $bookmarks)

    command nnn -AeouUT v $argv

    if test -e "$HOME/.config/nnn/.lastd"
        source "$HOME/.config/nnn/.lastd"
        rm "$HOME/.config/nnn/.lastd"
    end
    return 0
end
