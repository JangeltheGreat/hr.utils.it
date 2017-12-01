#!/bin/bash
source variables.sh
echo $todaysDate
echo >> "$logPath/rsync/$todaysDate.$3.log"
echo "***********************************************************"  >> "$logPath/rsync/$todaysDate.$3.log"
date >> "$logPath/rsync/$todaysDate.$3.log"
echo >> "$logPath/rsync/$todaysDate.$3.log" 
rsync -ravu $1 $2 >> "$logPath/rsync/$todaysDate.$3.log" 2>&1

