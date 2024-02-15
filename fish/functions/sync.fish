function sync --description 'Sync files with desktop'
    set rootdir ~/storage/sd-card/Sync
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
