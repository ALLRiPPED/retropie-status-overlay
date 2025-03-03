#!/bin/bash

#get script path
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH


#if not root user, restart script as root
if [ "$(whoami)" != "root" ]; then
	echo "Switching to root user..."
	sudo bash $SCRIPT
	exit 1
fi

#set constants
NONE='\033[00m'
CYAN='\033[36m'
FUSCHIA='\033[35m'
UNDERLINE='\033[4m'

echo
echo "Removing Dependencies..."
echo

rm /usr/local/bin/pngview

echo "Removing Service..."
echo

service retropie-status-overlay stop

systemctl disable retropie-status-overlay
rm /lib/systemd/system/retropie-status-overlay.service
rm /home/pi/RetroPie/retropiemenu/retropieoverlay.sh
rm /home/pi/RetroPie/retropiemenu/icons/retropieoverlay.png

echo
echo "$SCRIPTPATH will be left in place, you are free to manually remove"

echo ""
echo "--------------------------------------------------"
echo "Retropie Status Overlay uninstall complete!"
echo "--------------------------------------------------"