if test -f ~/.local/environment
    export (grep -E '^[^#;].+=.*' ~/.local/environment | xargs -L 1)
end

if status is-interactive
    set -gx GPG_TTY (tty)
    set -gx LESSCLOSE $HOME'/.config/termux/less/lessclose.fish %s %s'
    set -gx LESSOPEN $HOME'/.config/termux/less/lessopen.fish %s'

    set -g CDPATH . $HOME $HOME/Projects
    set -g fish_color_autosuggestion white
    set -g fish_color_host brmagenta
    set -g fish_color_host_remote yellow
    set -g fish_color_user blue
    set -g fish_greeting

    alias identify 'identify -precision 3'
    alias n 'nnn'
    alias notes 'nvim -S ~/Desktop/Session.vim'
end
