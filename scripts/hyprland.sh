#!/bin/bash

args=$@

function tile_check() {
  IFS=',' read -ra PARAMS <<< $1
  if [[ "${PARAMS[2]}" == "$2" ]]; then
    if (( $(hyprctl clients | rg "class: $2" | wc -l) <= 1 ));
    then
      hyprctl dispatch settiled class:"^($2)$"
      IFS=' ' read -ra TARGET <<< ${PARAMS[1]}
      hyprctl dispatch movetoworkspacesilent ${TARGET[0]},class:"^($2)$"
    fi
  fi
}

function handle() {
  case $1 in
    openwindow*) 
      for class in $args
      do
        tile_check "$1" "$class"
      done
      ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
