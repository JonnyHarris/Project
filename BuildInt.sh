#!/bin/bash

# Create Sandbox
cd /tmp
SANDBOX=sandbox_$RANDOM
mkdir $SANDBOX
cd $SANDBOX

# Initalise the error counter used in report
ERRORCHECK=0

# Make empty test pages in webpackage dir
mkdir webpackage
touch webpackage/index.htm
touch webpackage/form.htm
touch webpackage/script1.plx
touch webpackage/script2.plx
#
# Make the Architecture process directories
mkdir build
mkdir integrate
mkdir test
mkdir deploy
#
# copy webpackage from git and move webpackage
#
git clone https://github.com/FSlyne/NCIRL.git
#
tar -zcvf webpackage_preBuild.tgz webpackage

# Perfrom Test on Web Page contents using md5sum to
# compute and check MD5 message digest
MD5SUM=$(md5sum webpackage_preBuild.tgz | cut -f 1 -d' ')
# save previous md5sum value
PREVMD5SUM=$(cat /tmp/md5sum)
# Test if the value has changes
# i.e. the Web contents has changed
FILECHANGE=0
if [[ "$MD5SUM" != "$PREVMD5SUM" ]]
then
        FILECHANGE=1
        echo $MD5SUM not equal to $PREVMD5SUM
else
        FILECHANGE=0
        echo $MD5SUM equal to $PREVMD5SUM
fi
# Save the new md5sum to disk
echo $MD5SUM > /tmp/md5sum
# Only coninue with BUILD if the files have changed
if [ $FILECHANGE -eq 0 ]
then
        echo no change in files, doing nothing and exiting
        exit
fi

# BUILD Process
# Move build package
mv webpackage_preBuild.tgz build
rm -rf webpackage
cd build
tar -zxvf webpackage_preBuild.tgz
#
tar -zcvf webpackage_preIntegrate.tgz webpackage
ERRORCHECK=0
# INTEGRATE
mv webpackage_preIntegrate.tgz ../integrate
rm -rf webpackage
cd ../integrate
#
tar -zxvf webpackage_preIntegrate.tgz
###
tar -zcvf webpackage_preTest.tgz webpackage
ERRORCHECK=0
# TEST
mv webpackage_preTest.tgz ../test
rm -rf webpackage
cd ../test
#
tar -zxvf webpackage_preTest.tgz
###
tar -zcvf webpackage_preDeploy.tgz webpackage
ERRORCHECK=0
# DEPLOY
if [ $ERRORCHECK -eq 0 ]
then
        mv webpackage_preDeploy.tgz ../deploy
        rm -rf webpackage
        cd ../deploy
        tar -zxvf webpackage_preDeploy.tgz
fi
