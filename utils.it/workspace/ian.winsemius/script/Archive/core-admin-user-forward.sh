#!/bin/bash

echo "This script will add forwarding addresses,"
echo "and filters to set forwards, to a user, from a csv of user IDs"
echo "Please check the headers of your CSV to ensure the ID header is 'ID'" 
echo "and the new address is 'newAddress'"
read -p "Which GAM domain is this for? (telegraph, reactorcore, makersquare) " domain
echo "emails sent to this domain for the users in the CSV will be filtered through Migration.bot"
read -p "What service account will these emails hit on that domain? " user1
#read -p "What service account will these emails get forwarded to on HR? " HRuser #migration.bot

#gam csv $1 gam select hackreactor user $HRuser add forwardingaddresses ~newAddress

#sleep 5

gam csv $1 gam select $domain create alias ~ID group $user1 #i.e. core.admin@tga.com

sleep 5

#gam csv $1 gam select $domain user $user1 add filter to ~ID forward migration.bot

gam csv $1 gam select hackreactor user migration.bot add filter to ~ID forward ~newAddress