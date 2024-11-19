if pgrep -x "linux-wallpaper" > /dev/null
then
    echo "Running"
    pkill "linux-wallpaper"
    hyprctl hyprpaper wallpaper "DP-3,~/.config/background_flipped.png"
    notify-send --expire-time 1350 "wallpaper-engine OFF"
else
    echo "Stopped"
    linux-wallpaperengine --no-audio-processing --silent --screen-root DP-3 --fps 30 1682963130 &> /dev/null & disown
    notify-send --expire-time 1350 "wallpaper-engine ON" &
fi


