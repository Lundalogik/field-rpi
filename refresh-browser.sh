#!/bin/bash

echo "Hitting F5 in active window..."
export DISPLAY=:0
xdotool getactivewindow
xdotool key F5
