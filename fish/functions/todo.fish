function todo --description 'What to do?'
    set choice
    while true
        clear
        echo 'What to do?'
        echo
        echo '  1. Open fish'
        echo '  2. Open nnn'
        echo '  3. Open lftp'
        echo '  4. Open notes'
        echo '  5. Synchronize files'
        echo '  6. Upload files'
        echo '  7. Update termux config'
        echo '  8. Quit'
        echo
        read --line --prompt-str 'Your choice: ' choice
        switch $choice
            case 1
                fish
            case 2
                nnn
            case 3
                pushd ~/storage/sd-card/Sync && lftp $REMOTE; popd
            case 4
                nvim ~/documents/Notes.txt
            case 5
                bkpsync $REMOTE
            case 6
                bkpsync --upload $REMOTE
            case 7
                pushd ~/projects/termux-config && git pull; popd
            case 8
                echo 'Exit'
                break
        end
        read --line --prompt-str 'Press ENTER to continue...'
    end
end
