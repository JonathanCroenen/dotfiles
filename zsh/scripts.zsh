screencast() {
    local screeninfo=$(xwininfo)
    local winx=$(echo $screeninfo | grep -oP 'Absolute upper-left X:  \K[0-9]+')
    local winy=$(echo $screeninfo | grep -oP 'Absolute upper-left Y:  \K[0-9]+')
    local winw=$(echo $screeninfo | grep -oP 'Width: \K[0-9]+')
    local winh=$(echo $screeninfo | grep -oP 'Height: \K[0-9]+')
    ffmpeg -f x11grab -y -framerate 30 -s $winw"x"$winh -i :0.0+$winx,$winy -pix_fmt yuv420p -c:v libx264 -preset superfast -crf 18 $1
}

serve() {
    local -r PORT=${1:-8888}
    python2 -m SimpleHTTPServer "$PORT"
}
