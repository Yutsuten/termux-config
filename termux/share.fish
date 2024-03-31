#$PREFIX/usr/bin/env fish
echo "How would you like to share '$argv[1]'?"
echo '  1. Save to ~/downloads (default)'
echo '  2. Save to ~/storage/internal/Download'
echo '  3. Save to ~/storage/sd-card/Download'
echo "  4. Save to $REMOTE/Downloads"
read --prompt-str 'Answer: ' answer

switch $answer
    case 1
        return 0
    case 2
        mv $argv[1] ~/storage/internal/Download
    case 3
        mv $argv[1] ~/storage/sd-card/Download
    case 4
        lftp $REMOTE/Downloads -c "put -E '$argv[1]'"
end

echo 'Defaulting to ~/downloads'
return 0
