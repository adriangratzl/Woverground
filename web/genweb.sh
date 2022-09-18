#!/bin/bash
#Woverground - v0.6
#genweb.sh
#Adrian Gratzl - 2022


source /usr/share/woverground/woverground.conf

curl -s "https://api.weather.com/v2/pws/observations/current?stationId=$stationID&format=json&units=m&apiKey=$api_key" | jq . > $maindir_web/current.json
curl -s "https://api.weather.com/v3/wx/forecast/daily/5day?geocode=$geocode&units=m&language=$language&format=json&apiKey=$api_key" | jq . > $maindir_web/forecast.json

echo '

<html><head>
 <meta charset="utf-8">
 <link rel="icon" type="image/x-icon" href="https://c.tenor.com/O5Xaksg5W8QAAAAi/sun-sunshine.gif">
 <link rel="stylesheet" type="text/css" href="style.css">
 <link rel="preconnect" href="https://fonts.googleapis.com">
 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
 <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400&amp;display=swap" rel="stylesheet">
<title>Woverground '$stationID'</title></head>


 <body style="font-family: Roboto, sans-serif;">
<div class="topsection">
 <header>
  <h1>Woverground '$stationID'</h1>
 </header>

 <div class="main">
  <div style="float: center;">
    <div class="mainplaceholder">
    <a href="current.html">
    <div class="maininfo">
     <p class="maintemp">'$(jq -r .observations[].metric.temp $maindir_web/current.json)'°</p>
     <p class="mainlocation">'$city'</p>
     <p class="time">'$(date +"%H:%M - %A, %d %h '%y")'</p>
    </div>
   </a>
   </div>
</div>
</a>
  <br>

<div class="sidecontainer">
  <div class="row">
    <h2>Wettervorhersage</h2>
   <div class="wetterbox">
    <h4>'$(jq -r .dayOfWeek[0] $maindir_web/forecast.json)'</h4>
    <p>'$(jq -r .narrative[0] $maindir_web/forecast.json)'</p>
   </div>
   <div class="wetterbox">
    <h4>'$(jq -r .dayOfWeek[1] $maindir_web/forecast.json)'</h4>
    <p>'$(jq -r .narrative[1] $maindir_web/forecast.json)'</p>
   </div>
   </div>
     <div class="row">
   <div class="wetterbox">
    <h4>'$(jq -r .dayOfWeek[2] $maindir_web/forecast.json)'</h4>
    <p>'$(jq -r .narrative[2] $maindir_web/forecast.json)'</p>
   </div>
   <div class="wetterbox">
    <h4>'$(jq -r .dayOfWeek[3] $maindir_web/forecast.json)'</h4>
    <p>'$(jq -r .narrative[3] $maindir_web/forecast.json)'</p>
   </div>
   </div>
     <div class="row">
   <div class="wetterbox">
    <h4>'$(jq -r .dayOfWeek[4] $maindir_web/forecast.json)'</h4>
    <p>'$(jq -r .narrative[4] $maindir_web/forecast.json)'</p>
   </div>
   <div class="wetterbox">
    <h4>'$(jq -r .dayOfWeek[5] $maindir_web/forecast.json)'</h4>
    <p>'$(jq -r .narrative[5] $maindir_web/forecast.json)'</p>
   </div>
   </div>
   </div>
 </div>
 </div>
</div>
<div class="below">
<div class="dashboard">
<h2>'$(jq -r .observations[].stationID $maindir_web/current.json)' Dashboard</h2>
<div class="row">
<div class="wetterbox">
<h2>Aktuell</h2>
<p>Temperatur: '$(jq -r .observations[].metric.temp $maindir_web/current.json)' °C</p>
<p>Gefhühlt wie: '$(jq -r .observations[].metric.heatIndex $maindir_web/current.json)' °C</p>
<p>UV Index:  '$(jq -r .observations[].uv $maindir_web/current.json)'</p>
<p>Windrichtung: '$(jq -r .observations[].winddir $maindir_web/current.json)'</p>
<p>Windgeschw.: '$(jq -r .observations[].metric.windSpeed $maindir_web/current.json)' km/h</p>
<p>Luftfeuchtigkeit:  '$(jq -r .observations[].humidity $maindir_web/current.json)'%</p>
<p>Luftdruck:  '$(jq -r .observations[].metric.pressure $maindir_web/current.json)' hPa</p>
<p>Niederschlag:  '$(jq -r .observations[].metric.precipRate $maindir_web/current.json)' mm/h</p>
<p>Niederschlag ges.:  '$(jq -r .observations[].metric.precipTotal $maindir_web/current.json)' mm/h</p>
</div>

<div class="wetterbox">
<h2>'Heute'</h2>
<p>Temperatur Max.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' °C</p>
<p>Temperatur Min.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' °C</p>
<p>Niederschlag Max.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Niederschlag Min.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Windgeschw. Max.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Windgeschw. Min.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Luftdruck Max.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftdruck Min.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftfeuchtigkeit Max.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)'%</p>
<p>Luftfeuchtigkeit Min.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)'%</p>
</div>

<div class="wetterbox">
<h2>'$(date --date=yesterday +"%d.%m.%Y")'</h2>
<p>Temperatur Max.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' °C</p>
<p>Temperatur Min.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' °C</p>
<p>Niederschlag Max.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Niederschlag Min.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Windgeschw. Max.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Windgeschw. Min.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Luftdruck Max.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftdruck Min.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftfeuchtigkeit Max.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)'%</p>
<p>Luftfeuchtigkeit Min.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="1 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)'%</p>
</div>

<div class="wetterbox">
<h2>'$(date --date="2 day ago" +"%d.%m.%Y")'</h2>
<p>Temperatur Max.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' °C</p>
<p>Temperatur Min.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' °C</p>
<p>Niederschlag Max.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Niederschlag Min.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Windgeschw. Max.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Windgeschw. Min.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Luftdruck Max.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftdruck Min.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftfeuchtigkeit Max.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)'%</p>
<p>Luftfeuchtigkeit Min.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="2 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)'%</p>
</div>

<div class="wetterbox">
<h2>'$(date --date="3 day ago" +"%d.%m.%Y")'</h2>
<p>Temperatur Max.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' °C</p>
<p>Temperatur Min.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' °C</p>
<p>Niederschlag Max.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Niederschlag Min.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Windgeschw. Max.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Windgeschw. Min.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Luftdruck Max.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftdruck Min.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftfeuchtigkeit Max.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)'%</p>
<p>Luftfeuchtigkeit Min.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="3 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)'%</p>
</div>

<div class="wetterbox">
<h2>'$(date --date="4 day ago" +"%d.%m.%Y")'</h2>
<p>Temperatur Max.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' °C</p>
<p>Temperatur Min.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' °C</p>
<p>Niederschlag Max.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Niederschlag Min.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Windgeschw. Max.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Windgeschw. Min.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Luftdruck Max.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftdruck Min.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftfeuchtigkeit Max.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)'%</p>
<p>Luftfeuchtigkeit Min.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="4 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)'%</p>
</div>

<div class="wetterbox">
<h2>'$(date --date="5 day ago" +"%d.%m.%Y")'</h2>
<p>Temperatur Max.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' °C</p>
<p>Temperatur Min.: '$( echo $(cut -d, -f4 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' °C</p>
<p>Niederschlag Max.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Niederschlag Min.: '$( echo $(cut -d, -f7 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' mm/h</p>
<p>Windgeschw. Max.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Windgeschw. Min.: '$( echo $(cut -d, -f6 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' km/h</p>
<p>Luftdruck Max.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftdruck Min.: '$( echo $(cut -d, -f9 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)' hPa</p>
<p>Luftfeuchtigkeit Max.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -nr ) | tr " " "\n" | head -n 1)'%</p>
<p>Luftfeuchtigkeit Min.: '$( echo $(cut -d, -f3 < $maindir_collector_data/logs/$(date --date="5 day ago" +"%d.%m.%Y").csv | sort -n ) | tr " " "\n" | head -n 1)'%</p>
</div>

</div>
<br>
<h2>Diagramme vom '$(date --date=yesterday +"%d.%m.%Y")'</h2>
<div class="row">
<img src="/export/'$(date --date=yesterday +"%d.%m.%Y")'-Temperatur.png" alt="Temperatur" title="Temperatur">
<img src="/export/'$(date --date=yesterday +"%d.%m.%Y")'-Luftdruck.png" alt="Luftdruck" title="Luftdruck">
<img src="/export/'$(date --date=yesterday +"%d.%m.%Y")'-Niederschlag.png" alt="Niederschlag" title="Niederschlag">
<img src="/export/'$(date --date=yesterday +"%d.%m.%Y")'-Windrichtung.png" alt="Windrichtung" title="Windrichtung">
</div>
<br>
<h2>Diagramme vom '$(date --date="2 day ago" +"%d.%m.%Y")'</h2>
<div class="row">
<img src="/export/'$(date --date="2 day ago" +"%d.%m.%Y")'-Temperatur.png" alt="Temperatur" title="Temperatur">
<img src="/export/'$(date --date="2 day ago" +"%d.%m.%Y")'-Luftdruck.png" alt="Luftdruck" title="Luftdruck">
<img src="/export/'$(date --date="2 day ago" +"%d.%m.%Y")'-Niederschlag.png" alt="Niederschlag" title="Niederschlag">
<img src="/export/'$(date --date="2 day ago" +"%d.%m.%Y")'-Windrichtung.png" alt="Windrichtung" title="Windrichtung">
</div>
<br>
<h2>Diagramme vom '$(date --date="3 day ago" +"%d.%m.%Y")'</h2>
<div class="row">
<img src="/export/'$(date --date="3 day ago" +"%d.%m.%Y")'-Temperatur.png" alt="Temperatur" title="Temperatur">
<img src="/export/'$(date --date="3 day ago" +"%d.%m.%Y")'-Luftdruck.png" alt="Luftdruck" title="Luftdruck">
<img src="/export/'$(date --date="3 day ago" +"%d.%m.%Y")'-Niederschlag.png" alt="Niederschlag" title="Niederschlag">
<img src="/export/'$(date --date="3 day ago" +"%d.%m.%Y")'-Windrichtung.png" alt="Windrichtung" title="Windrichtung">
</div>
<br>
<h2>Diagramme vom '$(date --date="4 day ago" +"%d.%m.%Y")'</h2>
<div class="row">
<img src="/export/'$(date --date="4 day ago" +"%d.%m.%Y")'-Temperatur.png" alt="Temperatur" title="Temperatur">
<img src="/export/'$(date --date="4 day ago" +"%d.%m.%Y")'-Luftdruck.png" alt="Luftdruck" title="Luftdruck">
<img src="/export/'$(date --date="4 day ago" +"%d.%m.%Y")'-Niederschlag.png" alt="Niederschlag" title="Niederschlag">
<img src="/export/'$(date --date="4 day ago" +"%d.%m.%Y")'-Windrichtung.png" alt="Windrichtung" title="Windrichtung">

<br>
<h2>Diagramme vom '$(date --date="5 day ago" +"%d.%m.%Y")'</h2>
<div class="row">
<img src="/export/'$(date --date="5 day ago" +"%d.%m.%Y")'-Temperatur.png" alt="Temperatur" title="Temperatur">
<img src="/export/'$(date --date="5 day ago" +"%d.%m.%Y")'-Luftdruck.png" alt="Luftdruck" title="Luftdruck">
<img src="/export/'$(date --date="5 day ago" +"%d.%m.%Y")'-Niederschlag.png" alt="Niederschlag" title="Niederschlag">
<img src="/export/'$(date --date="5 day ago" +"%d.%m.%Y")'-Windrichtung.png" alt="Windrichtung" title="Windrichtung">
</div>

</div>
</div>
</body>

</html>
' > $maindir_web/new.html
mv $maindir_web/new.html $maindir_web/index.html

rm -r /home/pi/Wetter/new.html
rm -r $maindir_web/*.json

