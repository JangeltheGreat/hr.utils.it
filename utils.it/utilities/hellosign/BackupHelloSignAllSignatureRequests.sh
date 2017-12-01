#!/bin/bash
#brew install jq
#setup
source variables.sh

#echo 'For this script to run, you will need to install the packages "jq" which can be retrieved via brew, or uncommenting line 2, and "bc"(which is native to OSX, but is available via apt on ubuntu) '\n\n\n
read -p 'Please enter the API key for the HelloSign Account you would like to backup. : ' apiKey
read -p 'Please enter the name of the account (so we can make a folder for your docs): ' username
read -p 'Are there less than 500 docs in this account? [y,n] : ' accountsizeOver500

#Retrieves the number of pages of signature requests available to the given user
i=1
query="https://api.hellosign.com/v3/signature_request/list?page=$i&query=complete:true"

numPages=$(curl -v "$query" -u $apiKey':' | jq '.["list_info"]["num_pages"]')
																				
#Defines the location where all the signature ID's will be stored for retrieval
userfolder=$pdfPath/hellosign-backup/$username
mkdir -p $userfolder
csvSignatureRequestIdFile=$userfolder'/'SignatureRequestIDList.csv

#Clears the file of previous data  
echo '' > $csvSignatureRequestIdFile

#Loops over each page and writes the signature_request_id field to a file
i=0
while [ $i -lt $numPages ] ; do 
	i=$[$i+1]
	echo 'Page' $i 'of' $numPages 'writing to' $csvSignatureRequestIdFile
	curl "$query" -u $apiKey':' | jq '.["signature_requests"][]["signature_request_id"]' | sed -e 's/^"//' -e 's/"$//' >> $csvSignatureRequestIdFile
done


numDocuments=$(wc -l < $csvSignatureRequestIdFile)

#loops over each line of the ID file, and downloads each document in its current state
i=0
SECONDS=3600
while read p; do 
	i=$[$i+1]
	documentHours=$[$i*3600]
	rate=$(bc -l <<< $documentHours/$SECONDS)
	echo
	echo 'Downloading file: '$i' of '$numDocuments' at a rate of '$rate' per hour, do not exceed 500'
	curl 'https://api.hellosign.com/v3/signature_request/files/'$p -u $apiKey':' -o $userfolder'/'$p'.pdf'
	#to keep from hitting the hellosign API download rate limit of 500 calls/hour, the loop sleeps for 6 seconds
	if [[ $accountsizeOver500 == 'y' ]]; then
	sleep 6
	fi
done <$csvSignatureRequestIdFile

#prints directory where documents have been downloaded
currentDir=$(pwd)
echo 'Backed up '$numDocuments' documents from HelloSign to '$userfolder

