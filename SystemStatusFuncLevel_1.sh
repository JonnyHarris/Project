####################### SystemStatusFuncLevel_1.sh ####################################
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

#!/bin/bash    	# script is to be interpreted and run by bash in Bourne Shell mode

source SystemStatusFuncLevel_0.sh         # Level 0 System Functions

#--------------------------> Level 1 function block <---------------------------------------

function isApacheRunning {
        isRunning apache2
        return $?
}

function isApacheListening {
        isTCPlisten 80
        return $?
}

function isApacheRemoteUp {
        isTCPremoteOpen 127.0.0.1 80
        return $?
}

function isApacheCpuUsageWithinLimits {
        myCPUusage Apache 5000
        return $?
}

function isMysqlListening {
        isTCPlisten 3306
        return $?
}

function isMysqlRunning {
        isRunning mysqld
        return $?
}

function isMysqlRemoteUp {
        isTCPremoteOpen 127.0.0.1 3036
        return $?
}

function isMyPinging {
        isIPalive 127.0.0.1
        return $?
}

#************** END OF FILE ********************
