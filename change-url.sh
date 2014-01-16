#!/bin/bash

newurl=$1

if [ -z "$newurl" ]; then
	echo "Enter the URL to change to:"
	read newurl
fi

echo "Updating /boot/starturl.txt with URL $newurl"
sudo bash -c "echo $newurl > /boot/starturl.txt"

echo "Restarting chromium"
sudo killall chromium

echo Done
