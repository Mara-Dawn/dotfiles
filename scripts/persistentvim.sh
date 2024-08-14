#!/bin/bash
# file=$(echo "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" | head -1)
file="$1"
dir=$(dirname "$file")
kitty /bin/zsh -c "/bin/nvim \"$file\" ; cd \"$dir\" ; exec /bin/zsh"

