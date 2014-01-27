######################### UnitTesting.sh ########################
# Date: 		01/01/2014
# Author:		
# Student Id:		x9999999
# Description:	Unit Test of Level 0 & Level 1 Functions to monitor deployment 
# 			i.e. Apache2, MySql, Remote TCP Link
# Dependencies:      ./scripts/SystemStatusFunc.sh
#			Apache2, MySql, Remote TCP Link
##############################################################################

#!/bin/bash    				# script is to be interpreted and run by bash in Bourne Shell mode

source SystemStatusFuncLevel_0.sh		# Level 0 System Functions

################## Unit Test System Status Level 0 System Status Functions ##################

# Report Date and UT Result Title
echo $(date +"%F %T") status 
echo Unit Test System Status Level 0 System Status Functions 

# UT Level 0 Function isRunning with Parameter apache2

UTFAILED=0
UTCOUNT=0

function UnitTestAtom {

echo "Positive Unit Test of $1 using $2 $4 paramaeters" 

UTFAIL=0       
$1 $2 $4 
if [ "$?" -gt 0 ]; then
        echo "Positive UT Passed" 
else
        echo "Positive UT Failed" 
        UTFAIL=$((UTFAIL+1))
fi

echo "Negative Unit Test of $1 using $3 $5 paramaeters" 

$1 $3 $5 
if [ "$?" -eq 0 ]; then
        echo "Negative UT Passed" 
else
        echo "Negative UT Failed" 
        UTFAIL=$((UTFAIL+1))
fi
return $UTFAIL
}

#UT isTCPlisten 
UnitTestAtom isRunning apache2 RUBBISH
UTCOUNT=$((UTCOUNT+1))

#UT isTCPlisten 
UnitTestAtom isTCPlisten 80 9999
UTCOUNT=$((UTCOUNT+1))

#UT isUDPlisten
UnitTestAtom isUDPlisten 68 9999
UTCOUNT=$((UTCOUNT+1))

#UT isIPalive 
UnitTestAtom isIPalive "127.0.0.1" "256.0.0.9"
UTCOUNT=$((UTCOUNT+1))

#UT isTCPremoteOpen 
#UnitTestAtom isTCPremoteOpen 53 55
#UTCOUNT=$((UTCOUNT+1))

#UT myCPUusage  
UnitTestAtom myCPUusage Apache Rubbish 100 999
UTCOUNT=$((UTCOUNT+1))



if  [ $UTFAIL -gt 0 ]; then
        echo "*********** Unit Testing failed *************" 
	 echo "No of Failed UT Total=" $((UTFAIL))         
else
        echo "*********** Unit Testing Passed *************" 
        echo "Unit Testing Passed $((UTCOUNT-UTFAIL))"
fi
echo Total No of UTests= $UTCOUNT       

################### End of Script ########################
