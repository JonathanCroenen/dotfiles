SCREENCAST_OUTPUT_DIR=~/Pictures/Screencasts

function screencast {
    local screeninfo=$(xwininfo)
    local winx=$(echo $screeninfo | grep -oP 'Absolute upper-left X:  \K[0-9]+')
    local winy=$(echo $screeninfo | grep -oP 'Absolute upper-left Y:  \K[0-9]+')
    local winw=$(echo $screeninfo | grep -oP 'Width: \K[0-9]+')
    local winh=$(echo $screeninfo | grep -oP 'Height: \K[0-9]+')

    winw=$((winw / 2 * 2))
    winh=$((winh / 2 * 2))

    local output_path="$SCREENCAST_OUTPUT_DIR/$(date +%Y%m%d_%H%M%S).mp4"
    mkdir -p $(dirname $output_path)

    ffmpeg -f x11grab -s ${winw}x${winh} -i :0.0+$winx,$winy -vcodec libx264 -preset ultrafast -crf 0 -threads 0 -y $output_path
}

function serve {
    local -r PORT=${1:-8888}
    python2 -m SimpleHTTPServer "$PORT"
}
