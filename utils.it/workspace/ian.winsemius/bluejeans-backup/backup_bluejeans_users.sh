#!/bin/bash
source variables.sh

while read user; do
	IFS=':' read -r -a userData <<< "$user"
	userID="${userData[0]}"
	userToken="${userData[1]}"
	userRecordings=$(curl -X GET "https://api.bluejeans.com/v1/user/$userID/meeting_history/recordings?pageSize=1000&pageNumber=1&sortBy=start_time&order=desc&access_token=$userToken" -H  "accept: application/json")
	echo $userRecordings | jq -r '.[] | select(.created >1496275200000)' | jq -r '.meetingGuid + ":" + .recordingName' > $userID"-Recordings.log"
		while read meeting; do
			IFS=":" read -ra meetingData <<< "$meeting"
			echo "${meetingData[0]}" "${meetingData[1]}" "${meetingData[2]}"
			recordingname=$(echo "${meetingData[2]}" | sed 's,/,-,g' | sed 's/ /_/g')
			userDir="$dataPath/bluejeans/$userID/$recordingname"
			if mkdir -pv "$userDir"; then
				meetingID=${meetingData[0]}
				echo $meetingID
				meetingGuid=${meetingData[0]}"%3a"${meetingData[1]}				
				contentID=$(curl -X GET "https://api.bluejeans.com/v1/user/$userID/meeting_history/$meetingID/recordings?meetingGuid=$meetingGuid&access_token=$userToken" -H  "accept: application/json" | jq -r '.[].compositeContentId')
				downloadURL=$(curl -X GET "https://api.bluejeans.com/v1/user/$userID/cms/$contentID?isDownloadable=true&access_token=$userToken" -H "accept: application/json" | jq -r '.contentUrl')
				echo "downloadURL: "$downloadURL
				echo "user dir:" $userDir/$contentID.mp4
				cd $userDir
					if curl $downloadURL -o $contentID.mp4; then
						echo "successfully downloaded contentID $contentID" >> $logPath/bluejeans/backuplog.txt
					else
						if curl $downloadURL -o $contentID.mp4; then
						echo date "successfully downloaded contentID: $contentID" >> $logPath/bluejeans/backuplog.txt
						else 
						echo date "second attempt of contentID: $contentID failed, please attempt manual download, userID: $userID meetingGuid: $meetingGuid downloadURL: $downloadURL" >> $logPath/bluejeans/backuplog.txt
						fi
					fi
				cd -
			fi
		done < $userID"-Recordings.log"
done<tokenfile.txt