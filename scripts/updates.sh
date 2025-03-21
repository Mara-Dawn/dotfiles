#!/usr/bin/env sh

waybar-updates -l 100 | jq -r '.tooltip'
