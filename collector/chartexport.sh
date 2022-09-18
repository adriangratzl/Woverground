#!/bin/bash
#Woverground -v0.6.1
#chartexport.sh
#Adrian Gratzl - 2022

source /usr/share/woverground/woverground.conf

#Generate PNG from the day before collected data

sed -i '/null/d' $maindir/collector/data/logs/$date_short_1dayago.csv




   #---Temperatur
   echo set terminal png size 1920,1080 >> "$gp/$date_short_1dayago Temperatur.gnuplot"
   echo set output "'$maindir/collector/data/export/$date_short_1dayago-Temperatur.png'" >> "$gp/$date_short_1dayago Temperatur.gnuplot"
   echo set xlabel "'Uhrzeit'" >> "$gp/$date_short_1dayago Temperatur.gnuplot"
   echo set ylabel "'Temperatur'" >> "$gp/$date_short_1dayago Temperatur.gnuplot"
   echo set timefmt "'%H:%M'" >> "$gp/$date_short_1dayago Temperatur.gnuplot"
   echo set datafile separator "','" >> "$gp/$date_short_1dayago Temperatur.gnuplot"
   echo plot "'$maindir/collector/data/logs/$date_short_1dayago.csv'" using 4 with lines title columnheader, "'$maindir/collector/data/logs/$date_short_1dayago.csv'" using 5 with lines title columnheader >> "$gp/$date_short_1dayago Temperatur.gnuplot"

   gnuplot "$gp/$date_short_1dayago Temperatur.gnuplot"

   #---Niederschlag
   echo set terminal png size 1920,1080 >> "$gp/$date_short_1dayago Niederschlag.gnuplot"
   echo set output "'$maindir/collector/data/export/$date_short_1dayago-Niederschlag.png'" >> "$gp/$date_short_1dayago Niederschlag.gnuplot"
   echo set xlabel "'Uhrzeit'" >> "$gp/$date_short_1dayago Niederschlag.gnuplot"
   echo set ylabel "'Niederschlag'" >> "$gp/$date_short_1dayago Niederschlag.gnuplot"
   echo set timefmt "'%H:%M'" >> "$gp/$date_short_1dayago Niederschlag.gnuplot"
   echo set datafile separator "','" >> "$gp/$date_short_1dayago Niederschlag.gnuplot"
   echo plot "'$maindir/collector/data/logs/$date_short_1dayago.csv'" using 7 with lines title columnheader, "'$maindir/collector/data/logs/$date_short_1dayago.csv'" using 8 with lines title columnheader >> "$gp/$date_short_1dayago Niederschlag.gnuplot"

   gnuplot "$gp/$date_short_1dayago Niederschlag.gnuplot"

   #---Windrichtung
   echo set terminal png size 1920,1080 >> "$gp/$date_short_1dayago Windrichtung.gnuplot"
   echo set output "'$maindir/collector/data/export/$date_short_1dayago-Windrichtung.png'" >> "$gp/$date_short_1dayago Windrichtung.gnuplot"
   echo set xlabel "'Uhrzeit'" >> "$gp/$date_short_1dayago Windrichtung.gnuplot"
   echo set ylabel "'Windrichtung'" >> "$gp/$date_short_1dayago Windrichtung.gnuplot"
   echo set timefmt "'%H:%M'" >> "$gp/$date_short_1dayago Windrichtung.gnuplot"
   echo set datafile separator "','" >> "$gp/$date_short_1dayago Windrichtung.gnuplot"
   echo plot "'$maindir/collector/data/logs/$date_short_1dayago.csv'" using 2 with lines title columnheader >> "$gp/$date_short_1dayago Windrichtung.gnuplot"

   gnuplot "$gp/$date_short_1dayago Windrichtung.gnuplot"

   #---Luftdruck
   echo set terminal png size 1920,1080 >> "$gp/$date_short_1dayago Luftdruck.gnuplot"
   echo set output "'$maindir/collector/data/export/$date_short_1dayago-Luftdruck.png'" >> "$gp/$date_short_1dayago Luftdruck.gnuplot"
   echo set xlabel "'Uhrzeit'" >> "$gp/$date_short_1dayago Luftdruck.gnuplot"
   echo set ylabel "'Luftdruck'" >> "$gp/$date_short_1dayago Luftdruck.gnuplot"
   echo set timefmt "'%H:%M'" >> "$gp/$date_short_1dayago Luftdruck.gnuplot"
   echo set datafile separator "','" >> "$gp/$date_short_1dayago Luftdruck.gnuplot"
   echo plot "'$maindir/collector/data/logs/$date_short_1dayago.csv'" using 9 with lines title columnheader >> "$gp/$date_short_1dayago Luftdruck.gnuplot"

   gnuplot "$gp/$date_short_1dayago Luftdruck.gnuplot"


   rm -r $gp/*.gnuplot
