#!/bin/bash
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
