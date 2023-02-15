#!/bin/bash

UUID_CONNECTION=$(uuidgen)
INITIAL_FILE=IONIS.nmconnection
TARGET_LOCATION=/etc/NetworkManager/system-connections
FILE=/etc/NetworkManager/system-connections/IONIS.nmconnection

function network_manager_exist() {
	if [[ -f "$FILE" ]]; then
    	echo "IONIS.nmconnection replace"
	fi
}

function set_credentials() {
	read -p 'Username: ' uservar
	read -sp 'Password: ' passvar
	echo

	sed -i "s/USERNAME/$uservar/g" $INITIAL_FILE
	sed -i "s/PASSWORD/$passvar/g" $INITIAL_FILE
	sed -i "s/UUID/$UUID_CONNECTION/g" $INITIAL_FILE
}

function reload_network_manager() {
	sudo cp $INITIAL_FILE $TARGET_LOCATION

	sudo systemctl restart NetworkManager
	nmcli con up IONIS
}

function main() {
	network_manager_exist
	set_credentials
	reload_network_manager
	exit 0
}

main
