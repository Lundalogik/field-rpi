#!/bin/bash

echo "Current URL as specified in /boot/starturl.txt:"
cat /boot/starturl.txt

echo "Restarting chromium"
sudo killall chromium

echo Done
