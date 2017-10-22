#!/usr/bin/env bash

# Cleanup fn
function cleanup() {
	pkill compton
}
trap cleanup EXIT

# Let Java apps run correctly in GUI
# I don't quite understand it, but Intellij won't run without it
export _JAVA_AWT_WM_NONREPARENTING=1

# Set background
feh --bg-scale /usr/share/pixmaps/seattle-needle.jpg

# Compton
# WM
exec compton --config ~/.config/compton/compton.conf & bspwm 
