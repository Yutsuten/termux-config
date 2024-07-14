#!/data/data/com.termux/files/usr/bin/env fish
echo "How to share '$(basename $argv[1])'?"
echo
echo '  1. Save to ~/downloads (default)'
echo '  2. Save to ~/storage/internal/Download'
echo '  3. Save to ~/storage/sd-card/Download'
echo "  4. Save to $REMOTE/Downloads"
echo
read --prompt-str 'Your choice: ' choice

switch $choice
    case 1
        return 0
    case 2
        mv $argv[1] ~/storage/internal/Download
        return
    case 3
        mv $argv[1] ~/storage/sd-card/Download
        return
    case 4
        lftp -c "open $REMOTE/Downloads; put -E '$argv[1]'"
        return
end

echo 'Defaulting to ~/downloads'
