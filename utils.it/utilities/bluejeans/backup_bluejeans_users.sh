#!/bin/bash
source variables.sh

while read user; do
	IFS=':' read -r -a userData <<< "$user"
	userID="${userData[0]}"
	userToken="${userData[1]}"
	userRecordings=$(curl -X GET "https://api.bluejeans.com/v1/user/$userID/meeting_history/recordings?pageSize=1000&pageNumber=1&sortBy=start_time&order=desc&access_token=$userToken" -H  "accept: application/json")
	mkdir -p $tmpPath
	mkdir -p $logPath/bluejeans
	echo $userRecordings | jq -r '.[] | select(.created >1509926400000)' | jq -r '.meetingGuid + ":" + .recordingName' > $logPath/bluejeans/$userID"-Recordings.log"
		while read meeting; do
			IFS=":" read -ra meetingData <<< "$meeting"
			recordingName=$(echo "${meetingData[2]}" | sed 's,/,-,g' | sed 's/ /_/g')
			userDir="$dataPath/mp4/bluejeans/$userID/$recordingName"
			if mkdir -pv "$userDir"; then
				meetingID=${meetingData[0]}
				meetingGuid=${meetingData[0]}"%3a"${meetingData[1]}
				curl -X GET "https://api.bluejeans.com/v1/user/$userID/meeting_history/$meetingID/recordings?meetingGuid=$meetingGuid&access_token=$userToken" -H  "accept: application/json" | jq -r '.[].compositeContentId' > $tmpPath/contentID.txt
				while read contentID; do
					downloadURL=$(curl -X GET "https://api.bluejeans.com/v1/user/$userID/cms/$contentID?isDownloadable=true&access_token=$userToken" -H "accept: application/json" | jq -r '.contentUrl')
					cd $userDir
						if curl $downloadURL -o $contentID.mp4; then
							echo "{'download': success, 'contentID': $contentID, 'userID' : $userID, 'userToken': $userToken 'recordingName': $recordingName 'date': $(date)}" >> $logPath/bluejeans/$(date +%Y-%m-%d)-backuplog.txt
						else
							if curl $downloadURL -o $contentID.mp4; then
							echo "{'download': success, 'contentID': $contentID, 'userID' : $userID, 'userToken': $userToken 'recordingName': $recordingName 'date': $(date)}" >> $logPath/bluejeans/$(date +%Y-%m-%d)-backuplog.txt
							else 
							echo "{'download': failure, 'contentID': $contentID, 'userID' : $userID, 'userToken': $userToken 'recordingName': $recordingName 'date': $(date)}" >> $logPath/bluejeans/$(date +%Y-%m-%d)-backuplog.txt
							fi
						fi
					cd -
				done < $tmpPath/contentID.txt
			else
				echo "{'foldercreation': failure, 'directory': $userDir date': $(date)}" >> $logPath/bluejeans/$(date +%Y-%m-%d)-backuplog.txt
			fi
		done < $logPath/bluejeans/$userID"-Recordings.log"
done<tokenfile.txt
