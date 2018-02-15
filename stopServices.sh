#!/bin/bash
# Stop the given service. SHOULD be declared inside docker-compose file
. ./loadEnvironmentVars.sh

while [ "$1" != "" ]; do
    echo "Compose stop service '$1'..."
    docker-compose stop "$1"
    if [ "$?" -ne 0 ]; then
        echo "ERROR: Service '$1' could not be stopped successful!"
        exit 1
    else
        shift
    fi
done
