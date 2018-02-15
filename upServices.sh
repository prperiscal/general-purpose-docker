#!/bin/bash
# Start given service. SHOULD be declared inside docker-compose file
. ./loadEnvironmentVars.sh

while [ "$1" != "" ]; do
    echo "Compose up service '$1'..."
    docker-compose up -d "$1"
    if [ "$?" -ne 0 ]; then
        echo -e "ERROR: Service '$1' could not be started successful!"
        exit 1
    else
        shift
    fi
done
