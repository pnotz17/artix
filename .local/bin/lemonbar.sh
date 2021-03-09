#!/bin/sh
whiteColor="#E6E6FA"
blueColor="#1E90FF"
peachColor="#FFC0CB"
greenColor="#00FF00"
yellowColor="#FFA500"
greyColor="#7F7F7F"
purpleColor="#FF00FF"
orangeColor="#FF7D00"
redColor="#FF0000"
tealColor="#00FFEF"

cur (){
    var=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
	echo "[$var]"
}

tot (){
    var=$(xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}')
	echo "[$var]"
}

 updates() {
	updates=$(checkupdates 2> /dev/null | wc -l )  
	echo "%{F$blueColor}PCM: $updates %{F-}"
}

mail() {
	mail=`curl -su USERNAME:PASSWD https://mail.google.com/mail/feed/atom || echo "<fullcount>unknown number of</fullcount>"`
	mail=`echo "$mail" | grep -oPm1 "(?<=<fullcount>)[^<]+" `
	echo "%{F$peachColor}INB: $mail %{F-}"
}

weather() {
	weather=$(curl 'https://wttr.in/YOURCITY,YOURCOUNTRY?format=%t')
	echo "%{F#FF0000}WEA: $weather %{F-}"
}

cputemp() {
	cputemp=$(sensors | grep Core | awk '{print substr($3, 2, length($3)-5)}' | tr "\\n" " " | sed 's/ /°C  /g' | sed 's/  $//')
	echo "%{F#1CFF00}TEM: $cputemp %{F-}"
}

cpufrequency() {
	cpu=$(awk '{u=$2+$4; t=$2+$4+$5;if (NR==1){u1=u; t1=t;} else printf("%d%%", ($2+$4-u1) * 100 / (t-t1) "%");}' <(grep 'cpu ' /proc/stat) <(sleep 0.5; grep 'cpu ' /proc/stat))
	echo "%{F$greenColor}CPU: $cpu %{F-}"
}

ram() {
	mem=$(free -h | awk '/Mem:/ { print $3 }' | cut -f1 -d 'i')
	echo "%{F$yellowColor}MEM: $mem %{F-}"
}

alsa() {
    volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')" 
	echo "%{F$whiteColor}VOL: $volume %{F-}"
}

upspeed() {
	T1=`cat /sys/class/net/enp2s0/statistics/tx_bytes`
	sleep 1
	T2=`cat /sys/class/net/enp2s0/statistics/tx_bytes`
	TBPS=`expr $T2 - $T1`
	TKBPS=`expr $TBPS / 1024`
	echo   "%{F$tealColor}UP: $TKBPS kb %{F-}"
}

downspeed() {
	R1=`cat /sys/class/net/enp2s0/statistics/rx_bytes`
	sleep 1
	R2=`cat /sys/class/net/enp2s0/statistics/rx_bytes`
	RBPS=`expr $R2 - $R1`
	RKBPS=`expr $RBPS / 1024`
	echo   "%{F$purpleColor}DO: $RKBPS kb %{F-}"
}

clock() {
	time=$(date +"%^b %d,%R")
	echo "%{F$orangeColor} $time %{F-}"
}

while true; do
	 echo -e "%{l} $(cur) $(tot)%{c}%{r}  $(updates) |  $(mail) |  $(cpufrequency) |  $(ram) |  $(upspeed) |  $(downspeed) |  $(alsa) |  $(clock) |"
	sleep 1
done &


