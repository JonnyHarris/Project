####################### SystemStatusFuncLevel_1.sh ####################################
# Date: 		01/01/2014
# Author:		Jonathan Harris 
# Student Id:		x13118901
# Description:	Level 0 Functions to monitor deployment environment dependancies
# 				isRunning 
#				isTCPlisten
#				isUDPlisten
#				isIPalive 
#				isTCPlisten
#				isTCPlisten
# Dependencies:      /bin/bash
#
#######################################################################################

#!/bin/bash		# script is to be interpreted and run by bash in Bourne Shell mode

#-------------------- Level 0 function block --------------------------

function isRunning {
PROCESS_NUM=$(ps -ef | grep "$1" | grep -v "grep" | wc -l)
if [ $PROCESS_NUM -gt 0 ] ; then
        return 1
else
        return 0
fi
}

function isTCPlisten {
TCPCOUNT=$(netstat -tupln | grep tcp | grep "$1" | wc -l)
if [ $TCPCOUNT -gt 0 ] ; then
        return 1
else
        return 0
fi
}

function isUDPlisten {
UDPCOUNT=$(netstat -tupln | grep udp | grep "$1" | wc -l)
if [ $UDPCOUNT -gt 0 ] ; then
        return 1
else
        return 0
fi
}


function isTCPremoteOpen {
timeout 1 bash -c "echo >/dev/tcp/$1/$2" && return 1 ||  return 0
}


function isIPalive {
PINGCOUNT=$(ping -c 1 "$1" | grep "1 received" | wc -l)
if [ $PINGCOUNT -gt 0 ] ; then
        return 1
else
        return 0
fi
}

function myCPUusage {
app_name=$1
cpu_limit=$2
app_pid=`ps aux | grep $app_name | grep -v grep | awk {'print $2'}`
app_cpu=`ps aux | grep $app_name | grep -v grep | awk {'print $3*100'}`
if [[ $app_cpu -gt $cpu_limit ]]; then
     return 0
else
     return 1
fi
}
#************** END OF FILE ********************
