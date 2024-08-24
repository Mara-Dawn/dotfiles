#!/bin/bash

function firefox_tiled() {
  IFS=',' read -ra PARAMS <<< $1
  if (( ${PARAMS[2]} == "firefox" )); then
    if (( $(hyprctl clients | rg "class: firefox" | wc -l) <= 1 ));
    then
      hyprctl dispatch settiled class:"^(firefox)$"
    fi
  fi
}

function handle() {
  case $1 in
    openwindow*) firefox_tiled $1;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
