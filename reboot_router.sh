#!/bin/bash
# 2018-05-27 Tomas Zatko https://keybase.io/wo_ody
# TL-MR6400 is losing LTE connection every now and then only reboot helps by that time.
# This script is checking whether we are still online and reboots the router when we are not.
# It's dirty but it works. 
#
# You need to change the the Authorization HTTP header manually
# -b $'Authorization=Basic%20VVNFUk5BTUU6UEFTU1dPUkQ=' is just dummy USERNAME:PASSWORD
# Change it to your actual credentials
# Of course you need to change the IP to your actuall IP as well

online () {
	echo We are online! All good!
}

offline () {
	echo We are offline! Let\'s reboot the router!
  reboot_router
	echo Reboot command sent. Let\'s wait one minute until we check for the connection again.
	sleep 60
	echo OK. Back to routine. Checking again...
}

reboot_router () {
	SESSIONID="$(curl -i -s -k  -X $'GET' -H $'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0) Gecko/20100101 Firefox/60.0' -H $'Referer: http://192.168.42.1/' -H $'Upgrade-Insecure-Requests: 1' -b $'Authorization=Basic%20VVNFUk5BTUU6UEFTU1dPUkQ=' $'http://192.168.42.1/userRpm/LoginRpm.htm?Save=Save' | grep window.parent.location.href | awk -F '/' '{print $4}')"
	curl -i -s -k  -X $'GET' -H $'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0) Gecko/20100101 Firefox/60.0' -H $'Referer: http://192.168.42.1/'"$SESSIONID"'/userRpm/SysRebootRpm.htm' -H $'Upgrade-Insecure-Requests: 1' -b $'Authorization=Basic%20VVNFUk5BTUU6UEFTU1dPUkQ=' $'http://192.168.42.1/'"$SESSIONID"'/userRpm/SysRebootRpm.htm?Reboot=Reboot'
}


while true; do
	echo -n "Checking the connection with 10 pings to 1.1.1.1. Timestamp: "
  date
	ping -n -c10 1.1.1.1 &>/dev/null && online || offline
done

