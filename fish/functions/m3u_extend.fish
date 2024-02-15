function m3u_extend --description 'Convert m3u to extended m3u (used for Symphony)'
    argparse --max-args 1 'h/help' -- $argv
    or return

    if set -ql _flag_help
        echo 'Usage: m3u_extend [-h|--help] PLAYLIST_DIR' >&2
        return 0
    end

    if not test -d $argv[1]
        echo 'PLAYLIST_DIR must be a valid directory' >&2
        echo 'Usage: m3u_extend [-h|--help] PLAYLIST_DIR' >&2
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
    if set -ql has_update
        echo $bold'Update media database'$reset
        termux-media-scan $argv[1]/*.m3u
    end
    echo $bold'Finish!'$reset
    return 0
end
