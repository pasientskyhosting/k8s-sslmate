#!/bin/bash

function shut_down() {
    echo shutting down k8s-sslmate
    exit

}


if [ -z "${SSLMATE_API_KEY}" ];	then
    echo "Could not get env SSLMATE_API_KEY"
    
    exit 1
else
	DEC_KEY=$(echo -n ${SSLMATE_API_KEY} | base64 --decode)
    echo "api_key ${DEC_KEY}" > /root/.sslmate
    echo "key_directory /etc/sslmate/keys" >> /root/.sslmate
    echo "cert_directory /etc/sslmate" >> /root/.sslmate
    echo "wildcard_filename star" >> /root/.sslmate
fi

trap "shut_down" SIGKILL SIGTERM SIGHUP SIGINT EXIT


while true; do

    # if sslmate download --all > /dev/null
    if sslmate download --all; then
	    echo Downloaded new certs. Updating certs

    fi

    sleep ${SSLMATE_CHECKTIME:-360}

done
