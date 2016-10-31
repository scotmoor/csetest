#! /bin/bash

# parse the custom data to obtain the database_name

# pull down the config file locally

SOURCE="https://raw.githubusercontent.com/scotmoor/csetest/script/app_config.js"
if [[ ! -d "~/tmp" ]]; then
    mkdir "~/tmp"
fi 

sudo curl -o "~/tmp" $SOURCE

# update the database_name value
sudo sed -i -u s/DATABASE_NAME/g ~/tmp/app_config.js

sudo cp /home/scotm/source/repos/angular-app/server/config.js ~/tmp/config.js
sudo cp ~/tmp/app_config.js /home/scotm/source/repos/angular-app/server/config.js

# restart the server

# sudo node /home/scotm/source/repos/angular-app/server/server.js 