
echo '#############depricated################'

#!/bin/bash

source variables.sh

cd $csvPath

read -pe 'What csv should I be ingesting?' csv

gam csv $csv gam user ~id delete groups
password=$(openssl rand -base64 30)
gam csv $csv gam user update password $password
gam csv $csv update org "Google Takeout" add user $username

echo '############################################'
echo '############################################'
echo '## Gam process Completed, you should run ###'
echo '## accountTakout.sh in ../GYB-Takeout ######'
echo '## to complete the offboarding process. ####'
echo '###### Have fun!! ##########################'
echo '############################################'
echo '############################################'

cd -