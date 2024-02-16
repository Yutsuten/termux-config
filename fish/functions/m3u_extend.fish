function m3u_extend --description 'Convert m3u to extended m3u (used for Symphony)'
    argparse --max-args 1 'h/help' -- $argv
    set exitcode $status

    function help
        echo 'Usage: m3u_extend [options] PLAYLIST_DIR' >&2
        echo >&2
        echo '  Synopsis:' >&2
        echo '    Convert m3u to extended m3u.' >&2
        echo >&2
        echo '  Options:' >&2
        echo '    -h, --help      Show list of command-line options' >&2
        echo >&2
        echo '  Positional arguments:' >&2
        echo '    PLAYLIST_DIR: Directory where the m3u files are located' >&2
    end

    if test $exitcode -ne 0 || set --query --local _flag_help
        help
        return 1
    end

    if not test -d $argv[1]
        echo 'PLAYLIST_DIR must be a valid directory' >&2
        help
        return 1
    end

    set bold (tput bold)
    set reset (tput sgr0)

    set rootdir (realpath $argv[1])
    for playlist in $argv[1]/*.m3u
        set playlist_filename (basename $playlist)
        if test "$(head -n 1 $playlist)" = '#EXTM3U'
            echo $bold"Skip already converted $playlist_filename"$reset
            continue
        end
        echo $bold"Converting $playlist_filename"$reset
        mv $playlist $playlist.old
        echo '#EXTM3U' > $playlist
        while read --line music_path
            echo "#EXTINF:0,$(basename $music_path)" >> $playlist
            echo "$rootdir/$music_path" >> $playlist
        end < $playlist.old
        rm $playlist.old
        set has_update 1
    end
    if set --query --local has_update
        echo $bold'Update media database'$reset
        termux-media-scan $argv[1]/*.m3u
    end
    echo $bold'Finish!'$reset
    return 0
end
