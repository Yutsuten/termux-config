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

    set rootdir (realpath $argv[1])
    for playlist in $argv[1]/*.m3u
        set playlist_filename (basename $playlist)
        echo "Converting $playlist_filename"

        mv $playlist $playlist.old
        echo '#EXTM3U' > $playlist
        while read --line music_path
            echo "#EXTINF:0,$(basename $music_path)" >> $playlist
            echo "$rootdir/$music_path" >> $playlist
        end < $playlist.old
        rm $playlist.old
    end
    echo 'Update media database'
    termux-media-scan $argv[1]/*.m3u
    echo 'Finish!'
    return 0
end
