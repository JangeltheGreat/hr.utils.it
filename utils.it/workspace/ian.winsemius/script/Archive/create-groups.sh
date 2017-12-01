## the two commands you'd run
gam csv $1 gam select hackreactor create group ~id name ~name description ~description includeInGlobalAddressList ~includeInGlobalAddressList allowwebposting ~allowwebposting maxmessagebytes ~maxmessagebytes messagemoderationlevel ~messagemoderationlevel showingroupdirectory ~showingroupdirectory whocanadd ~whocanadd whocaninvite ~whocaninvite whocanjoin ~whocanjoin whocanpostmessage ~whocanpostmessage whocanviewgroup ~whocanviewgroup whocanviewmembership ~whocanviewmembership replyto ~replyto 
commit-batch
sleep 10
gam csv $1 gam update group ~id add member users ~groupmembers

## columns in the csv file that match the command above 
##id includeInGlobalAddressList allowexternalmembers allowwebposting maxmessagebytes memberscanpostasthegroup messagemoderationlevel showingroupdirectory whocanadd whocaninvite whocanjoin whocanpostmessage whocanviewgroup whocanviewmembership replyto members
## command to create one hidden group
## gam create group <ID> name <name> description <description> showingroupdirectory false includeInGlobalAddressList false allowwebposting false maxmessagebytes 100m messagemoderationlevel MODERATE_NONE whocanadd NONE_CAN_ADD whocaninvite ALL_MANAGERS_CAN_INVITE whocanjoin INVITED_CAN_JOIN whocanpostmessage ANYONE_CAN_POST whocanviewgroup ALL_MANAGERS_CAN_VIEW whocanviewmembership ALL_MANAGERS_CAN_VIEW replyto REPLY_TO_LIST
## command to create one visible group
## gam create group <ID> name <name> description <description> showingroupdirectory true includeInGlobalAddressList true allowwebposting false maxmessagebytes 100m messagemoderationlevel MODERATE_NONE whocanadd NONE_CAN_ADD whocaninvite ALL_MANAGERS_CAN_INVITE whocanjoin INVITED_CAN_JOIN whocanpostmessage ANYONE_CAN_POST whocanviewgroup ALL_MANAGERS_CAN_VIEW whocanviewmembership ALL_MANAGERS_CAN_VIEW replyto REPLY_TO_LIST
