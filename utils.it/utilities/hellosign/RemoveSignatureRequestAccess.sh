#!/bin/bash

echo "*****CAUTION This will remove access to all signature requests in the csv passed to it"

echo -e "\nPlese enter the return separated file that you would like to use"
read csvFile

numRequests=$( wc -l < $csvFile )

echo 'You are going to remove '$numRequests' from the account' 

echo -e "\nPlease enter your API key with the trailing colon"
read apiKey


<<CancelLoop
while read p; do
	i=$[$i+1]
	echo 'removing access to signature request' $p
	curl 'https://api.hellosign.com/v3/signature_request/cancel/'$p -u $apiKey -X POST
done <$csvFile
CancelLoop

#<<RemoveLoop
while read p; do
	i=$[$i+1]
	echo 'removing access to signature request' $p
	curl 'https://api.hellosign.com/v3/signature_request/remove/'$p -u $apiKey -X POST
done <$csvFile
#RemoveLoop