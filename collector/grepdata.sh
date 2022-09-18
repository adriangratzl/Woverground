#!/bin/bash
#Woverground - v0.6.1
#grepdata.sh
#Adrian Gratzl - 2022

source /usr/share/woverground/woverground.conf

curl -s "https://api.weather.com/v2/pws/observations/current?stationId=$stationID&format=json&units=m&apiKey=$api_key" | jq . > $maindir_collector_data/logs/current.json
echo "$(date +"%H:%M"),$(jq .observations[].winddir $maindir_collector_data/logs/current.json),$(jq .observations[].humidity $maindir_collector_data/logs/current.json),$(jq .observations[].metric.temp $maindir_collector_data/logs/current.json),$(jq .observations[].metric.heatIndex $maindir_collector_data/logs/current.json),$(jq .observations[].metric.windSpeed $maindir_collector_data/logs/current.json),$(jq .observations[].metric.precipRate $maindir_collector_data/logs/current.json),$(jq .observations[].metric.precipTotal $maindir_collector_data/logs/current.json),$(jq .observations[].metric.pressure $maindir_collector_data/logs/current.json)" >> $maindir_collector_data/logs/$todaysdate.csv

sed -i '/null/d' $maindir_collector_data/logs/$todaysdate.csv 
