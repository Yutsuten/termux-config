function nnn --wraps=nnn --description 'The unorthodox terminal file manager.'
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo 'nnn is already running'
        return
    end
    command nnn -AeouUT v $argv

    if test -e $HOME/.config/nnn/.lastd
        source $HOME/.config/nnn/.lastd
        rm $HOME/.config/nnn/.lastd
    end
end
