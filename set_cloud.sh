#!/usr/bin/bash

if [ -z "$CLOUD_TO_USE" ]; then
    echo "CLOUD_TO_USE environment variable must be set to one of the following: heurilyze"
    exit 1
fi

cloud_to_use=$(echo "$CLOUD_TO_USE" | tr '[:upper:]' '[:lower:]')
case $cloud_to_use in
heurilyze)
    message="The heurilyze inventory will be used."
    ;;
*)
    message="CLOUD_TO_USE environment variable was set to \"$CLOUD_TO_USE\" but must be set to one of the following: heurilyze"
    echo -e $message
    exit 1
    ;;
esac

echo -e "${message}"
