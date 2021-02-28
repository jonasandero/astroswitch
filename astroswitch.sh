#!/bin/sh

IFS=

basedir=$(dirname "$0")

# Get sunrise / sunset
data=$(wget  --no-check-certificate -qO-  "https://api.sunrise-sunset.org/json?lat=57.614671728089476&lng=-11.76976616654255&formatted=0")
if [ ! $? -eq 0 ]
then
  echo "Failed to get sunrise/sunset, exiting."
  exit -1
fi

wait_for_sun_and_adjust_switch() {
    sun_event=$1
    sun_event_time=$(echo $data | "$basedir/JSON.sh" -b | egrep '\["results","'$sun_event'"\]' | cut -f2 -d']' | tr -d ' \t"')
    sun_event_epoch=$(date -d $sun_event_time -D "%Y-%m-%dT%H:%M:%S+%Z" +%s)
    seconds_until_sun_event=$(( $sun_event_epoch - $(date +%s) ))

    if [ $seconds_until_sun_event -gt 0 ]; then
        logger "Waiting $seconds_until_sun_event seconds until $sun_event"
        sleep $seconds_until_sun_event
        logger "Performing action $sun_event"
    fi
}

wait_for_sun_and_adjust_switch sunrise
wait_for_sun_and_adjust_switch sunset

