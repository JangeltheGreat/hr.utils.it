#!/bin/bash

##This script is designed to be run once a day. It will pull down all the signatures that have occured in the specified date range

source variables.sh

#dateRange=$(date -j -v-2d +"%Y-%m-%d")"+TO+"`date +%Y-%m-%d` #For use when testing or running on OSX
dateRange=$(date --date="2 days ago" +"%Y-%m-%d")"+TO+"`date +%Y-%m-%d` #For use on GNU Linux

pageSize=1
query="query=created:\{$dateRange\}+AND+title:SSP+\(New+Registration\)+Terms+and+Conditions+AND+complete:true"

numPages=$(curl "https://api.hellosign.com/v3/signature_request/list?page=1&page_size=$pageSize&$query" -u $apiKey | jq '.["list_info"]["num_pages"]')
SSPWeeklySignaturesFile=/home/itadmin/bin/HelloSign/SSPSignatures/`date +%Y`Week`date +%V`-SSPSignatures.csv
SSPWeeklysignaturesDriveFile=`date +%Y`_Week-`date +%V`_SSP-Signatures[InProgress]
SSPCompletedSignaturesDriveFile=`date +%Y`_Week-`date +%V`_SSP-Signatures[COMPLETE]
TodayOfTheWeek=`date +%u`

if [ $TodayOfTheWeek -eq 1 ]; then
        echo '"This file updates automatically. Changes to it will be overwritten daily @1am",,' >> $SSPWeeklySignaturesFile
        echo '"Name", "Email Address", "Date of Signature"' >> $SSPWeeklySignaturesFile
fi
pageNum=1
while [ $pageNum -le $numPages ] ; do 
        signerData=$(curl -v "https://api.hellosign.com/v3/signature_request/list?page=$pageNum&page_size=$pageSize&$query" -u $apiKey)
        dateSignedData=$(echo $signerData | jq '.["signature_requests"][]["response_data"][2]["value"]')
        signerEmailData=$(echo $signerData | jq '.["signature_requests"][]["signatures"][]["signer_email_address"]')
        signerNameData=$(echo $signerData | jq '.["signature_requests"][]["response_data"][1]["value"]')
        pageNum=$[ $pageNum + 1 ]
        echo $signerNameData", "$signerEmailData", "$dateSignedData >> $SSPWeeklySignaturesFile
done 

if [ $TodayOfTheWeek -eq 1 ]; then
        gam user ceo.bot add drivefile drivefilename "$SSPWeeklysignaturesDriveFile" parentID 0ByLS0VkxubTDZTF0dkxWcE1BUXc localfile $SSPWeeklySignaturesFile mime$
elif [ $TodayOfTheWeek -ne 1 ] && [ $TodayOfTheWeek -ne 7 ]; then
        gam user ceo.bot update drivefile drivefilename "$SSPWeeklysignaturesDriveFile" newfilename $SSPWeeklysignaturesDriveFile localfile $SSPWeeklySignaturesFi$
elif [ $TodayOfTheWeek -eq 7 ]; then
        gam user ceo.bot update drivefile drivefilename "$SSPWeeklysignaturesDriveFile" newfilename $SSPCompletedSignaturesDriveFile localfile $SSPWeeklySignature$
fi
