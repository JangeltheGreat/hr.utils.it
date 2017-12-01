#!/bin/bash

source variables.sh
read -p 'What is the file id?' file_id
read -p 'Which domain should be searched? [hr, tga, mks, rc]' domain

if [[ $domain = 'hr' ]]; then
	DOMAIN='hackreactor'
	adminUser=ceo.bot
elif [[ $domain = 'tga' ]]; then
	DOMAIN='telegraphacademy'
	adminUser=core.admin
elif [[ $domain = 'mks' ]]; then
	DOMAIN='makersquare'
	adminUser=core.admin
elif [[ $domain = 'rc' ]]; then
	DOMAIN='reactorcore'
	adminUser=ceo.bot
fi

$gamPath select $DOMAIN user $adminUser show fileinfo "$file_id" name > file.info
file_name=$(tail "-1" < file.info | cut -f 2 -d ':' | xargs)
$gamPath select hackreactor user ceo.bot show filelist query "name = '$file_name'" | tail "-1" | cut -f 3 -d ','