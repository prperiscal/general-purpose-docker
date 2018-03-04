[![Codacy Badge](https://api.codacy.com/project/badge/Grade/fc374edda9e9433a8214b8555deb5f39)](https://www.codacy.com/app/prperiscal/general-purpose-docker?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=prperiscal/general-purpose-docker&amp;utm_campaign=Badge_Grade)

# general-purpose-environment

General purpose micro-services and architecture provide an extended and robust base from where a new project
can be started and developed following a consolidated agile approach and with the most used and assumed technologies in the 
micro-service spring development ecosystem.

Take a look on [General Purpose Environment](https://gist.github.com/prperiscal/900729941edc5d5ddaaf9e21e5055a62) to get more information on how everything integrates together and how the agile and continuous integration development should work.

# general-purpose-docker

Docker Compose to run the general purpose environment

This repository contains the needed scripts and docker compose files to execute the full environment or just 
piece of it. Allowing a completely local execution of the services and infrastructures required for development.

This files can also be helpful when coming to deploy the project on production.

## Getting Started

Get you a copy of the project with:
```
git clone https://github.com/prperiscal/general-purpose-docker
```

## How to use it

The three files that make the docker execution possible are:

* __docker-compose.yml__: tool for defining and running multi-container Docker services.
* __.env__: file for defining services, infrastructure and versions.
* __generalPurposeDocker.sh__: actual script to pull, start, stop or remove all or some of the services.

### Playing with the script

The generalPurposeDocker script can be executed with:

```
generalPurposeDocker <command> [ <service> ... ]
```

Commands:

    --help -h		-- Show this help
    --remove -rm	        -- Stop and remove all containers or only the specified ones
    --start -s  	        -- Start all or only the specified ones
    --stop  -st  	        -- Stop all or only the specified ones
    --update -u	 	-- Update all or only the specified ones and running them

If no services are specified it will take the ones defined inside the __.env__ file. 

####Some Examples:

* Run all the services and infrastructure:
If there is no image yet, it will be downloaded
```
generalPurposeDocker -s
```
* Run only the postgres and eureka services: 
```
generalPurposeDocker -s eureka-service postgres
```
* Update all environment:
This will pull all the images defined in the __.env__ 
```
generalPurposeDocker -u
```
* Stop all environment:
This will not remove the containers
```
generalPurposeDocker -st
```
* Remove eureka service:
This will stop and remove the container
```
generalPurposeDocker -rm eureka
```

## Include new services

The purpose of this project is to create a solid base for anyone to start his own project, therefore new services
and (probably) new infrastructure will have to be added.

To make it work, only three steps are need:

* Modify the __.env__ file to include the micro-service inside the "SERVICES" OR "INFRASTRUCTURE" property
* Include the version inside the __.env__
* Add the docker-compose configuration for the new service

Take into account that the service name set inside the docker-compose MUST be equal to the name added in the __.env__

## Authors

* **Pablo Rey Periscal** - *Initial work* -

See also the list of [contributors]() who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
