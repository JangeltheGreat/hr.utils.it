#!/bin/bash
source variables.sh

#echo "************************************************"
#echo 
#echo "please enter your dates in the format yyyy-mm-dd"
#echo 
#echo "************************************************"
#read -p "Please enter the starting date for your search: " fromdate
#read -p "please enter the ending date for your search: " todate
fromdate="2017-08-21"
todate="2017-09-12"

read -p "please enter the title for your search: " documenttitle

encodetitle=$( echo "$documenttitle" | sed 's/ /+/g' )

read -p "please enter an api_id that shouldnt be missing: " api_id

query="query=created:\{$fromdate+TO+$todate\}+AND+title:$encodetitle"
#2017-01-01+TO+2017-09-15
pageSize=1
numPages=$(curl "https://api.hellosign.com/v3/signature_request/list?page=1&page_size=$pageSize&$query" -u $hellosignApiKey | jq '.["list_info"]["num_pages"]')
echo 
echo "There are $numPages documents to check for empty $api_id fields" 
echo 

pageNum=1
while [ $pageNum -le $numPages ] ; do 
	echo
	echo "Checking document $pageNum for empty $api_id fields" 
	echo 
	documentdata=$(curl "https://api.hellosign.com/v3/signature_request/list?page=$pageNum&page_size=$pageSize&query=created:\{$fromdate+TO+$todate\}+AND+title:$encodetitle" -u "$hellosignApiKey")
	fielddata=$(echo $documentdata | jq '."signature_requests"[]."custom_fields"[] | select ( ."api_id" | contains("'$api_id'") ) | ."value"')
	filepath="$tmpPath/$documenttitle.csv"
	
	signatureid=$(echo $documentdata | jq '.["signature_requests"][]["signature_request_id"]')
	echo
	echo "Field data for the document $signatureid document # $pageNum is $fielddata"
	echo

	if [[ $fielddata == "null" ]]; then 
		echo
		echo "There is an empty field in the $signatureid document" 
		echo
		echo $signatureid >> $filepath
	fi
	pageNum=$[$pageNum+1]
done

#d4a8b427dbb9ba159a6f7bcf74e77a4d908a623b
#documenttitle="1-SFM-112717_Hack_Reactor_SAN_FRANCISCO_Student_Enrollment_Agreement"
#api_id=56dcfe_28
#search
#curl 'https://api.hellosign.com/v3/signature_request/d4a8b427dbb9ba159a6f7bcf74e77a4d908a623b' -u 'b99b3118e2b01676e574f4b6d7689cc4910418d6c3a05fdc7fed758929cfea83:'
#curl  "https://api.hellosign.com/v3/signature_request/list?query=created:\{2017-01-01+TO+2017-09-15\}+AND+title:1-SFM-112717+Hack+Reactor+SAN+FRANCISCO+Student+Enrollment+Agreement" -u "b99b3118e2b01676e574f4b6d7689cc4910418d6c3a05fdc7fed758929cfea83:"
#jq '."signature_requests"[]."custom_fields"[] | select ( ."api_id" | contains("56dcfe_28") ) | ."value"'


#A-1d-ATX-100217 Student Enrollment Agreement
#1919dd_102
