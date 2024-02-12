function sync --description 'Sync files with desktop'
    set root ~/storage/sd-card/Sync
    if test -z "$argv"
        echo 'Pass the lftp arguments to connect to the desktop.' >&2
        return 1
    end
    set bold (tput bold)
    set reset (tput sgr0)
    set options --no-symlinks --ignore-time --delete --no-perms --exclude-glob='.*/' --verbose
    lftp -c "
        set cmd:fail-exit true;
        open $argv;
        echo $bold'(Phone > PC) Syncing backup'$reset;
        mirror $options --reverse $root/Backup/Phone/ Documents/Backup/Phone/;
        echo $bold'(PC > Phone) Syncing backup'$reset;
        mirror $options Documents/Backup/Computer/ $root/Backup/Computer/;
        echo $bold'(PC > Phone) Syncing music'$reset;
        mirror $options Music/ $root/Music/;
        echo $bold'(PC > Phone) Syncing notes'$reset;
        mirror $options Documents/Notes/ $root/Notes/;
        echo $bold'(PC > Phone) Syncing pictures'$reset;
        mirror $options Pictures/ $root/Pictures/;
        echo $bold'(PC > Phone) Syncing videos'$reset;
        mirror $options Videos/ $root/Videos/;
    "
    echo $bold'Finish!'$reset
    return 0
end
