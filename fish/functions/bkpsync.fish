function bkpsync --description 'Sync files with desktop'
    argparse --ignore-unknown 'h/help' 'u/upload' 'd/download' -- $argv
    set exitcode $status

    function help
        echo 'Usage: bkpsync [options] LFTP_OPTIONS' >&2
        echo >&2
        echo '  Synopsis:' >&2
        echo '    Sync files with desktop.' >&2
        echo >&2
        echo '  Options:' >&2
        echo '    -h, --help      Show list of command-line options' >&2
        echo '    -u, --upload    Upload media files to desktop' >&2
        echo >&2
        echo '  Positional arguments:' >&2
        echo "    LFTP_OPTIONS    Options to connect to the desktop's home directory" >&2
    end

    if test $exitcode -ne 0 || set --query --local _flag_help
        help
        return $exitcode
    end

    if test -z "$argv"
        echo 'LFTP_OPTIONS is required.' >&2
        help
        return 1
    end

    set bold (tput bold)
    set reset (tput sgr0)

    set syncroot ~/storage/sd-card/Sync
    set mediaroot ~/storage/internal

    if set --query --local _flag_upload
        lftp -c "
            set cmd:fail-exit true;
            open $argv;
            set cmd:fail-exit false;
            echo $bold'(Phone > PC) Uploading files'$reset;
            mput -E -O Downloads/ $syncroot/Upload/*;
            echo $bold'(Phone > PC) Uploading photos'$reset;
            mput -E -O Downloads/ $mediaroot/DCIM/Camera/*;
            echo $bold'(Phone > PC) Uploading screenshots'$reset;
            mput -E -O Downloads/ $mediaroot/Pictures/Screenshots/*;
        "
    else if set --query --local _flag_download
        lftp -c "
            set cmd:fail-exit true;
            open $argv;
            set cmd:fail-exit false;
            echo $bold'(PC > Phone) Downloading files'$reset;
            mget -E -O ~/downloads/ Share/*;
        "
    else  # Backup Sync
        function trim_old_backup
            set keep_count $argv[1]
            set cur 0
            printf '%s\0' $argv[2..] | sort --zero-terminated --reverse | while read --null filename
                set cur (math $cur + 1)
                if test $cur -gt $keep_count
                    rm --force -- $filename
                end
            end
        end

        trim_old_backup 30 $syncroot/Backup/Phone/Contacts/*.vcf
        trim_old_backup 30 $syncroot/Backup/Phone/Calendar/*.ics
        cp -a ~/.local/environment.fish $syncroot/Backup/Phone/environment.fish

        set options --dereference --ignore-time --delete --no-perms --verbose
        lftp -c "
            set cmd:fail-exit true;
            open $argv;
            echo $bold'(Phone > PC) Syncing backup'$reset;
            mirror $options --reverse $syncroot/Backup/Phone/ Documents/Backup/Phone/;
            echo $bold'(PC > Phone) Syncing documents'$reset;
            mirror $options Documents/ $syncroot/Documents/;
            echo $bold'(PC > Phone) Syncing music'$reset;
            mirror $options Music/ $syncroot/Music/;
            echo $bold'(PC > Phone) Syncing pictures'$reset;
            mirror $options Pictures/ $syncroot/Pictures/;
            echo $bold'(PC > Phone) Syncing videos'$reset;
            mirror $options Videos/ $syncroot/Videos/;
        "
        echo $bold'Update media database'$reset
        termux-media-scan -r $syncroot
        echo $bold'Finish!'$reset
    end
    return 0
end
