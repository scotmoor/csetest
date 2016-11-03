#! /bin/bash

# parse the custom data to obtain the database_name
CUSTOM_DATA=$(</var/lib/cloud/instance/user-data.txt)

if [[ -z "$CUSTOM_DATA" ]]; then
   echo "No Custom Data provided. Exiting...."
   exit 0
fi

echo " "
echo "Parsing custom data: $CUSTOM_DATA"
echo " "

# parse the custom data string
declare -a PARAMS=(${CUSTOM_DATA//;/ })

#echo ${PARAMS[0]}
#echo ${PARAMS[1]}

for param in ${PARAMS[@]}
do
    declare -a p=(${param//:/ })
    #echo "Parameter: " ${p[0]}
    if [[ "${p[0]}" == "dbname" ]]; then        
        DBNAME=${p[1]}
        echo $DBNAME
    fi
    
    if [[ "${p[0]}" == "appname" ]]; then        
        APPNAME=${p[1]}
    fi    
done

echo "DB NAME: " $DBNAME
echo "APP NAME: " $APPNAME


# pull down the config file locally


SOURCE="https://raw.githubusercontent.com/scotmoor/csetest/master/script"
TMP="/tmp"
DEST="/home/cddemo/angular-app"

echo " "
echo "Getting updated files from: $SOURCE"
echo "sudo curl -o "$TMP/config.js" $SOURCE/config.js"
sudo curl -o "$TMP/config.js" $SOURCE/config.js
echo "sudo curl -o "$TMP/header.tpl.html" $SOURCE/header.tpl.html"
sudo curl -o "$TMP/header.tpl.html" $SOURCE/header.tpl.html
echo "sudo curl -o "$TMP/app.js" $SOURCE/app.js"
sudo curl -o "$TMP/app.js" $SOURCE/app.js

# update the database_name value
# server config
echo " "
echo "Updating server configuration"
sudo cp $DEST/server/config.js $TMP/config_old.js
sudo sed -i -u s/DATABASE_NAME/$DBNAME/g $TMP/config.js
sudo cp $TMP/config.js $DEST/server/config.js

# client config
sudo cp $DEST/client/src/app/app.js $TMP/app_old.js
sudo cp $DEST/client/src/app/header.tpl.html $TMP/header.tpl_old.html
echo " "
echo "updating client database configuration"
sudo sed -i -u s/DATABASE_NAME/$DBNAME/g $TMP/app.js

echo " "
echo "updating application name"
sudo sed -i -u s/APP_NAME/$APPNAME/g $TMP/header.tpl.html
sudo cp $TMP/app.js $DEST/client/src/app/app.js 
sudo cp $TMP/header.tpl.html $DEST/client/src/app/header.tpl.html 

echo " "
echo "rebuilding client"
cd /home/cddemo/angular-app/client
grunt build

# restart the server
echo " "
echo "Restarting server....."
cd ../server
sudo node server.js &

echo " "
echo "Update script completed"
