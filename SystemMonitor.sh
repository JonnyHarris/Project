####################### SystemMonitor.sh ####################################
# Date: 		01/01/2014
# Author:		Jonathan Harris 
# Student Id:		x13118901
# Description:	Level 1 Functions to monitor deployment environment dependancies:
# 			isApacheRunning 
# 			isApacheListening 
# 			isApacheRemoteUp 
# 			isApacheUsageCPUwithinLimits 
# 			isMysqlRunning 
#			isMyPinging 
# 			
# Dependencies:      SystemStatusFuncLevel_0.sh    - Level 0 System Functions	
#			
#######################################################################################
#!/bin/bash
# Jonathan Harris 2014

source SystemStatusFuncLevel_0.sh		# Level 0 System Functions
source SystemStatusFuncLevel_1.sh		# Level 1 System Functions

# Report Date and Time
echo $(date +"%F %T") status 

# Functional Body of SystemMonitor script <----------------------------

ERRORCOUNT=0

isApacheRunning
if [ "$?" -eq 1 ]; then
        echo Apache process is Running
else
        echo Apache process is not Running
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isApacheListening
if [ "$?" -eq 1 ]; then
        echo Apache is Listening
else
        echo Apache is not Listening
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isApacheRemoteUp
if [ "$?" -eq 1 ]; then
        echo Remote Apache TCP port is up
else
        echo Remote Apache TCP port is down
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isApacheCpuUsageWithinLimits
if [ "$?" -eq 1 ]; then
        echo Apache within limits
else
        echo Apache outside limits
        ERRORCOUNT=$((ERRORCOUNT+1))
fi


isMysqlRunning
if [ "$?" -eq 1 ]; then
        echo Mysql process is Running
else
        echo Mysql process is not Running
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isMysqlListening
if [ "$?" -eq 1 ]; then
        echo Mysql is Listening
else
        echo Mysql is not Listening
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isMysqlRemoteUp
if [ "$?" -eq 1 ]; then
        echo Remote Mysql TCP port is up
else
        echo Remote Mysql TCP port is down
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isMyPinging
if [ "$?" -eq 1 ]; then
        echo Remote IP is alive
else
        echo Remote IP is down
        ERRORCOUNT=$((ERRORCOUNT+1))
fi



if  [ $ERRORCOUNT -gt 0 ]
then
        echo "There was a problem on the server email sent to System Admin"
        perl sendmail.pl "There is a problem on the server see SystemMonitor.out for further info" 
fi

