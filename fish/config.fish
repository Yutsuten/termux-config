test -f ~/.local/environment.fish && source ~/.local/environment.fish

if status is-interactive
    set -gx GPG_TTY (tty)
    set -gx LESSCLOSE $HOME'/.config/termux/less/lessclose.fish %s %s'
    set -gx LESSOPEN $HOME'/.config/termux/less/lessopen.fish %s'

    set -g CDPATH . $HOME $HOME/projects
    set -g fish_color_autosuggestion white
    set -g fish_color_host brmagenta
    set -g fish_color_host_remote yellow
    set -g fish_color_user blue
    set -g fish_greeting

    abbr --add cpwd     -- 'termux-clipboard-set (string replace --regex "^$HOME" \~ $PWD)'
    abbr --add identify -- 'identify -precision 3'
    abbr --add l1       -- 'ls -N1 --sort=v --group-directories-first'
    abbr --add ll       -- 'ls -Nlh --sort=v --group-directories-first'
    abbr --add lo       -- 'ls -Noh --sort=v --group-directories-first'
    abbr --add ls       -- 'ls -N --sort=v --group-directories-first'
    abbr --add n        -- 'nnn'
end
