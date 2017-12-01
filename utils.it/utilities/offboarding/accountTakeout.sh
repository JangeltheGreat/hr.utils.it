source variables.sh

domain='notset'
accountnumber='notset'

#gyblocation='/home/itadmin/bin/gyb/' #cron server

logdir="$logPath/gyb/" #osx
logfile="$logdir`date +%Y-%m-%d`log.txt"
mkdir -p $logdir
touch "$logfile"
while [[ "$accountnumber" != "one" ]] && [[ "$accountnumber" != 'More' ]] && [[ "$accountnumber" != 'more' ]]; do  
    read -p 'are you backing up one accountnumber, or more [one, More]: ' accountnumber 
    while [[ "$domain" != 'rc' ]] && [[ "$domain" != 'hr' ]] && [[ "$domain" != 'mks' ]] && [[ "$domain" != 'tga' ]] && [[ "$domain" != 'HR' ]] && [ ! -z "$domain" ]; do
    read -p 'What domain are you operating on? [rc,HR,tga,mks]: ' domain 
        if [[ $domain == 'hr' ]] || [[ $domain == 'HR' ]] || [ -z "$domain" ]; then 
                gybBinary="$gybPath/gybhr/gyb"
                domainsuffix='@hackreactor.com'
                gamcommand="$gamPath select hackreactor"
                adminuser='ceo.bot'
        elif [[ $domain == 'rc' ]]; then 
                gybBinary="$gybPath/gybrc/gyb"
                domainsuffix='@reactorcore.com'
                gamcommand="$gamPath select reactorcore"
                adminuser='ceo.bot'
        elif [[ $domain == 'tga' ]]; then 
                gybBinary="$gybPath/gybtga/gyb"
                domainsuffix='@telegraphacademy.com'
                gamcommand="$gamPath select telegraph"
                adminuser='core.admin'
        elif [[ $domain == 'mks' ]]; then 
                gybBinary="$gybPath/gybmks/gyb"
                domainsuffix='@makersquare.com'
                gamcommand="$gamPath select makersquare"
                adminuser='core.admin'
        else 
                echo;echo 'You have chosen poorly.... try again';echo
        fi
    done
    if [[ $accountnumber == 'one' ]]; then
        read -p 'Please supply a username (withouth the @hackreactor.com): ' username
        password=$(openssl rand  -base64 30)
        $gamcommand update org "Google Takeout" add user $username
        $gamcommand update user $username password "$password"

        $gamcommand create datatransfer $username "drive and docs" $adminuser
        mkdir -p "$emlPath/$username"
        $gybBinary --email "$username$domainsuffix" --service-account --local-folder "$emlPath/$username/" >> $logfile
        if tar -zcvf "$emlPath/$username.tar.gz" "$emlPath/$username/"; then
            echo `date` '- SUCCESS - process completed for ' $username >> $logfile
            rm -rf "$emlPath/$username/"
        else
            echo; echo "`date` - ERROR -" $username " failed to back up to archive" >> $logfile
        fi
    elif [[ $accountnumber == "more" ]] || [[ $accountnumber == "More" ]] || [[ -z "$accountnumber" ]] || [[ $accountnumber == "M" ]]; then
        echo 'Give me a file to ingest. You are currently in the CSV Path for your system' 
        cd $csvPath
        read -e filename
        echo >> $filename
        password=$(openssl rand  -base64 30)
        while read username; do 
            $gamcommand update org 'Google Takeout' add user $username
            echo "$gamcommand update org 'Google Takeout' add user $username"
            $gamcommand update user $username password "$password"
            echo "$gamcommand update user $username password $password"
                    sleep 10
            $gamcommand create datatransfer $username "drive and docs" $adminuser

            mkdir -p ~/Documents/Takeout/$username
            $gybBinary --email "$username$domainsuffix" --service-account --local-folder "$emlPath/$username/" >> $logfile
            if tar -zcvf "$emlPath/$username.tar.gz" "$emlPath/$username/"; then
                echo `date` '- SUCCESS - process completed for ' $username >> $logfile
                rm -rf "$emlPath/$username/"
            else
                echo; echo "`date` - ERROR -" $username " failed to back up to archive" >> $logfile
            fi
        done<$filename
    cd -
    else 
        echo 'Those are the only options, please try again or CRTL-C to exit' 
    fi
done