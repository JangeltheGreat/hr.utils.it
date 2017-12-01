## the two commands you'd run
gam csv $1 gam select hackreactor update group ~id name ~name description ~description includeInGlobalAddressList ~includeInGlobalAddressList allowwebposting ~allowwebposting maxmessagebytes ~maxmessagebytes messagemoderationlevel ~messagemoderationlevel showingroupdirectory ~showingroupdirectory whocanadd ~whocanadd whocaninvite ~whocaninvite whocanjoin ~whocanjoin whocanpostmessage ~whocanpostmessage whocanviewgroup ~whocanviewgroup whocanviewmembership ~whocanviewmembership replyto ~replyto 
commit-batch
gam csv $1 gam update group ~id sync member users ~groupmembers

## columns in the csv file that match the command above 
##id includeInGlobalAddressList allowexternalmembers allowwebposting maxmessagebytes memberscanpostasthegroup messagemoderationlevel showingroupdirectory whocanadd whocaninvite whocanjoin whocanpostmessage whocanviewgroup whocanviewmembership replyto members