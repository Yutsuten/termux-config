function sync --description 'Sync files with desktop'
    argparse --ignore-unknown 'h/help' -- $argv
    set exitcode $status

    function help
        echo 'Usage: sync [options] LFTP_OPTIONS' >&2
        echo >&2
        echo '  Synopsis:' >&2
        echo '    Sync files with desktop.' >&2
        echo >&2
        echo '  Options:' >&2
        echo '    -h, --help      Show list of command-line options' >&2
        echo >&2
        echo '  Positional arguments:' >&2
        echo '    LFTP_OPTIONS: Options used to connect to the desktop, should connect to the home directory' >&2
    end

    if test $exitcode -ne 0 || set --query --local _flag_help
        help
        return 1
    end

    if test -z "$argv"
        echo 'LFTP_OPTIONS is required.' >&2
        help
        return 1
    end

    set bold (tput bold)
    set reset (tput sgr0)

    set rootdir ~/storage/sd-card/Sync
    set options --no-symlinks --ignore-time --delete --no-perms --exclude-glob='.*/' --verbose
    lftp -c "
        set cmd:fail-exit true;
        open $argv;
        echo $bold'(Phone > PC) Syncing backup'$reset;
        mirror $options --reverse $rootdir/Backup/Phone/ Documents/Backup/Phone/;
        echo $bold'(PC > Phone) Syncing backup'$reset;
        mirror $options Documents/Backup/Computer/ $rootdir/Backup/Computer/;
        echo $bold'(PC > Phone) Syncing music'$reset;
        mirror $options Music/ $rootdir/Music/;
        echo $bold'(PC > Phone) Syncing notes'$reset;
        mirror $options Documents/Notes/ $rootdir/Notes/;
        echo $bold'(PC > Phone) Syncing pictures'$reset;
        mirror $options Pictures/ $rootdir/Pictures/;
        echo $bold'(PC > Phone) Syncing videos'$reset;
        mirror $options Videos/ $rootdir/Videos/;
    "
    echo $bold'Update media database'$reset
    termux-media-scan -r $rootdir
    echo $bold'Finish!'$reset
    return 0
end
