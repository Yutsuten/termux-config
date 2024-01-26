if test -f ~/.local/environment
    export (grep -E '^[^#;].+=.*' ~/.local/environment | xargs -L 1)
end

if status is-interactive
    set -gx GPG_TTY (tty)
    set -gx LESSOPEN $HOME'/.config/termux/less/lessopen.fish %s'
    set -gx LESSCLOSE $HOME'/.config/termux/less/lessclose.fish %s %s'
    set -g fish_greeting
end
