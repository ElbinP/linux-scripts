#!/bin/bash
   while true
    do
       export DISPLAY=:0.0
       battery_path=`upower -e | grep 'BAT'`
       echo "battery_path $battery_path"
       battery_level=`upower -i $battery_path|grep percentage|grep -P -o '[0-9]+(?=%)'`
       echo "battery_level $battery_level"
       adapter_status=`acpi -a`
       echo "adapter_status $adapter_status"
       if [[ $adapter_status == *"on-line"* ]]; then
           if [ $battery_level -ge 90 ]; then
              notify-send "Battery Full" "Level: ${battery_level}% "
              paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
           fi
       else
           if [ $battery_level -le 40 ]; then
              notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
              paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
           fi
       fi
     sleep 60
done
