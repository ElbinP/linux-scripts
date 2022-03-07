#!/bin/bash
   while true
    do
       export DISPLAY=:0.0
       battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
       adapter_status=`acpi -a|grep -P -o 'on-line'`
       if [ adapter_status == 'on-line' ]; then
           if [ $battery_level -ge 80 ]; then
              notify-send "Battery Full" "Level: ${battery_level}% "
              #paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
           fi
       else
           if [ $battery_level -le 40 ]; then
              notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
              #paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
           fi
       fi
     sleep 60
done
