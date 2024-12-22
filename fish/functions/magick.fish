function magick --wraps=magick
    command magick $argv
    or return
    termux-media-scan $argv[-1]
end
