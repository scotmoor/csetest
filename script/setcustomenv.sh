#! /bin/bash

# parse the custom data to obtain the database_name
CUSTOM_DATA=$(</var/lib/cloud/instance/user-data.txt)

if [[ -z "$CUSTOM_DATA" ]]; then
   echo "No Custom Data provided. Exiting...."
   exit 0
fi

sudo stop hello-karyon-rxnetty

export USERDATA=$CUSTOM_DATA

sudo start hello-karyon-rxnetty
