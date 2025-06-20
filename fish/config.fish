test -f ~/.local/environment.fish && source ~/.local/environment.fish

set -gx GPG_TTY (tty)
set -gx LESSCLOSE "$HOME/.config/less/lessclose.fish %s %s"
set -gx LESSOPEN "$HOME/.config/less/lessopen.fish %s"
set -gx EDITOR edit
set -gx VISUAL edit

set -gx GUM_CHOOSE_CURSOR ' → '
set -gx GUM_CHOOSE_CURSOR_BOLD 1
set -gx GUM_CHOOSE_CURSOR_FOREGROUND 4
set -gx GUM_CHOOSE_HEADER_FOREGROUND 6
set -gx GUM_CHOOSE_SHOW_HELP 0
set -gx GUM_CONFIRM_PROMPT_FOREGROUND 6
set -gx GUM_CONFIRM_SELECTED_BACKGROUND 4
set -gx GUM_CONFIRM_SHOW_HELP 0

set -gx FZF_DEFAULT_OPTS '--style=full --color=16,pointer:4,border:7,hl:4:bold,current-hl:4:bold,current-fg:15:bold --layout=reverse'

fish_add_path $HOME/.local/bin

if status is-interactive
    if test -z "$MENU_OPEN"
        set -gx MENU_OPEN 1
        exec ~/bin/menu
    end

    set -g CDPATH . $HOME $HOME/projects
    set -g fish_color_autosuggestion white
    set -g fish_color_host brmagenta
    set -g fish_color_host_remote yellow
    set -g fish_color_user blue
    set -g fish_greeting

    abbr --add calc -- 'bc -l'
    abbr --add cpwd -- 'termux-clipboard-set (string replace --regex "^$HOME" \~ $PWD)'
    abbr --add identify -- 'identify -precision 3'
    abbr --add l1 -- 'ls -N1 --sort=v --group-directories-first'
    abbr --add ll -- 'ls -Nlh --sort=v --group-directories-first'
    abbr --add lo -- 'ls -Noh --sort=v --group-directories-first'
    abbr --add n -- nnn
end
