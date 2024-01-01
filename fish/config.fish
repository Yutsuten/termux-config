if test -f ~/.local/environment
    export (grep -E '^[^#;].+=.*' ~/.local/environment | xargs -L 1)
end

if status is-interactive
    set -gx GPG_TTY (tty)
    set -g fish_greeting
end
