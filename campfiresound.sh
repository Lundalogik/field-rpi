#!/bin/bash
say() { local IFS=+;/usr/bin/mplayer -ao alsa -really-quiet -noconsolecontrols "http://somethin.campfirenow.com/sounds/$1.mp3"; }
say $1
