#!/bin/bash
# Print logo script
. ./logo.sh

echo "Reading environment vars..."
. ./loadEnvironmentVars.sh

echo "Starting infrastructure images..."
./upServices.sh $INFRASTRUCTURE
if [ "$?" -ne 0 ]; then
    echo "ERROR: The infrastructure related services could not be started!"
    echo "Press enter to exit"
    read
    exit 1
fi

echo "Starting services images..."
./upServices.sh $SERVICES
if [ "$?" -ne 0 ]; then
    echo "ERROR: The functional services could not be started!"
    echo "Press enter to exit"
    read
    exit 1
fi

echo "Success!! enjoy your docker services!. Press enter to close."
read