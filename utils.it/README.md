#config for utils.it

##############  Utilities   #############

(offBoarding)
accounttakeout.sh 
HiR-destroy-github.sh
HiR-destroy-gsuite.sh

(onBoarding)
HiR-Create-Github.sh
HiR-Create-Gsuite.sh
Onboard-New-Hire.sh (in progress, so it should really be in workspace/ian.winsemius)

Curl-loop (like ping, but curl)




##############  variables.sh Config  ###############
#variables file
set your variables file name to variables.sh - starter files are provided for OSX and Ubuntu
the file referenced is simply variables.sh and has things like your API key for Hellosign, or other services if they're within your scope of responsibility.


##############  GAM Config  ###############
#Configure gam for all domains needed, then run the following 

sudo cp ~/.gam/* <utils.it directory>/env/.gam 
i.e. sudo cp ~/.gam/* /Users/ianwinsemius/utils.it/env/.gam

Then reconfigure gam to use that directory via:
gam select <domain> config config_dir /Users/ianwinsemius/utils.it/env/.gam 
Be sure to insert the proper user directory.
You'll need to provide your own oAuth files for your service account for each domain (see <utils.it directory>/env/.gam/gam.cfg.sample for requirements). 


##############  PATH Config  ###############
Set your PATH in your .bash_profile (sample profile below) and in your crontab to make using the variables file easier and more consistent.

#osx bash profile, with optional additions (marked as comments):

export PATH=$PATH:/Users/<username>/utils.it/env/ #then you can include the variables.sh files easily
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
#export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad
#csvPath=/Users/ianwinsemius/bin/DATA/csv #useful for some scripts where you have to give input
#alias dns="scutil --dns | grep 'nameserver\[[0-9]*\]'"
#alias whatis="gam whatis"


#linux (Ubuntu)

export PATH=$PATH:/home/<username>/bin/env/ #then you can include the variables.sh files easily