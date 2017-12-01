#!/bin/bash
#brew install jq
#setup
#echo 'For this script to run, you will need to install the packages "jq" which can be retrieved via brew, or uncommenting line 2, and "bc"(which is native to OSX, but is available via apt on ubuntu) '\n\n\n
echo 'Please enter the API key for the HelloSign Account you would like to get Request IDs from. It should not include the trailing colon:'
read apiKey
apiKey=$apiKey':'
#Retrieves the number of pages of signature requests available to the given user
numPages=$(curl 'https://api.hellosign.com/v3/signature_request/list?page_size=100&page=1' -u $apiKey | jq '.["list_info"]["num_pages"]')
																				 
#Defines the location where all the signature ID's will be stored for retrieval
csvSignatureRequestIdFile=VerificationSignatureRequestIDList.csv

#Clears the file of previous data  
echo '' > $csvSignatureRequestIdFile

#Loops over each page and writes the signature_request_id field to a file
i=0
while [ $i -lt $numPages ] ; do 
	i=$[$i+1]
	echo 'Page' $i 'of' $numPages 'writing to' $csvSignatureRequestIdFile
	curl 'https://api.hellosign.com/v3/signature_request/list?page_size=100&page='$i -u $apiKey | jq '.["signature_requests"][]["signature_request_id"]' | sed -e 's/^"//' -e 's/"$//' >> $csvSignatureRequestIdFile
done
mkdir hellosign-backup

numDocuments=$(wc -l < $csvSignatureRequestIdFile)

echo "You\'ve got " $numDocuments ' in your account at the momement that you can access'
