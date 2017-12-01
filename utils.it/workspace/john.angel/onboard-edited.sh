#!/bin/bash

source variables.sh

echo "You'll need to have set up, or have on hand, a GitHub account for the person that you're onboarding. If you have not done that, go do it now :)"
read -p 'Please enter a first name for the person you would like to onboard: ' fname
read -p 'Please enter a last name for the person you would like to onboard: ' lname
read -p 'Please enter a github username for them as well: ' githubuser
read -p 'Please enter thier github password (if you have it): ' githubpassword
read -p 'Enter any email groups (i.e. their role group) that they need to be added to, separated by spaces: ' grouplist

campus='notset'
while [[ $campus != 'SFM' ]] && [[ $campus != 'atx' ]] && [[ $campus != 'hrr' ]] && [[ $campus != 'rpt' ]] && [[ $campus != 'la' ]] && [[ $campus != 'nyc' ]] && [[ $campus != 'sfm' ]] ; do
    read -p 'Please enter a campus for this person[SFM,atx,hrr,rpt,la,nyc]: ' campus
done

username=$fname.$lname
password=$(openssl rand -base64 30)

# Create Gsuite User account, and add org wide things like campus.team and calendar.admin 
gam create user $username firstname $fname lastname $lname
gam update user $username password $password
gam update group $campus.team add member $username
gam user $username add groups $grouplist
gam calendar $username add owner calendar.admin@hackreactor.com

#All campus calendars
gam user $username add calendars 'hackreactor.com_2q71g1rjmj7m3q628oconr27pg@group.calendar.google.com hackreactor.com_u2ghnt6agek62ohdjfhcafssi4@group.calendar.google.com hackreactor.com_dvb1bib6vvrds04fi1u8oh1vt8@group.calendar.google.com'

#Campus specific commands
if [[ $campus == 'atx' ]]; then
    echo 'ATX campus specific operations'
elif [[ $campus == 'sfm' ]] || [[ $campus == 'SFM' ]]; then
    echo 'SFM campus specific operations'
    gam user $username add groups 'sfm.callout'
elif [[ $campus == 'hrr' ]]; then
    echo 'HRR campus specific operations'
elif [[ $campus == 'rpt' ]]; then
    echo 'RPT campus specific operations'
elif [[ $campus == 'la' ]]; then
    echo 'LA campus specific operations'
elif [[ $campus == 'nyc' ]]; then
    echo 'NYC campus specific operations'
fi

echo '############################################'
echo '####### Gam Onboarding Completed ###########'
echo '############################################'
echo
read -p 'Is this person a tech mentor? [Y,n]' techMentor

echo $githubuser >> $githubuser.tmp

forkchop tma reactorcore '(R) Curriculum Org-wide' $githubuser.tmp
forkchop tma hackreactor 'Staff: Employees' $githubuser.tmp
#Campus specific commands
if [[ $campus == 'atx' ]]; then
    echo 'ATX campus specific operations'
    forkchop tma hackreactor '(W) Staff: ATX' $githubuser.tmp
elif [[ $campus == 'sfm' ]] || [[ $campus == 'SFM' ]]; then
    echo 'SFM campus specific operations'
    forkchop tma hackreactor '(W) Staff: SFM' $githubuser.tmp
    gam user $username add groups 'sfm.callout'
elif [[ $campus == 'hrr' ]]; then
    echo 'HRR campus specific operations'
    forkchop tma hackreactor '(W) Staff: Remote' $githubuser.tmp
elif [[ $campus == 'rpt' ]]; then
    echo 'RPT campus specific operations'
    forkchop tma hackreactor '(W) Staff: RPT' $githubuser.tmp
elif [[ $campus == 'la' ]]; then
    echo 'LA campus specific operations'
    forkchop tma hackreactor '(W) Staff: LA' $githubuser.tmp
elif [[ $campus == 'nyc' ]]; then
    echo 'NYC campus specific operations'
    forkchop tma hackreactor '(W) Staff: NYC' $githubuser.tmp
fi

if [ $techMentor != 'n' ] ; then
    forkchop tma reactorcore '(W) Curriculum Org Wide' $githubuser.tmp
    forkchop tma hackreactor "(R) Curriculum Org Wide" $githubuser.tmp
    forkchop tma hackreactor 'Staff: Mentors' $githubuser.tmp
    forkchop tma hackreactor '(R) Mentors' $githubuser.tmp
    forkchop tma hackreactor-labs "(R) Instruction Team" $githubuser.tmp
    forkchop tma hackreactor-labs "(R) Mentors" $githubuser.tmp
    forkchop tma reactorcore "(R) Instruction Team" $githubuser.tmp
fi


rm $githubuser.tmp

echo '############################################'
echo '###### Github Onboarding Completed #########'
echo '############################################'
echo

lPAccount='notset'
while [[ $lPAccount != 'y' ]] && [[ $lPAccount != 'n' ]] ; do
    read -p 'Does this person need a LastPass Account [y,N]' lPAccount
done
if [[ $lPAccount == 'y' ]]; then
    curl -H "Content-Type: application/json" -POST -d '
        {
            "cid": "7913756",
            "provhash": "'$lastpassApiKey'",
            "cmd": "batchadd",
            "data": [
                {
                    "username": "'$username'@hackreactor.com",
                    "fullname": "'$fname' '$lname'",
                    "password": "'$password'",
                    "password_reset_required": true
                }
            ]
        }' https://lastpass.com/enterpriseapi.php
    curl -H "Content-Type: application/json" -POST -d '
          {
            "cid": "7913756",
            "provhash": "'$lastpassApiKey'",
            "cmd": "pushsitestousers",
            "data": {
                "users": "'$username'@hackreactor.com",
                "persistent": "0",
                "url": "https://github.com",
                "name": "Github",
                "group": "",
                "usernametype": "custom",
                "username": "'$githubuser'",
                "password": "'$githubpassword'",
                "notes": "",
                "fav": "",
                "decryptid": "0"
            }
        }' https://lastpass.com/enterpriseapi.php
    curl -H "Content-Type: application/json" -POST -d '
          {
            "cid": "7913756",
            "provhash": "'$lastpassApiKey'",
            "cmd": "pushsitestousers",
            "data": {
                "users": "'$username'@hackreactor.com",
                "persistent": "0",
                "url": "https://github.com",
                "name": "Github",
                "group": "",
                "usernametype": "custom",
                "username": "'$username'@hackreactor.com",
                "password": "'$password'",
                "notes": "",
                "fav": "",
                "decryptid": "0"
            }
        }' https://lastpass.com/enterpriseapi.php
    echo
    echo '############################################'
    echo '######## LastPass setup Completed ##########'
    echo '############################################'
    echo
    echo "Username for $fname $lname's Lastpass and Gsuite account: $username@hackreactor.com"
    echo "Password for $fname $lname's Lastpass and Gsuite account: $password"
else 
    echo '############################################'
    echo '########## Onboarding Completed ############'
    echo '############################################'
    echo
    echo "Username for $fname $lname's Gsuite account: $username@hackreactor.com"
    echo "Password for $fname $lname's Lastpass and Gsuite account: $password"
fi
