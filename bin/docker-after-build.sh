#!/usr/bin/env bash

# This file gets run after we build our docker image

# -----------------------------------
# Start the containers so that they can initialize and any images that the web server depends_on
# can be downloaded and initialized

docker-compose up -d

# -----------------------------------
# Sometimes we need to wait a bit for mysql to initialize, this has been very challenging to resolve.
# Some code examples below with varying degrees of success depending on the project

# docker-compose exec web bin/wait-for-it.sh mysql:3306 -- echo 'ready'

# sleep 5

# echo "Waiting for mysql container to respond"
# while [[ $(nc -vz 127.0.0.1 3306 2>&1) != *"succeeded"* ]]; do
#   printf '.'
#   sleep 1;
# done
# echo ''

# echo "Waiting for web server container to respond with text/html"
# while [[ $(curl -Is http://localhost:3000) != *"Content-Type: text/html"* ]]; do
#   printf '.'
#   sleep 1;
# done
# echo ''

# -----------------------------------
# Set up the database tables

# docker-compose exec web bin/rails db:setup

# -----------------------------------
# Shut down the containers

docker-compose stop
