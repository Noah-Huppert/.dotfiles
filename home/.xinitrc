#!/usr/bin/env bash

# Let Java apps run correctly in GUI
# I don't quite understand it, but Intellij won't run without it
export _JAVA_AWT_WM_NONREPARENTING=1

# Set background
#bkground

# WM
exec i3 --shmlog-size=26214400
