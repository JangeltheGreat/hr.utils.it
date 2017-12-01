##This script is designed to be run at will. It will pull down all the signatures that have occured in the specified date range

source variables.sh

echo 'Please enter the starting date for the range in the format YYYY-MM-DD'
read startDate
echo -e "\nPlease enter the ending date for the range in the format YYYY-MM-DD"
read endDate
if [ !hellosignApiKey ] ; then
	read -p hellosignApiKey "please enter your hellosign API key with the trailing colon"
fi
echo 'are you running this again because you made a mistake [Y/n]'

dateRange=$startDate"+TO+"$endDate 

pageSize=1
query="query=created:\{$dateRange\}+AND+title:SSP+\(New+Registration\)+Terms+and+Conditions+AND+complete:true"

numPages=$(curl "https://api.hellosign.com/v3/signature_request/list?page=1&page_size=$pageSize&$query" -u $hellosignApiKey | jq '.["list_info"]["num_pages"]')
SSPSignaturesFile=$csvPath/Archive/'AtWill'$startDate'to'$endDate'-SSPSignatures.csv'
echo -e "\n\n There are $numPages signatures"

echo "'This file will never update itself. It was run on',`date`," >> $SSPSignaturesFile

pageNum=1
while [ $pageNum -le $numPages ] ; do 
	signerData=$(curl -v "https://api.hellosign.com/v3/signature_request/list?page=$pageNum&page_size=$pageSize&$query" -u $apiKey)
	dateSignedData=$(echo $signerData | jq '.["signature_requests"][]["response_data"][2]["value"]')
	signerEmailData=$(echo $signerData | jq '.["signature_requests"][]["signatures"][]["signer_email_address"]')
	signerNameData=$(echo $signerData | jq '.["signature_requests"][]["response_data"][1]["value"]')
	pageNum=$[$pageNum+1]
	echo $signerNameData", "$signerEmailData", "$dateSignedData >> $SSPSignaturesFile
done 


SSPSignaturesDriveFile='AtWill'$dateRange'-SSPSignatures'
gam user ceo.bot add drivefile drivefilename "$SSPSignaturesDriveFile" parentID 0ByLS0VkxubTDZTF0dkxWcE1BUXc localfile $SSPSignaturesFile mimetype gsheet

echo 'this script will remove the csv used to create the drive file in 30 seconds'


rm $SSPSignaturesFile