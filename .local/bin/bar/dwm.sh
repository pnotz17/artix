#!/bin/sh

while true; do

LINUX=$(uname -r)
MAIL=`curl -su USER:PASS https://mail.google.com/mail/feed/atom || echo "<fullcount>unknown number of</fullcount>"`;MAIL=`echo "$MAIL" | grep -oPm1 "(?<=<fullcount>)[^<]+" `
IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1)
UPTIME=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
PACKAGES=$(checkupdates 2> /dev/null |pacman -Q  |  wc -l)
PACMAN=$(checkupdates 2> /dev/null | wc -l )
TEMP=$(sensors|awk 'BEGIN{i=0;t=0;b=0}/id [0-9]/{b=$4};/Core/{++i;t+=$3}END{if(i>0){printf("%0.1f\n",t/i)}else{sub(/[^0-9.]/,"",b);print b}}')"C"
USAGE=$(df -h . | grep -v Filesystem | awk '{print $5}')
CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
RAM=$(free -h --kilo | awk '/^Mem:/ {print $3 "/" $2}')
MEM=$(free | awk '/^Mem/ { printf("%.2f%\n", $3/$2 * 100.0) }')
NETDOWN=$(R1=`cat /sys/class/net/lo/statistics/rx_bytes`;sleep 1;R2=`cat /sys/class/net/lo/statistics/rx_bytes`;RBPS=`expr $R2 - $R1`;RKBPS=`expr $RBPS / 1024`;printf "$RKBPS kb")
NETUP=$(T1=`cat /sys/class/net/lo/statistics/tx_bytes`;sleep 1;T2=`cat /sys/class/net/lo/statistics/tx_bytes`;TBPS=`expr $T2 - $T1`;TKBPS=`expr $TBPS / 1024`;printf "$TKBPS kb")
FORECAST=$(curl wttr.in/YOURCITY?format="%l:+%m+%p+%w+%t+%c+%C")
WEATHER=$(curl wttr.in/YOURCITY,YOURCOUNTRY?format=%t)
VOL=$(amixer get Master | awk '$0~/%/{print $4}' | tr -d '[]')
DATE=$(date "+%b %d, %R")
DATEALT=$(date '+%Y-%m-%d %H:%M:%S')
BAT=$(acpi -b | awk '{ print $4 " " }' | tr -d ',' | tr -d ' ')
DISKROOT=$(df -Ph | grep "/dev/sda" | awk {'print $5'})        
HDDTOTAL=$( df -h --total | tail -1 | awk {'printf $2'})
HDDUSED=$(df -h --total | tail -1 | awk {'printf $3'})
HDDPERCENTAGE=$(df -h --total | tail -1 | awk {'printf $5'})
FULLUPT=$(uptime | awk '{printf("%d:%02d:%02d:%02d",($1/60/60/24),($1/60/60%24),($1/60%60),($1%60))}' /proc/uptime)
UPT=$(uptime --pretty | sed -e 's/up //g' -e 's/ days/d/g' -e 's/ day/d/g' -e 's/ hours/h/g' -e 's/ hour/h/g' -e 's/ minutes/m/g' -e 's/, / /g')
UP=`uptime | sed 's/.*up\s*//' | sed 's/,\s*[0-9]* user.*//' | sed 's/  / /g'`
SWAP=$(free -m | awk '/Swap/{printf("%.2f%"), $3/$2*100}')

xsetroot -name ":: On $UP :: Fs $USAGE :: Tm $TEMP :: Cpu $CPU :: Mem $MEM :: Vol $VOL :: Tx/Up $NETUP :: Tx/Down $NETDOWN :: $DATE ::"
#xsetroot -name "^c#FFFFFF^$UPTIME ^c#FFFFFF^| ^c#FFFFFF^Ip: ^c#FF0000^$IP ^c#FFFFFF^| ^c#FFFFFF^Mail: ^c#FF0000^$MAIL ^c#FFFFFF^| ^c#FFFFFF^Temp: ^c#FF0000^$TEMP ^c#FFFFFF^| ^c#FFFFFF^Cpu: ^c#FF0000^$CPU ^c#FFFFFF^| ^c#FFFFFF^Mem: ^c#FF0000^$MEM ^c#FFFFFF^| ^c#FFFFFF^Tx/up: ^c#FF0000^$UP ^c#FFFFFF^| ^c#FFFFFF^Tx/do: ^c#FF0000^$DOWN ^c#FFFFFF^| ^c#FFFFFF^Vol: ^c#FF0000^$VOL ^c#FFFFFF^| ^c#FFFFFF^$DATE ^c#FFFFFF^|"
	sleep 3s
done &
