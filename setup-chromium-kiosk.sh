#!/bin/bash
if [ "$UID" -ne 0 ]
	then echo "Please run $0 as root"
	exit
fi

dir=`dirname $0`
pushd $dir 1>/dev/null

echo Running apt-get update...
apt-get update -qq --force-yes
echo Running apt-get dist-upgrade...
apt-get dist-upgrade -qq --force-yes

echo Setting up cron-apt
apt-get install cron-apt -qq --force-yes
echo "0 1 * * * root test -x /usr/sbin/cron-apt && /usr/sbin/cron-apt" > /etc/cron.d/cron-apt

echo Using apt-get to install matchbox, chromium, etc
apt-get install matchbox chromium-browser x11-xserver-utils ttf-mscorefonts-installer sqlite3 libnss3 unclutter xdotool -qq --force-yes

if [ -f /etc/rc.local ]; then
	echo Moving existing /etc/rc.local to /etc/rc.local.bak
	mv /etc/rc.local /etc/rc.local.bak
fi

echo Creating rc.local to start X as user $SUDO_USER using our xinitrc
sed -e "s/KIOSKUSER=pi/KIOSKUSER=$SUDO_USER/g" etc/rc.local > /etc/rc.local
chmod +x /etc/rc.local
echo Moving /boot/config.txt to /boot/config.txt.bak
if [ -f /boot/config.txt ]; then
	echo Moving existing /boot/config.txt to /boot/config.txt.bak
	mv /boot/config.txt /boot/config.txt.bak
fi
cp boot/* /boot/
echo Replacing config.txt with one from this repo
mv /boot/config.template.txt /boot/config.txt

# Install telldus tdtool and telldusd for Tellstick if device is present
./setup-tellstick.sh

echo "Done!"
popd 1>/dev/null

while true; do
	echo "Do you wish to reboot?"
	read yn
	case $yn in
		[Yy]* ) shutdown -r now; break;;
		[Nn]* ) exit;;
		* ) echo "Please answer yes or no.";;
	esac
done
