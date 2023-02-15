#!/bin/bash

UUID_CONNECTION=$(uuidgen)
INITIAL_FILE=IONIS-BETA.nmconnection
TARGET_LOCATION=/etc/NetworkManager/system-connection
FILE=/etc/NetworkManager/system-connections/IONIS.nmconnection

if [[ -f "$FILE" ]]; then
    echo "$FILE exists."
fi

echo $UUID_CONNECTION

read -p 'Username: ' uservar
read -sp 'Password: ' passvar
echo

sed -i "s/USERNAME/$uservar/g" $INITIAL_FILE
sed -i "s/PASSWORD/$passvar/g" $INITIAL_FILE
sed -i "s/UUID/$UUID_CONNECTION/g" $INITIAL_FILE

cp $INITIAL_FILE $TARGET_LOCATION

sudo systemctl restart NetworkManager
nmcli con up IONIS

