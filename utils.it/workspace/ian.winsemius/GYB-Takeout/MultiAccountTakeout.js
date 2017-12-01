#!/usr/bin/env node


/*Psuedo code
***********************for each user in file [argument#1] - return separated list of email addresses ending in hackreactor.com
var fs = require('fs');
fs.readFile('file.txt', function(err, data) {
    if(err) throw err;
    var array = data.toString().split("\n");
    for(i in array) {
        console.log(array[i]);
    }
});

*********************move $user to takeout org 
gam update org|ou <OrgUnitItem> add|move <CrOSTypeEntity>|<UserTypeEntity>

************transfer ownership of google drive files to CEO.Bot
gam create datatransfer|transfer <OldOwnerID> <DataTransferService> <NewOwnerID> (<ParameterKey> <ParameterValue>)*

	change users password to 'openssl rand -base64 14'
	echo $user $newpassword
	echo $user $newpassword >> HIRtakeout.log


for each user in file [argument#1]
	gyb --email youremail@gmail.com --service-account --local-folder "/home/itadmin/NAS-mount/$username"
*/
const run = require('./syncExecute.js');
var fs = require('fs');
var input = require('prompt');


input.start();
input.get(['filename'], function(err,result){
	console.log('input was ' + result.filename);
	fs.readFile(result.filename, function(err,data){
		if (err) throw err;
		var userList = data.toString().split("\n");
		console.log(userList)
		for(var i = 0; i<userList.length-1; i++){
			var user = userList[i];
			run.async("echo " + user);
		}
	});
});