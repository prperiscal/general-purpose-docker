#!/bin/bash
# Pull & start
# Just execute pull and startAll scripts
. ./loadEnvironmentVars.sh

./updateDocker.sh
./startAll.sh