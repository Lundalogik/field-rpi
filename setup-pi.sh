#!/bin/bash
SSHARGS=$1
shift
COMMAND=$@
DEFAULTCOMMAND="sudo setup-chromium-kiosk.sh"

while [ -z "$SSHARGS" ]; do
	read -p "Enter the hostname or IP of the PI: " SSHARGS
done

while [ -z "$COMMAND" ]; do
	read -p "Enter the command to run on the PI [$DEFAULTCOMMAND]: " COMMAND
done

echo "This script will use SSH to run $COMMAND on the PI you specify"
echo "Connecting to $SSHARGS"

sshhost=$( echo $SSHARGS | awk -F'@' '{print $2}' )
if [ -z "$sshhost" ]; then
	sshhost=$( echo $SSHARGS | awk -F'@' '{print $1}' )
	sshuser=pi
else
	sshuser=$( echo $SSHARGS | awk -F'@' '{print $1}' )
fi

dir=$( dirname $0 )
SSHARGS="$sshuser@$sshhost"
target="/home/$sshuser/rmxrpi/"
COMMAND=${COMMAND/.\//$target}
echo "Sending files from $dir to $SSHARGS:$target"
scp -r $dir $SSHARGS:$target 1>/dev/null
echo "Calling $COMMAND"
ssh $SSHARGS $COMMAND
echo "Done"

