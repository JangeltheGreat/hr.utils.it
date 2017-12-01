#!/usr/bin/env node


/*Psuedo code

for each user in file [argument#1]
	gyb --email youremail@gmail.com --service-account --local-folder "/home/itadmin/NAS-mount/$username"
*/
const run = require('./syncExecute.js');
var fs = require('fs');
var input = require('prompt');


input.start();
console.log('This script backs up single users, please supply a full email address');
input.get(['username'], function(err,result){
	console.log('Username supplied was: ' + result.username);		
	var username = result.username;
	run.async('gam update org "Google Takeout" add user '+username);
	run.async('gam create datatransfer '+username+' "drive and docs" ceo.bot');
	var password = Math.random().toString(36).substring(2);
	run.async('gam update user '+username+' password '+password);
	run.sync('mkdir -p ~/Documents/Takeout/'+username);
	run.sync('gyb --email '+username+' --service-account --local-folder ~/Documents/Takeout/'+username);
});



//fs.readFile(
//	)


