# RemoteX Raspberry Pi scripts

We use this internally to provide a basic set of configuration scripts for
usual setups like info displays, kiosk applications.

Pull requests are always more than welcome.

## Setup

1. Prepare your SD card with Raspbian using the guides at [RaspberryPi.org](http://www.raspberrypi.org/documentation/) or buy an SD card with Raspbian preinstalled.
2. Boot on the fresh Raspbian installation
3. Exit the ```raspi-config``` utility to enter the Bash shell
4. Clone this repository by typing the following command:
   
   ```
   pi$ git clone https://github.com/remotex/remotex-rpi
   ```

5. Run the setup script by typing this command:

   ```
   pi$ sudo ./remotex-rpi/setup-chromium-kiosk.sh
   ```
   The setup is done when you are asked to reboot the device.
   
6. The setup is now completed and a pre-configured web page showing a test image is shown on the screen when the device has rebooted.

## Configuration

### How do I choose a web page for the kiosk?

#### Alternative 1 - Editing starturl.txt on another computer

After finishing the setup you will find a file named ```starturl.txt``` on the (boot partition of the) SD card.
Just edit this file and then plug the SD card back into the Raspberry Pi and boot!

#### Alternative 2 - Editing starturl.txt on the Raspberry Pi

1. If your Raspberry Pi is showing the configured web page you need to switch to the console using this method.
   Press **Ctrl-Alt-F1** to switch to the bash shell, hit **Enter**, login as the pi user. *(The default password is raspberry)*
2. Use ```sudo``` to gain root access.

   ```
   pi$ sudo bash
   root@raspberrypi:/home/pi# 
   ```
   
3. Update the file to contain the URL of the web page to show using the following command:

   ```
   root@raspberrypi:/home/pi# echo https://www.webpage.to/show > /boot/starturl.txt
   ```

4. Restart the web browser to show the new page

   ```
   root@raspberrypi:/home/pi# ./remotex-rpi/restart-browser.sh
   ```
   
5. Switch back to the (restarted) browser by pressing **Alt-F7**
6. Done!

### How to configure an IP address?

If you need to connect using SSH to the Raspberry Pi, you probably want to set a static IP address for the device.
The configuration for this depends on if you are going to use WiFi or cable.
Here is some pointers that might help.

* [Tutorial - How to give your Raspberry Pi a Static IP Address](http://www.modmypi.com/blog/tutorial-how-to-give-your-raspberry-pi-a-static-ip-address)
* [Networking at Raspberry Pi StackExchange](http://raspberrypi.stackexchange.com/questions/tagged/networking)

## Resources

Some good links which we have based this work on:
* (http://blogs.wcode.org/2013/09/howto-boot-your-raspberry-pi-into-a-fullscreen-browser-kiosk/)[HOWTO: Boot your Raspberry Pi into a fullscreen browser kiosk]
* (http://www.niteoweb.com/blog/raspberry-pi-boot-to-browser)[Raspberry PI boot to browser]
* (https://github.com/MobilityLab/TransitScreen/wiki/Raspberry-Pi)[MobilityLab's TransitScreen]
* (http://www.alandmoore.com/blog/2011/11/05/creating-a-kiosk-with-linux-and-x11-2011-edition/)[Creating a kiosk with Linux and X11]


