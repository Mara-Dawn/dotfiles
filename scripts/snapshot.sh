#!/usr/bin/env bash

outputDir="$HOME/Pictures/Screenshots/"
outputFile="snapshot_$(date +%Y-%m-%d_%H-%M-%S).png"
outputPath="$outputDir/$outputFile"
mkdir -p "$outputDir"

mode=${1:-area}

case "$mode" in
active)
    command="grimblast --cursor --freeze save active - | swappy -f -"
    ;;
output)
    command="grimblast --cursor --freeze save output - | swappy -f -"
    ;;
area)
    command="grimblast --cursor --freeze save area - | swappy -f -"
    ;;
*)
    echo "Invalid option: $mode"
    echo "Usage: $0 {active|output|area}"
    exit 1
    ;;
esac

eval "$command"
