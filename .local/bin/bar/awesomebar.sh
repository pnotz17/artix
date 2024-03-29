#!/bin/sh

function get_uptime {
	upt="$(uptime --pretty | sed -e 's/up //g' -e 's/ days/d/g' -e 's/ day/d/g' -e 's/ hours/h/g' -e 's/ hour/h/g' -e 's/ minutes/m/g' -e 's/, / /g')"
	printf " %s $upt"
}

function get_mail {
	mail=`curl -su USER:PASS https://mail.google.com/mail/feed/atom || echo "<fullcount>unknown number of</fullcount>"`
	mail=`echo "$mail" | grep -oPm1 "(?<=<fullcount>)[^<]+" `
	echo  "﫯 $mail"
}

function get_cputemp {
	cputemp=`sensors|awk 'BEGIN{i=0;t=0;b=0}/id [0-9]/{b=$4};/Core/{++i;t+=$3}END{if(i>0){printf("%0.1f\n",t/i)}else{sub(/[^0-9.]/,"",b);print b}}'`"糖"
	echo "﨏 $cputemp"
}

function get_cpuload {
	grep 'cpu ' /proc/stat |
	awk '{usage=($2+$4)*100/($2+$4+$5)}
		END {print " "int(usage) "%"}'
}

function get_ram {
	free |
	sed '2!d' |
	awk '{usage=$3*100/$2}
		END {print "﬙ "int(usage) "%"}'
}

function get_audio {
	audio=$(
		amixer sget Master |
		sed '5!d;
		s_]..*__g;
		s_.*\[__'
	)
	muted=$(
		amixer sget Master |
		sed '5!d' |
		cut -f8 -d' '
	)

	if [ $muted = '[on]' ]; then
		echo " $audio"
	else
		echo " $audio"
	fi
}

function get_up {
	T1=`cat /sys/class/net/enp2s0/statistics/tx_bytes`
	sleep 1
	T2=`cat /sys/class/net/enp2s0/statistics/tx_bytes`
	TBPS=`expr $T2 - $T1`
	TKBPS=`expr $TBPS / 1024`
	echo   "祝 $TKBPS kb"
}

function get_down {
	R1=`cat /sys/class/net/enp2s0/statistics/rx_bytes`
	sleep 1
	R2=`cat /sys/class/net/enp2s0/statistics/rx_bytes`
	RBPS=`expr $R2 - $R1`
	RKBPS=`expr $RBPS / 1024`
	echo   " $RKBPS kb"
}

function get_time {
	TIME=$(date +'%Y-%m-%d %R')
	echo " $TIME"

}

while true; do
	xsetroot -name "$(get_uptime)  |  $(get_mail)  |  $(get_cputemp)  |  $(get_cpuload)  |  $(get_ram)  |  $(get_up)  |  $(get_down)  |  $(get_audio)  |  $(get_time)  |"
	sleep 3
done
