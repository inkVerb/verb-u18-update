#!/bin/sh
# This is intended to be run by crontab to automatically renew letsencrypt certs

# Include settings
. /var/local/verb/configs/sitenameip

# Stop Apache
apachectl -k graceful-stop
## Hard stop in case it doesn't work
service apache2 stop

# Renew LE
letsencrypt renew

# Log
if [ $? -ne 0 ]
 then
        ERRORLOG=`tail /var/log/letsencrypt/letsencrypt.log`
        echo -e "The Lets Encrypt verb.ink cert has not been renewed! \n \n" $ERRORLOG | mail -s "Lets Encrypt Cert Alert" ${SITEINKCERTEMAIL}   
fi

# Start Apache
service apache2 start

# Finish
exit 0

