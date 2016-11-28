#! /bin/bash

# parse the custom data to obtain the database_name
CUSTOM_DATA=$(</var/lib/cloud/instance/user-data.txt)

if [[ -z "$CUSTOM_DATA" ]]; then
   echo "No Custom Data provided. Exiting...."
   exit 0
fi

echo $CUSTOM_DATA

sudo stop hello-karyon-rxnetty

sudo start hello-karyon-rxnetty CUSTOMDATA=$CUSTOM_DATA
