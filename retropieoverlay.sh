#!/bin/bash
#!/usr/bin/bash
# retropieoverlay.sh
#
# Script by thepitster https://github.com/ALLRiPPED/ 
#############################################
#  RetroPie Overlay v1.00
#############################################
infobox= ""
infobox="${infobox}_______________________________________________________\n\n"
infobox="${infobox}\n"
infobox="${infobox}RetroPie Overlay Control Script\n\n"
infobox="${infobox}The RetroPie Overlay python and control scripts have been installed on this system.\n"
infobox="${infobox}\n"
infobox="${infobox}This will show icons on the screen per you choice of locations for Icone sizes and spacing, placement on the\n"
infobox="${infobox}screen, as wel as which icons will show up like Audio, Bluetooth, WiFi, Battery, plus it has a build in GPIO\n"
infobox="${infobox}Shutdown you can turn on or off, via the settings file config.ini, for now.\n"
infobox="${infobox}\n"
infobox="${infobox}\n\n"

dialog --backtitle "RetroPie Overlay Control Script v1.00" \
--title "RetroPie RetroPie Overlay Control Script v1.00" \
--msgbox "${infobox}" 35 110

function main_menu() {
stats_check
    local choice

    while true; do
        choice=$(dialog --colors --backtitle "RetroPie Overlay Control Script v1.00" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "Choose An Option Below" 25 85 20 \
            01 "Enable/Disable Overlay $ols" \
            02 "Icon Size: $icons" \
            03 "Horizontal Position: $hpos" \
            04 "Vertical Position: $vpos" \
            05 "Audio Icon: $a_icon" \
            06 "Bluetooth Icon: $b_icon" \
            07 "WiFi Icon: $w_icon" \
            2>&1 > /dev/tty)

        case "$choice" in
            01) overlay_switch  ;;
            02) icon_size  ;;
            03) h_pos  ;;
            04) v_pos  ;;
            05) audio_icon  ;;
            06) bluetooth_icon  ;;
            07) wifi_icon  ;;
            *)  break ;;
        esac
    done
}
function overlay_switch() {
if systemctl is-active --quiet retropie-status-overlay; then
  sudo service retropie-status-overlay stop
else
  sudo service retropie-status-overlay start
fi
stats_check
}
function icon_size() {
	CUR_VAL=`grep "Size =" /home/pi/retropie-status-overlay/config.ini|awk '{print $3}'`
	export CUR_VAL
if [ "$CUR_VAL" = 24 ]; then
	perl -p -i -e 's/Size = $ENV{CUR_VAL}/Size = 36/g' /home/pi/retropie-status-overlay/config.ini
elif [ "$CUR_VAL" = 36 ]; then
	perl -p -i -e 's/Size = $ENV{CUR_VAL}/Size = 48/g' /home/pi/retropie-status-overlay/config.ini
elif [ "$CUR_VAL" = 48 ]; then
	perl -p -i -e 's/Size = $ENV{CUR_VAL}/Size = 24/g' /home/pi/retropie-status-overlay/config.ini
fi
stats_check
}
function h_pos() {
	CUR_VAL=`grep "Horizontal =" /home/pi/retropie-status-overlay/config.ini|awk '{print $3}'`
	export CUR_VAL
if [ "$CUR_VAL" = right ]; then
	perl -p -i -e 's/Horizontal = $ENV{CUR_VAL}/Horizontal = left/g' /home/pi/retropie-status-overlay/config.ini
elif [ "$CUR_VAL" = left ]; then
	perl -p -i -e 's/Horizontal = $ENV{CUR_VAL}/Horizontal = right/g' /home/pi/retropie-status-overlay/config.ini
fi
stats_check
}
function v_pos() {
	CUR_VAL=`grep "Vertical =" /home/pi/retropie-status-overlay/config.ini|awk '{print $3}'`
	export CUR_VAL
if [ "$CUR_VAL" = bottom ]; then
	perl -p -i -e 's/Vertical = $ENV{CUR_VAL}/Vertical = top/g' /home/pi/retropie-status-overlay/config.ini
elif [ "$CUR_VAL" = top ]; then
	perl -p -i -e 's/Vertical = $ENV{CUR_VAL}/Vertical = bottom/g' /home/pi/retropie-status-overlay/config.ini
fi
stats_check
}
function audio_icon() {
	CUR_VAL=`grep "Audio =" /home/pi/retropie-status-overlay/config.ini|awk '{print $3}'`
	export CUR_VAL
if [ "$CUR_VAL" = True ]; then
	perl -p -i -e 's/Audio = $ENV{CUR_VAL}/Audio = False/g' /home/pi/retropie-status-overlay/config.ini
elif [ "$CUR_VAL" = False ]; then
	perl -p -i -e 's/Audio = $ENV{CUR_VAL}/Audio = True/g' /home/pi/retropie-status-overlay/config.ini
fi
stats_check
}
function bluetooth_icon() {
	CUR_VAL=`grep "Bluetooth =" /home/pi/retropie-status-overlay/config.ini|awk '{print $3}'`
	export CUR_VAL
if [ "$CUR_VAL" = True ]; then
	perl -p -i -e 's/Bluetooth = $ENV{CUR_VAL}/Bluetooth = False/g' /home/pi/retropie-status-overlay/config.ini
elif [ "$CUR_VAL" = False ]; then
	perl -p -i -e 's/Bluetooth = $ENV{CUR_VAL}/Bluetooth = True/g' /home/pi/retropie-status-overlay/config.ini
fi
stats_check
}
function wifi_icon() {
	CUR_VAL=`grep "Wifi =" /home/pi/retropie-status-overlay/config.ini|awk '{print $3}'`
	export CUR_VAL
if [ "$CUR_VAL" = True ]; then
	perl -p -i -e 's/Wifi = $ENV{CUR_VAL}/Wifi = False/g' /home/pi/retropie-status-overlay/config.ini
elif [ "$CUR_VAL" = False ]; then
	perl -p -i -e 's/Wifi = $ENV{CUR_VAL}/Wifi = True/g' /home/pi/retropie-status-overlay/config.ini
fi
stats_check
}
function stats_check() {
if systemctl is-active --quiet retropie-status-overlay; then
	ols="(\Z2Enabled\Zn)"
else
	ols="(\Z1Disabled\Zn)"
fi
if grep -q "Size = 24" "/home/pi/retropie-status-overlay/config.ini"; then
	icons="(\Z324\Zn)"
elif grep -q "Size = 36" "/home/pi/retropie-status-overlay/config.ini"; then
	icons="(\Z336\Zn)"
elif grep -q "Size = 48" "/home/pi/retropie-status-overlay/config.ini"; then
	icons="(\Z348\Zn)"
fi
if grep -q "Horizontal = left" "/home/pi/retropie-status-overlay/config.ini"; then
	hpos="(\Z3Left\Zn)"
elif grep -q "Horizontal = right" "/home/pi/retropie-status-overlay/config.ini"; then
	hpos="(\Z3Right\Zn)"
fi
if grep -q "Vertical = top" "/home/pi/retropie-status-overlay/config.ini"; then
	vpos="(\Z3Top\Zn)"
elif grep -q "Vertical = bottom" "/home/pi/retropie-status-overlay/config.ini"; then
	vpos="(\Z3Bottom\Zn)"
fi
if grep -q "Audio = True" "/home/pi/retropie-status-overlay/config.ini"; then
	a_icon="(\Z2Enabled\Zn)"
elif grep -q "Audio = False" "/home/pi/retropie-status-overlay/config.ini"; then
	a_icon="(\Z1Disabled\Zn)"
fi
if grep -q "Bluetooth = True" "/home/pi/retropie-status-overlay/config.ini"; then
	b_icon="(\Z2Enabled\Zn)"
elif grep -q "Bluetooth = False" "/home/pi/retropie-status-overlay/config.ini"; then
	b_icon="(\Z1Disabled\Zn)"
fi
if grep -q "Wifi = True" "/home/pi/retropie-status-overlay/config.ini"; then
	w_icon="(\Z2Enabled\Zn)"
elif grep -q "Wifi = False" "/home/pi/retropie-status-overlay/config.ini"; then
	w_icon="(\Z1Disabled\Zn)"
fi
}

stats_check
main_menu