#!/bin/bash
# Script to stop all

. ./loadEnvironmentVars.sh

echo "Stopping services images..."
./stopServices.sh $SERVICES
if [ "$?" -ne 0 ]; then
    echo "ERROR: The functional services could not be stopped!"
fi

echo "Stopping infrastructure images..."
./stopServices.sh $INFRASTRUCTURE
if [ "$?" -ne 0 ]; then
    echo "ERROR: At least one infrastructure container could not be stopped successful!"
fi

echo "Press enter to exit"
read
exit 1