function nnn --wraps=nnn --description 'The unorthodox terminal file manager.'
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo 'nnn is already running' >&2
        return 1
    end

    set extra_plugins ~/.local/share/nnn/*
    if test (count $extra_plugins) -ge 1
        ln -srf $extra_plugins ~/.config/nnn/plugins
    end
    find ~/.config/nnn/plugins -xtype l -delete

    set shortcuts
    set --append shortcuts 'a:anki'
    set --append shortcuts 'c:-!termux-clipboard-set < "$nnn"*'
    set --append shortcuts 'C:!termux-clipboard-get > clipboard*'
    set --append shortcuts 'g:gpg'
    set --append shortcuts 'l:!lftp $REMOTE*'
    set --append shortcuts 'j:jumpdir'
    set --append shortcuts 'r:remote-browse'
    set --append shortcuts 's:tts'
    set --append shortcuts 'u:upload'
    set --append shortcuts 'v:-!less "$nnn"*'
    set --append shortcuts 'w:wallpaper'
    set --append shortcuts 'y:-!termux-clipboard-set -- "$nnn"*'
    set --append shortcuts 'Y:-!termux-clipboard-set -- "$PWD/$nnn"*'
    set --append shortcuts 'z:archive'
    set --append shortcuts '/:find'
    set --export NNN_PLUG (string join ';' $shortcuts)

    set bookmarks
    set --append bookmarks "c:$HOME/storage/internal/DCIM/Camera"
    set --append bookmarks "i:$HOME/storage/internal/Pictures/Screenshots"
    set --append bookmarks "n:$HOME/.local/share/nnn"
    set --append bookmarks "p:$HOME/projects"
    set --append bookmarks "s:$HOME/storage/sd-card/Sync"
    set --append bookmarks "w:$HOME/storage/sd-card/Sync/Pictures/Wallpapers"
    set --export NNN_BMS (string join ';' $bookmarks)

    set dir_order
    set --append dir_order "t:$HOME/downloads"
    set --export NNN_ORDER (string join ';' $dir_order)

    set --export NNN_OPTS AeNouU

    command nnn $argv

    if test -e "$HOME/.config/nnn/.lastd"
        source "$HOME/.config/nnn/.lastd"
        rm "$HOME/.config/nnn/.lastd"
    end

    return 0
end
