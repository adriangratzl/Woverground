#!/bin/bash
#Woverground - v0.6
#grepdata.sh
#Adrian Gratzl - 2022

source /usr/share/woverground/woverground.conf

curl -s "https://api.weather.com/v2/pws/observations/current?stationId=$stationID&format=json&units=m&apiKey=$api_key" | jq . > $maindir/data/logs/current.json
echo "$(date +"%H:%M"),$(jq .observations[].winddir $maindir/data/logs/current.json),$(jq .observations[].humidity $maindir/data/logs/current.json),$(jq .observations[].metric.temp $maindir/data/logs/current.json),$(jq .observations[].metric.heatIndex $maindir/data/logs/current.json),$(jq .observations[].metric.windSpeed $maindir/data/logs/current.json),$(jq .observations[].metric.precipRate $maindir/data/logs/current.json),$(jq .observations[].metric.precipTotal $maindir/data/logs/current.json),$(jq .observations[].metric.pressure $maindir/data/logs/current.json)" >> $maindir/data/logs/$todaysdate.csv

sed -i '/null/d' $maindir/data/logs/$todaysdate.csv 
