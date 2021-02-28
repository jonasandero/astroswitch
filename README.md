# Outdoor light control

A script to schedule on and off control of outdoor lights based on sunrise / sunset. Using https://github.com/scruss/ihsctrl to control a
Zigbee switch from via IKEA trådfri gateway. This scrip is typically sheduled to run as a chron job at midnight. For eaxmple on my ASUS router:

<code>cru a astroswitch "0 0 \* \* \*" ./astroswitch.sh</code>
