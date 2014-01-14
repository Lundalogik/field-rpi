#!/bin/bash
#
# Installs telldusd
# Add -f to force (re)installation
#
if [ "$UID" -ne 0 ]
	then echo "Please run $0 as root"
	exit
fi

dir=`dirname $0`

tellstickdev=$( lsusb | grep "Telldus TellStick" )
if [ -z "$tellstickdev" ]; then
	echo Skipping installation of telldusd, no Tellstick present at the moment
	exit 0
fi

if [ -f /etc/init.d/telldusd ] && [ "-f" != "$1" ]; then
	echo "telldusd already installed. Use -f to reinstall"
	exit
fi

echo Found Tellstick, installing necessary libs..
apt-get install libftdi1 libftdi-dev libconfuse0 libconfuse-dev -qq --force-yes
devid=$( echo "$tellstickdev" | awk '{print $6}' )
vendorid=$( echo "$devid" | awk -F':' '{print $1}' )
prodid=$( echo "$devid" | awk -F':' '{print $2}' )

modprobe ftdi_sio vendor=0x$vendorid product=0x$prodid

loadedmod=$( lsmod | grep ftdi )
if [ -z "$loadedmod" ]; then
	echo ftdi module seems not to be loaded, you might want to check this.
else
	echo ftdi module loaded successfully - adding entry to /etc/modules
	if [ -z "$( cat /etc/modules | grep ftdi_sio )" ]; then
		echo "ftdi_sio vendor=0x$vendorid product=0x$productid" >> /etc/modules
	fi
fi

echo Installing cmake
apt-get install cmake -qq --force-yes

echo Getting and compiling telldus-core
telldusrelease=telldus-core-2.1.1
wget http://download.telldus.se/TellStick/Software/telldus-core/$telldusrelease.tar.gz
tar xzf $telldusrelease.tar.gz
pushd $telldusrelease 1>/dev/null
cmake .
make && make install
popd 1>/dev/null

echo Running ldconfig...
ldconfig

cp $dir/etc/init.d/telldusd /etc/init.d/
chmod +x /etc/init.d/telldusd
update-rc.d telldusd defaults
/etc/init.d/telldusd restart

echo "Don't forget to create a telldus.conf file for all your switches!"
echo "telldusd: Done"
