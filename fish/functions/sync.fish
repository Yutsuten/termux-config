function sync --description 'Sync files with desktop'
    set root ~/storage/sd-card/Sync
    if test -z "$argv"
        echo 'Pass the lftp arguments to connect to the desktop.' >&2
        return 1
    end
    set options --no-symlinks --ignore-time --delete --no-perms --exclude-glob='.*/' --verbose
    lftp -c "
        set cmd:fail-exit true;
        open $argv;
        echo '(Phone > PC) Syncing backup';
        mirror $options --reverse $root/Backup/Phone/ Documents/Backup/Phone/;
        echo '(PC > Phone) Syncing backup';
        mirror $options Documents/Backup/Computer/ $root/Backup/Computer/;
        echo '(PC > Phone) Syncing music';
        mirror $options Music/ $root/Music/;
        echo '(PC > Phone) Syncing notes';
        mirror $options Documents/Notes/ $root/Notes/;
        echo '(PC > Phone) Syncing pictures';
        mirror $options Pictures/ $root/Pictures/;
        echo '(PC > Phone) Syncing videos';
        mirror $options Videos/ $root/Videos/;
    "
    echo 'Finish!'
    return 0
end
