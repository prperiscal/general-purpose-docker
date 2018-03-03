#!/bin/sh

logo(){
	cat << "EOF"
 _____  ______                                 ______           _
|  __ \ | ___ \                                |  _  \         | |
| |  \/ | |_/ /   _ _ __ _ __   ___  ___  ___  | | | |___   ___| | _____ _ __
| | __  |  __/ | | | '__| '_ \ / _ \/ __|/ _ \ | | | / _ \ / __| |/ / _ \ '__|
| |_\ \_| |  | |_| | |  | |_) | (_) \__ \  __/ | |/ / (_) | (__|   <  __/ |
 \____(_)_|   \__,_|_|  | .__/ \___/|___/\___| |___/ \___/ \___|_|\_\___|_|
                        | |
                        |_|

EOF
}

help(){
	cat << "EOF"
Script to control mytask docker environment

Usage:
    myTasksDocker <command> [<service> ...]

Commands:
    --help -h		-- Show this help
    --remove -rm	-- Stop and remove all containers or only the specified ones
    --start -s  	-- Start all or only the specified ones
    --stop  -st  	-- Stop all or only the specified ones
    --update -u	 	-- Update all or only the specified ones and running them
EOF
	exit 1
}

start(){
	echo "Reading environment vars..."
	loadEnv

	if [ $# -lt 1 ]; then
              startAll
        else
              upService $*
        fi
	
	echo "Success!! enjoy your docker services!."
}

startAll(){
	echo "Starting infrastructure images..."
	upService $INFRASTRUCTURE
	if [ "$?" -ne 0 ]; then
	    echo "ERROR: The infrastructure related services could not be started!"
	    echo "Press enter to exit"
	    read
	    exit 1
	fi

	echo "Starting services images..."
	upService $SERVICES
	if [ "$?" -ne 0 ]; then
	    echo "ERROR: The functional services could not be started!"
	    echo "Press enter to exit"
	    read
	    exit 1
	fi
}

stop(){
	echo "Reading environment vars..."
	loadEnv

	if [ $# -lt 1 ]; then
              stopAll
        else
              stopService $*
        fi
}

stopAll(){
	echo "Stopping services images..."
	stopService $SERVICES
	if [ "$?" -ne 0 ]; then
	    echo "ERROR: The infrastructure related services could not be started!"
	fi

	echo "Stopping infrastructure images..."
	stopService $INFRASTRUCTURE
	if [ "$?" -ne 0 ]; then
	    echo "ERROR: The functional services could not be started!"
	fi
}

update(){
	docker-compose pull $*
	echo "------------------------------------------------------------"
	echo "Success!! pulling the images!."
	echo "------------------------------------------------------------"
	start $*
}

remove(){
	stop $*
	echo "------------------------------------------------------------"
	echo "Success!! stopping the images!."
	echo "------------------------------------------------------------"
	docker-compose rm $*
}

upService(){
# Start given service. SHOULD be declared inside docker-compose file
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
}

stopService(){
# Stop the given service. SHOULD be declared inside docker-compose file
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
}

loadEnv(){
#Load all environment variables
	while IFS='' read -r line || [[ -n "$line" ]]; do
	    if [[ $line =~ [^[:space:]] ]]
	    then
	     if ! [[ "$line" == "#"* ]]
	       then
		export "$line"
		fi
	     fi
	done < "./.env"
}

close(){
	echo "Press enter to close."
	read
	exit 1
}

command="$1"
shift
services="$*"

case $command in
    -h|--help)
	logo
	help
    ;;
    --remove|-rm)
	logo
	remove $services
	close
    ;;
    --start|-s)
	logo
	start $services
	close
    ;;
    --stop|-st)
	logo
	stop $services
	close
    ;;
    --update|-u)
	logo
	update $services
	close
    ;;
    *)    # unknown option
	help
    ;;
esac
