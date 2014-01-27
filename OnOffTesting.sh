#!/bin/bash
echo "*****  Running Deployment Unit Test Suite ***********"
echo ""
echo "****** Stage 1: Unit Test with Services ON"
# Unit Tests
bash UnitTesting.sh
echo "****** Stage 1: Unit Test with Services ON - COMPLETED"

echo ""
echo "****** Stage 2: Unit Test with Services OFF"
echo ""
# Stop Services
/etc/init.d/apache2 stop > apachestop.out
/etc/init.d/mysql stop > mysqlstop.out
echo ""
# Unit Tests
bash UnitTesting.sh
echo "****** Stage 2: Unit Test with Services OFF - COMPLETED"

echo ""
echo "****** Stage 3: Unit Test with Services RESTARTED"
echo ""
# Start services
/etc/init.d/apache2 start > apachestart.out
/etc/init.d/mysql start > mysqlstart.out
# Unit Tests
bash UnitTesting.sh
echo ""
echo "****** Stage 3: Unit Test with Services RESTARTED - COMPLETED"

echo ""
echo "***** Deployment Unit Testing Suite Completed ******"
