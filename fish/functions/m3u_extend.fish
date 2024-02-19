function m3u_extend --description 'Convert m3u to extended m3u (used for Symphony)'
    argparse --max-args 2 'h/help' -- $argv
    set exitcode $status

    function help
        echo 'Usage: m3u_extend [options] INPUT_DIR OUTPUT_DIR' >&2
        echo >&2
        echo '  Synopsis:' >&2
        echo '    Convert m3u to extended m3u.' >&2
        echo >&2
        echo '  Options:' >&2
        echo '    -h, --help      Show list of command-line options' >&2
        echo >&2
        echo '  Positional arguments:' >&2
        echo '    INPUT_DIR       Directory where the m3u files and music are located' >&2
        echo '    OUTPUT_DIR      Directory to put the converted m3u files' >&2
    end

    if test $exitcode -ne 0 || set --query --local _flag_help
        help
        return 1
    end

    if not test -d $argv[1]
        echo 'INPUT_DIR must be a valid directory' >&2
        help
        return 1
    end
    if not test -d $argv[2]
        echo 'OUTPUT_DIR must be a valid directory' >&2
        help
        return 1
    end
    if test (realpath argv[1]) = (realpath argv[2])
        echo 'INPUT_DIR and OUTPUT_DIR cannot point to the same directory' >&2
        help
        return 1
    end

    set bold (tput bold)
    set reset (tput sgr0)

    set rootdir (realpath $argv[1])
    for input in $argv[1]/*.m3u
        set input_filename (basename $input)
        set output $argv[2]/$input_filename
        if test "$(head -n 1 $input)" = '#EXTM3U'
            echo $bold"Copy already converted $input_filename"$reset
            cp --archive $input $output
            continue
        end
        echo $bold"Converting $input_filename"$reset
        echo '#EXTM3U' > $output
        while read --line music_path
            echo "#EXTINF:0,$(basename $music_path)" >> $output
            echo "$rootdir/$music_path" >> $output
        end < $input
        set has_update 1
    end
    if set --query --local has_update
        echo $bold'Update media database'$reset
        termux-media-scan $argv[2]/*.m3u
    end
    echo $bold'Finish!'$reset
    return 0
end
