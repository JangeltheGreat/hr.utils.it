#!/bin/bash

source variables.sh
alias jq="$userPath/utils.it/workspace/john.angel/zoom/jq"

#variables
i=1
y=1

#create interview_videos folder and dated folder then cd into dated folder.  $todaysDate set in variables.sh
mkdir "$videoStoragePath/interview_videos"
mkdir "$videoStoragePath/interview_videos/$todaysDate"
cd "$videoStoragePath/interview_videos/$todaysDate"

#for loop performing script of each host_id of hir interviewer accounts
# bash command for getting info on user accounts:  curl --data "api_key=$zoomApiKey&api_secret=$zoomApiSecret&host_id=$host_id&page_size=300" https://api.zoom.us/v1/user/list
for host_id in $(cat $csvPath/zoom/account.host_ids)
do

# Pull JSON info on recordings and put in file
curl --data "api_key=$zoomApiKey&api_secret=$zoomApiSecret&host_id=$host_id" https://api.zoom.us/v1/recording/list >> .recordings_data
wait
done

#filter recordings into array with topic containing date: value and dl_url: value
jq '.meetings[] | {(.topic): {"date": (.start_time | fromdate),  "dl_url": (.recording_files[].download_url)}}' < .recordings_data > .object_date
wait

#filter recordings into array with topic containing date: value and file_size: value
jq '.meetings[] | {(.topic): {"date": (.start_time | fromdate),  "size": (.recording_files[].file_size)}}' < .recordings_data > .object_size
wait

#jq if loop generating epoch seconds, comparing objects "date" value to it, filtering out older meetings, then removing "date" and value pair
#date is set to 00:00 of previous day (assuming script runs at 02:00)  $DATE set in variables.sh
jq "if (.[].date) < $DATE then
		del(.[])
	else
		. | del(.[].date)
	end" < .object_date > .date-filtered_object
wait

#same as previous if loop but filtering for file_size
jq "if (.[].date) < $DATE then
        del(.[])
    else
        . | del(.[].date)
    end" < .object_size > .size-filtered_object
wait

#checks for assumed ordering of files in recording file
#filters for file_types of recording files in last recording made (MP4 vs M4A)
jq -r '.meetings[].recording_files[].file_type' < .recordings_data | head -n 2 > .file_type.txt
wait

#if loop with error/success messaging for file_type ordering
file_type=$(tail -n 1 < .file_type.txt)
file_type2=$(head -n 1 < .file_type.txt)
if [ $file_type == M4A ]; then
    if [[ $file_type2 == MP4 ]]; then
        echo "File types look good"
    fi
else
    echo "Issue with file types on $todaysDate" | mail -s "Video Download Error" john.angel@hackreactor.com 
fi

#filter object file for dl_url and filename
jq -r 'keys | .[]' < .date-filtered_object | awk "NR % 2 == 1" > .filenames.txt
wait
jq -r '.[].dl_url' < .date-filtered_object | awk "NR % 2 == 1" > .dl_urls.txt 
wait
jq -r '.[].size' < .size-filtered_object | awk "NR % 2 == 1" > .file_sizes.txt
wait

#for loop for downloading and naming video files
for dl_url in $( cat .dl_urls.txt)
do
    curl -L $dl_url > video.mp4
    filename=$(awk "NR == $i" < .filenames.txt)
    size=$(awk "NR == $i" < .file_sizes.txt)
    
    #if loop checking filename against existing files and incrementing in case of duplicates
    if [ -e "$userPath/interview_videos/$todaysDate/$filename.mp4" ];
    	then
    	filename="$filename-$y"
    	mv video.mp4 "$userPath/interview_videos/$todaysDate/$filename.mp4"
        y=$(($y+1))
    else
    	mv video.mp4 "$userPath/interview_videos/$todaysDate/$filename.mp4"
    fi

    #nested if loops checking for existence of file and correct size in bytes and logging it
    if [ -e "$userPath/interview_videos/$todaysDate/$filename.mp4" ]; then z=1;
            file_size=$(stat -f %z "$userPath/interview_videos/$todaysDate/$filename.mp4")
            if [[ $size == $file_size ]]; then
                echo "$todaysDate/$filename.mp4 has properly downloaded" >> "$userPath/interview_videos/download_log"
            else
                while [[ "$z" < 5 ]]; do
                    curl -L $dl_url > "$userPath/interview_videos/$todaysDate/$filename.mp4"
                    z=$(($z+1))
                done    
            fi
	
    else
        echo "error downloading $todaysDate/$filename.mp4" >> "$userPath/interview_videos/download_log"
    fi
    y=1
    i=$(($i+1))

done