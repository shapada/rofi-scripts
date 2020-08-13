#!/usr/bin/env bash

#
# Focus or launch a program.
#
# EITHER switch focus to the running program matching on $1=$2, OR
# launch $5 with arguments ${@:6} on workspace $3 and output $4.
#
toggle ()
{
    # Attempt to match the running program and obtain its window id.
    case "$1" in
        (instance)        W=$(xdotool search --classname "$2" | head -1) ;;
        (class)           W=$(xdotool search --class "$2" | head -1)  ;;
        (title)           W=$(xdotool search --name "$2" | head -1) ;;
        (*)
        W='' ;;
    esac   
    if [ -z "$W" ]; then
        # Launch the program because no matching window id was found.
        if [ $# -ge 5 ]; then
            cmd="workspace empty; workspace back_and_forth; exec ${*:5}"
            i3-msg "$cmd"
        fi
    else
        # Focus the window.
        # Escape any whitespace to suit 'i3-msg'.
        cmd="[$1=${2// /\\x20}] focus"
        cmd="workspace empty; workspace back_and_forth; ${cmd}"
        i3-msg "${cmd}"
    fi
}